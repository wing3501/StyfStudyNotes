//
//  CoreMLViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/11/14.
//  https://developer.apple.com/documentation/coreml/downloading_and_compiling_a_model_on_the_user_s_device?language=objc

import UIKit
import SSZipArchive
import CoreML
import Vision

@objc(CoreMLViewController)
class CoreMLViewController: UIViewController {

    lazy var resultsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 250))
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.green.cgColor
        return label
    }()
    
    var visionModel: VNCoreMLModel?
    var videoCapture: VideoCapture!
    let semaphore = DispatchSemaphore(value: CoreMLViewController.maxInflightBuffers)
    var classificationRequests = [VNCoreMLRequest]()
    var inflightBuffer = 0
    static let maxInflightBuffers = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        guard let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
        let unzipPath = dirPath + "/models"
        if FileManager.default.fileExists(atPath: unzipPath) {
            try? FileManager.default.removeItem(atPath: unzipPath)
        }
        
        guard !FileManager.default.fileExists(atPath: unzipPath),
              let zipPath = Bundle.main.path(forResource: "WPTImageClassifier", ofType: "zip")
        else { return }
        print("解压目录:----\(unzipPath)")
        SSZipArchive.unzipFile(atPath: zipPath, toDestination: unzipPath)
        let modelFile = unzipPath + "/WPTImageClassifier.mlmodel"
        print("解压结束:----\(modelFile)")

        DispatchQueue.global().async {[weak self] in
            let modelDescriptionURL = URL(fileURLWithPath: modelFile)
            // 编译后的模型
            let start = Date()
            MLModel.compileModel(at: modelDescriptionURL, completionHandler: { result in
                switch result {
                    case .success(let compiledModelURL):
                        print("编译耗时：\(Date().timeIntervalSince(start)) s")
                    do {
                        let model = try MLModel(contentsOf: compiledModelURL)
                        // 持久化编译后的模型，拷贝到applicationSupport文件夹
                        let fileManager = FileManager.default
                        let appSupportURL = fileManager.urls(for: .applicationSupportDirectory,
                                                             in: .userDomainMask).first!
                        let compiledModelName = compiledModelURL.lastPathComponent
                        let permanentURL = appSupportURL.appendingPathComponent(compiledModelName)
                        _ = try fileManager.replaceItemAt(permanentURL, withItemAt: compiledModelURL)
                        
                        // 使用
                        self?.visionModel = try VNCoreMLModel(for: model)
                        self?.setUpVision()
                        self?.setUpCamera()
                        
                    } catch {
                        print("出错了---\(error)")
                    }
                   
                    case .failure(let error):
                        print("模型编译失败----\(error)")
                    
                }
            })
        }
        keyWindow?.addSubview(resultsLabel)
    }
    
    func setUpCamera() {
      videoCapture = VideoCapture()
      videoCapture.delegate = self

      // Change this line to limit how often the video capture delegate gets
      // called. 1 means it is called 30 times per second, which gives realtime
      // results but also uses more battery power.
      videoCapture.frameInterval = 1

      videoCapture.setUp(sessionPreset: .high) { success in
        if success {
          // Add the video preview into the UI.
          if let previewLayer = self.videoCapture.previewLayer {
            self.view.layer.addSublayer(previewLayer)
            self.resizePreviewLayer()
          }
          self.videoCapture.start()
        }
      }
    }
    
    func resizePreviewLayer() {
      videoCapture.previewLayer?.frame = view.bounds
    }
    
    func setUpVision() {
        if let visionModel {
            for _ in 0..<CoreMLViewController.maxInflightBuffers {
              let request = VNCoreMLRequest(model: visionModel, completionHandler: {
                [weak self] request, error in
                self?.processObservations(for: request, error: error)
              })

              request.imageCropAndScaleOption = .centerCrop
              classificationRequests.append(request)
            }
        }
    }
    
    func processObservations(for request: VNRequest, error: Error?) {
      DispatchQueue.main.async {
        if let results = request.results as? [VNClassificationObservation] {
          if results.isEmpty {
            self.resultsLabel.text = "nothing found"
          } else {
            let top3 = results.prefix(3).map { observation in
              String(format: "%@ %.1f%%", observation.identifier, observation.confidence * 100)
            }
            self.resultsLabel.text = top3.joined(separator: "\n")
          }
        } else if let error = error {
          self.resultsLabel.text = "error: \(error.localizedDescription)"
        } else {
          self.resultsLabel.text = "???"
        }
      }
    }
    
    func classify(sampleBuffer: CMSampleBuffer) {
      if let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
        // Tell Vision about the orientation of the image.
          let deviceOrientation = UInt32(UIDevice.current.orientation.rawValue)
          let orientation = CGImagePropertyOrientation(rawValue: deviceOrientation)!

        // Get additional info from the camera.
        var options: [VNImageOption : Any] = [:]
        if let cameraIntrinsicMatrix = CMGetAttachment(sampleBuffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil) {
          options[.cameraIntrinsics] = cameraIntrinsicMatrix
        }

        // The semaphore is used to block the VideoCapture queue and drop frames
        // when Core ML can't keep up.
        semaphore.wait()

        // For better throughput, we want to schedule multiple Vision requests
        // in parallel. These need to be separate instances, and inflightBuffer
        // is the index of the current request object to use.
        let request = self.classificationRequests[inflightBuffer]
        inflightBuffer += 1
        if inflightBuffer >= CoreMLViewController.maxInflightBuffers {
          inflightBuffer = 0
        }

        // For better throughput, perform the prediction on a background queue
        // instead of on the VideoCapture queue.
        DispatchQueue.global(qos: .userInitiated).async {
          let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: orientation, options: options)
          do {
            try handler.perform([request])
          } catch {
            print("Failed to perform classification: \(error)")
          }
          self.semaphore.signal()
        }
      }
    }
}


extension CoreMLViewController: VideoCaptureDelegate {
  func videoCapture(_ capture: VideoCapture, didCaptureVideoFrame sampleBuffer: CMSampleBuffer) {
    classify(sampleBuffer: sampleBuffer)
  }
}
