/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

import CoreML
import Vision

// CoreML的基本使用
// 🐔 模型要求像素227
// 🐟 拖入模型文件，自动生成模型类

class ViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var cameraButton: UIButton!
  @IBOutlet var photoLibraryButton: UIButton!
  @IBOutlet var resultsView: UIView!
  @IBOutlet var resultsLabel: UILabel!
  @IBOutlet var resultsConstraint: NSLayoutConstraint!

//✅ 创建VNCoreMLRequest对象。通常创建一次此请求对象，并对要分类的每个图像重复使用它。不要每次要对图像进行分类时都创建新的请求对象，这是浪费。
        
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let configuration = MLModelConfiguration()
            let healthySnacks = try HealthySnacks(configuration: configuration)
            let visonModel = try VNCoreMLModel(for: healthySnacks.model)
            
            let request = VNCoreMLRequest(model: visonModel) {[weak self] request, error in
                //print("Request is finished!", request.results ?? "no result")
                self?.processObservations(for: request, error: error)
            }
            // ⚠️ imageCropAndScaleOption告诉Vision如何将照片调整到模型期望的227×227像素
            // ✅ Vision会自动将图像缩放到正确的大小
            request.imageCropAndScaleOption = .centerCrop // centerCrop scaleFill scaleFit
            return request
        } catch {
            fatalError("Failed to create VNCoreMLModel: \(error)")
        }
    }()

    
  var firstTime = true

  override func viewDidLoad() {
    super.viewDidLoad()
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    resultsView.alpha = 0
    resultsLabel.text = "choose or take a photo"
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Show the "choose or take a photo" hint when the app is opened.
    if firstTime {
      showResultsView(delay: 0.5)
      firstTime = false
    }
  }
  
  @IBAction func takePicture() {
    presentPhotoPicker(sourceType: .camera)
  }

  @IBAction func choosePhoto() {
    presentPhotoPicker(sourceType: .photoLibrary)
  }

  func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.sourceType = sourceType
    present(picker, animated: true)
    hideResultsView()
  }

  func showResultsView(delay: TimeInterval = 0.1) {
    resultsConstraint.constant = 100
    view.layoutIfNeeded()

    UIView.animate(withDuration: 0.5,
                   delay: delay,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 0.6,
                   options: .beginFromCurrentState,
                   animations: {
      self.resultsView.alpha = 1
      self.resultsConstraint.constant = -10
      self.view.layoutIfNeeded()
    },
    completion: nil)
  }

  func hideResultsView() {
    UIView.animate(withDuration: 0.3) {
      self.resultsView.alpha = 0
    }
  }
  /// 使用模型分析图片
  func classify(image: UIImage) {
      // HealthySnacks模型需要一个227×227的图像作为输入，但来自照片库或相机的图像将大得多，并且通常不是正方形的。Vision将自动调整图像大小并裁剪图像。
      // Vision还执行其他一些技巧，例如旋转图像，使其始终大小合适，并将图像的颜色与设备的颜色空间匹配。
      // Vision的工作方式是创建一个VNRequest对象，该对象描述了要执行的任务，然后使用VNImageRequestHandler执行请求。由于您将使用Vision运行核心ML模型，因此请求是名为VNCoreMLRequest的子类
      
      guard let ciImage = CIImage(image: image) else {
          // Vision更喜欢使用CGImage或CIImage对象
          // 使用CIImage的优势在于，它允许您对图像应用额外的Core Image变换，以进行更高级的图像处理。
          print("Unable to create CIImage")
          return
      }
      
      let orientation = CGImagePropertyOrientation(image.imageOrientation)// 该属性描述了绘制图像时的方向
      // 如果您在肖像模式下手持手机并拍摄照片，则其图像方向将为.右，表示相机已顺时针旋转90度。0度意味着手机处于横向位置，主页按钮位于右侧。
      
      DispatchQueue.global(qos: .userInitiated).async {
          let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
          do {
              try handler.perform([self.classificationRequest]) // 可以在同一图像上执行多个VNRequest
          } catch {
              print("Failed to perform classification: \(error)")
          }
      }
  }
    // 处理分析结果
    func processObservations(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            if let results = request.results as? [VNClassificationObservation] {
                if results.isEmpty {
                    self.resultsLabel.text = "nothing found"
                } else {
                    // ✅ Vision自动按置信度对结果进行排序，因此结果[0]包含置信度最高的类-获胜类
                    self.resultsLabel.text = String(format: "%@ %.1f%%",results[0].identifier, results[0].confidence * 100)
                }
                
                // ✅ 手动控制阈值
//                if results.isEmpty { ...
//                } else if results[0].confidence < 0.8 {
//                  self.resultsLabel.text = "not sure"
//                } else { ...
                    
            }else if let error {
                self.resultsLabel.text = "error: \(error.localizedDescription)"
            }else {
                self.resultsLabel.text = "???"
            }
            self.showResultsView()
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true)

	let image = info[.originalImage] as! UIImage
    imageView.image = image

    classify(image: image)
  }
}
