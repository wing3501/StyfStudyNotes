//
//  MediaEditManager.swift
//  
//
//  Created by styf on 2022/10/26.
//

import UIKit
import AVFoundation
import Photos

enum YFMediaEditError: Error {
    case baseAssetLack
    case addCompositionTrackFail
    case exportFail
    case PHAuthorization
}

struct YFMediaEditResult {
    let composition: AVMutableComposition
    let videoComposition: AVMutableVideoComposition?
    let audioMix: AVMutableAudioMix?
}

class YFMediaEditManager {
    static let shared = YFMediaEditManager()
    let defaultSize = CGSize(width: 1080, height: 1920)
    let defaultImageDuration = CMTime(value: 5, timescale: 1)
    
    private var exportSession: AVAssetExportSession?
    private var exportProgressTimer: Timer?
}

class YFMedia {
    /// 视频
    let video: AVAsset?
    /// 视频需要加入创作的区间，默认整个视频
    let videoTimeRange: CMTimeRange?
    /// 图片
    let image: UIImage?
    /// 图片在创作中的持续时间
    let imageDuration: CMTime?
    
    init(video: AVAsset? = nil, videoTimeRange: CMTimeRange? = nil, image: UIImage? = nil, imageDuration: CMTime? = nil) {
        self.video = video
        self.videoTimeRange = videoTimeRange
        self.image = image
        self.imageDuration = imageDuration
    }
}

// MARK: - public
extension YFMediaEditManager {
    /// 图片生成视频
    /// - Parameters:
    ///   - image: 图片
    ///   - duration: 视频时长
    ///   - audioURL: 要插入的音频
    ///   - textDatas: 要插入的文字
    /// - Returns: 生成结果
    func generateVideoFrom(image: UIImage, duration: CMTime?, audioURL: URL?, textDatas: [YFTextData]?) throws -> YFMediaEditResult {
        // Black background video  ,Silence sound (in case video has no sound track)
        let (bgVideoAsset,silenceAsset) = try baseAsset()
        guard let bgVideoTrack = bgVideoAsset.tracks(withMediaType: .video).first,
              let silenceSoundTrack = silenceAsset.tracks(withMediaType: .audio).first else {
            throw YFMediaEditError.baseAssetLack
        }
        
        let videoDuration = duration ?? defaultImageDuration
        
        // Init composition
        let composition = AVMutableComposition()
        
        guard let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid),
              let compositionAudioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid) else { throw YFMediaEditError.addCompositionTrackFail }
        
        let cursorTime = CMTime.zero
        try compositionVideoTrack.insertTimeRange(CMTimeRange(start: .zero, duration: videoDuration), of: bgVideoTrack, at: cursorTime)
        // 循环音乐，填满创作音频轨道
        try insertAudio(audioURL, silenceSoundTrack, videoDuration, compositionAudioTrack)
        
        // Create Image layer
        let imageLayer = imageLayer(image)
        // 修正图片方向
        setOrientation(image: image, onLayer: imageLayer)
        
        // Init Video layer
        let videoLayer = CALayer()
        videoLayer.frame = CGRect(x: 0, y: 0, width: defaultSize.width, height: defaultSize.height)
        
        let parentlayer = CALayer()
        parentlayer.frame = CGRect(x: 0, y: 0, width: defaultSize.width, height: defaultSize.height)
        parentlayer.addSublayer(videoLayer)
        
        parentlayer.addSublayer(imageLayer)
        
        // Add Text layer
        if let textDatas {
            for aTextData in textDatas {
                let textLayer = makeTextLayer(string: aTextData.text,
                                              fontSize: aTextData.fontSize,
                                              textColor: UIColor.green,
                                              frame: aTextData.textFrame,
                                              showTime: aTextData.showTime,
                                              hideTime: aTextData.endTime)
                parentlayer.addSublayer(textLayer)
            }
        }
        
//        // Main video composition instruction
        let mainInstruction = AVMutableVideoCompositionInstruction()
        mainInstruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: videoDuration)
        
        // Main video composition
        let videoComposition = AVMutableVideoComposition()
        videoComposition.instructions = [mainInstruction]
        videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        videoComposition.renderSize = defaultSize
        videoComposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentlayer)
        
        return YFMediaEditResult(composition: composition, videoComposition: videoComposition, audioMix: nil)
    }
    
    /// 合并视频、图片
    /// - Parameters:
    ///   - medias: 图片或视频
    ///   - audioURL: 整个视频的配乐
    ///   - textDatas: 要插入的文字
    /// - Returns: 创作结果
    func merge(medias: [YFMedia], audioURL: URL?, textDatas: [YFTextData]?) throws -> YFMediaEditResult {
        // Black background video  ,Silence sound (in case video has no sound track)
        let (bgVideoAsset,silenceAsset) = try baseAsset()
        guard let bgVideoTrack = bgVideoAsset.tracks(withMediaType: .video).first,
              let silenceSoundTrack = silenceAsset.tracks(withMediaType: .audio).first else {
            throw YFMediaEditError.baseAssetLack
        }
        
        // Init composition
        let composition = AVMutableComposition()
        composition.naturalSize = defaultSize
        
        guard let compositionAudioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid) else { throw YFMediaEditError.addCompositionTrackFail }
        
        // 插入游标
        var cursorTime = CMTime.zero
        // 所有视频层指令
        var arrayLayerInstructions: [AVMutableVideoCompositionLayerInstruction] = []
        // 所有图片图层
        var arrayLayerImages: [CALayer] = []
        
        try medias.enumerated().forEach { (index, media) in
            if let asset = media.video,
               let assetVideoTrack = asset.tracks(withMediaType: .video).first {
                // 每个视频都使用一个新的视频创作轨道，是为了对每个轨道单独处理图层指令，处理位置、大小、方向
                guard let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid) else { throw YFMediaEditError.addCompositionTrackFail }
                
                let assetRange = media.videoTimeRange ?? asset.allTimeRange
                // 插入视频
                try compositionVideoTrack.insertTimeRange(assetRange, of: assetVideoTrack, at: cursorTime)
                // 如果没有配乐，就加入原声
                if audioURL == nil,
                   let assetAudioTrack = asset.tracks(withMediaType: .video).first {
                    //插入原声
                    try compositionAudioTrack.insertTimeRange(assetRange, of: assetAudioTrack, at: cursorTime)
                }
                
                // Add instruction for video track
                let layerInstruction = videoCompositionInstructionForTrack(track: compositionVideoTrack, asset: asset, targetSize: defaultSize)
                
                // Hide video track before changing to new track 隐藏当前视频层，否则视频层将一直存在
                let endTime = CMTimeAdd(cursorTime, assetRange.duration)
                let durationAnimation = 1.0.toCMTime()

                layerInstruction.setOpacityRamp(fromStartOpacity: 1.0, toEndOpacity: 0.0, timeRange: CMTimeRange.init(start: endTime, duration: durationAnimation))
                
                arrayLayerInstructions.append(layerInstruction)
                
                cursorTime = CMTimeAdd(cursorTime, assetRange.duration)
            }else if let image = media.image {
                guard let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid) else { throw YFMediaEditError.addCompositionTrackFail }
                
                let assetRange = CMTimeRange(start: .zero, duration: media.imageDuration ?? defaultImageDuration)
                // 插入黑色背景视频
                try compositionVideoTrack.insertTimeRange(assetRange, of: bgVideoTrack, at: cursorTime)
                // 如果没有配乐，就加入静默背景音乐
                if audioURL == nil {
                    try compositionAudioTrack.insertTimeRange(assetRange, of: silenceSoundTrack, at: cursorTime)
                }
                
                // Create Image layer
                let imageLayer = imageLayer(image)
                imageLayer.opacity = 0
                // 修正图片方向
                setOrientation(image: image, onLayer: imageLayer)
                
                // Add Fade in & Fade out animation
                let fadeInAnimation = CABasicAnimation.init(keyPath: "opacity")
                fadeInAnimation.duration = 1
                fadeInAnimation.fromValue = NSNumber(value: 0)
                fadeInAnimation.toValue = NSNumber(value: 1)
                fadeInAnimation.isRemovedOnCompletion = false
                fadeInAnimation.beginTime = cursorTime.seconds == 0 ? 0.05: cursorTime.seconds
                fadeInAnimation.fillMode = CAMediaTimingFillMode.forwards
                imageLayer.add(fadeInAnimation, forKey: "opacityIN")

                let fadeOutAnimation = CABasicAnimation.init(keyPath: "opacity")
                fadeOutAnimation.duration = 1
                fadeOutAnimation.fromValue = NSNumber(value: 1)
                fadeOutAnimation.toValue = NSNumber(value: 0)
                fadeOutAnimation.isRemovedOnCompletion = false
                fadeOutAnimation.beginTime = CMTimeAdd(cursorTime, assetRange.duration).seconds
                fadeOutAnimation.fillMode = CAMediaTimingFillMode.forwards
                imageLayer.add(fadeOutAnimation, forKey: "opacityOUT")
                
                arrayLayerImages.append(imageLayer)
                cursorTime = CMTimeAdd(cursorTime, assetRange.duration)
            }
        }
        // 最终整个视频的时间
        let videoTimeRange = CMTimeRangeMake(start: CMTime.zero, duration: cursorTime)
        // 如果有配乐，统一处理
        if let audioURL {
            // 循环音乐，填满创作音频轨道
            try insertAudio(audioURL, silenceSoundTrack, cursorTime, compositionAudioTrack)
        }
        
        // 图片图层、文字图层处理
        // Init Video layer
        let videoLayer = CALayer()
        videoLayer.frame = CGRect(x: 0, y: 0, width: defaultSize.width, height: defaultSize.height)
        
        let parentlayer = CALayer()
        parentlayer.frame = CGRect(x: 0, y: 0, width: defaultSize.width, height: defaultSize.height)
        parentlayer.addSublayer(videoLayer)
        
        // Add Image layers
        for layer in arrayLayerImages {
            parentlayer.addSublayer(layer)
        }
        
        // Add Text layer
        if let textDatas {
            for aTextData in textDatas {
                let textLayer = makeTextLayer(string: aTextData.text,
                                              fontSize: aTextData.fontSize,
                                              textColor: UIColor.green,
                                              frame: aTextData.textFrame,
                                              showTime: aTextData.showTime,
                                              hideTime: aTextData.endTime)
                parentlayer.addSublayer(textLayer)
            }
        }
        
        // Main video composition instruction
        let mainInstruction = AVMutableVideoCompositionInstruction()
        mainInstruction.timeRange = videoTimeRange
        mainInstruction.layerInstructions = arrayLayerInstructions
        
        // Main video composition
        let videoComposition = AVMutableVideoComposition()
        videoComposition.instructions = [mainInstruction]
        videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        videoComposition.renderSize = defaultSize
        videoComposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentlayer)
        
        return YFMediaEditResult(composition: composition, videoComposition: videoComposition, audioMix: nil)
    }
}

// MARK: - private
extension YFMediaEditManager {
    
    /// 生成图片图层
    /// - Parameter image: 图片
    /// - Returns: 图层
    private func imageLayer(_ image: UIImage) -> CALayer {
        let imageLayer = CALayer()
        imageLayer.frame = CGRect.init(origin: CGPoint.zero, size: defaultSize)
        imageLayer.contents = image.cgImage
        imageLayer.opacity = 1
        imageLayer.contentsGravity = CALayerContentsGravity.resizeAspect
        return imageLayer
    }
    
    /// 生成文字图层
    /// - Parameters:
    ///   - string: 文字内容
    ///   - fontSize: 字体
    ///   - textColor: 文字颜色
    ///   - frame: 大小 ⚠️ 坐标从左下角开始
    ///   - showTime: 显示时间
    ///   - hideTime: 隐藏时间
    /// - Returns: 文字图层
    private func makeTextLayer(string:String, fontSize:CGFloat, textColor:UIColor, frame:CGRect, showTime:CGFloat, hideTime:CGFloat) -> YFTextLayer {
        let textLayer = YFTextLayer()
        textLayer.string = string
        textLayer.fontSize = fontSize
        textLayer.foregroundColor = textColor.cgColor
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.opacity = 0
        textLayer.frame = frame
        textLayer.backgroundColor = UIColor.yellow.cgColor
        
        
        let fadeInAnimation = CABasicAnimation.init(keyPath: "opacity")
        fadeInAnimation.duration = 0.5
        fadeInAnimation.fromValue = NSNumber(value: 0)
        fadeInAnimation.toValue = NSNumber(value: 1)
        fadeInAnimation.isRemovedOnCompletion = false
        fadeInAnimation.beginTime = CFTimeInterval(showTime)
        fadeInAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        textLayer.add(fadeInAnimation, forKey: "textOpacityIN")
        
        if hideTime > 0 {
            let fadeOutAnimation = CABasicAnimation.init(keyPath: "opacity")
            fadeOutAnimation.duration = 1
            fadeOutAnimation.fromValue = NSNumber(value: 1)
            fadeOutAnimation.toValue = NSNumber(value: 0)
            fadeOutAnimation.isRemovedOnCompletion = false
            fadeOutAnimation.beginTime = CFTimeInterval(hideTime)
            fadeOutAnimation.fillMode = CAMediaTimingFillMode.forwards
            
            textLayer.add(fadeOutAnimation, forKey: "textOpacityOUT")
        }
        
        return textLayer
    }

    
    /// 循环音乐，填满创作音频轨道
    /// - Parameters:
    ///   - audioURL: 要插入的音乐
    ///   - silenceSoundTrack: 无声音频
    ///   - videoDuration: 视频长度
    ///   - compositionAudioTrack: 创作音轨
    private func insertAudio(_ audioURL: URL?,_ silenceSoundTrack: AVAssetTrack,_ videoDuration: CMTime,_ compositionAudioTrack: AVMutableCompositionTrack) throws {
        var cursorTime = CMTime.zero
        if let audioURL {
            let audioAsset = AVAsset(url: audioURL)
            if let audioAssetTrack = audioAsset.tracks(withMediaType: .audio).first {
                let audioAssetDuration = audioAsset.duration
                var leftDuation = videoDuration
                // 循环音乐，填满音频轨道
                while CMTimeGetSeconds(leftDuation) > 0 {
                    // 视频长度大于给的音频长度
                    if CMTimeGetSeconds(leftDuation) > CMTimeGetSeconds(audioAssetDuration) {
                        try compositionAudioTrack.insertTimeRange(CMTimeRange(start: .zero, duration: audioAssetDuration), of: audioAssetTrack, at: cursorTime)
                        cursorTime = CMTimeAdd(cursorTime, audioAssetDuration)
                        leftDuation = CMTimeSubtract(leftDuation, audioAssetDuration)
                    }else {
                        // 剩余部分
                        try compositionAudioTrack.insertTimeRange(CMTimeRange(start: .zero, duration: leftDuation), of: audioAssetTrack, at: cursorTime)
                        leftDuation = CMTimeSubtract(leftDuation, leftDuation)
                    }
                }
            }else {
                try compositionAudioTrack.insertTimeRange(CMTimeRange(start: .zero, duration: videoDuration), of: silenceSoundTrack, at: cursorTime)
            }
        }else {
            try compositionAudioTrack.insertTimeRange(CMTimeRange(start: .zero, duration: videoDuration), of: silenceSoundTrack, at: cursorTime)
        }
    }
    
    /// 获取空白视频、空白音频    ⚠️ 不能直接返回视频轨、音轨，添加时会报错-12780
    /// - Returns: 视频、音频
    private func baseAsset() throws -> (AVAsset, AVAsset) {
        guard let bgVideoURL = Bundle.main.url(forResource: "black", withExtension: "mov"),
              let silenceURL = Bundle.main.url(forResource: "silence", withExtension: "mp3") else {
            throw YFMediaEditError.baseAssetLack
        }
        let bgVideoAsset = AVAsset(url: bgVideoURL)
        let silenceAsset = AVAsset(url: silenceURL)
        
        return (bgVideoAsset, silenceAsset)
    }
    
    /// 修正图片方向
    /// - Parameters:
    ///   - image: 图片
    ///   - onLayer: 所在图层
    private func setOrientation(image:UIImage?, onLayer:CALayer) {
        guard let image = image else { return }

        if image.imageOrientation == UIImage.Orientation.up {
            // Do nothing
        }
        else if image.imageOrientation == UIImage.Orientation.left {
            let rotate = CGAffineTransform(rotationAngle: .pi/2)
            onLayer.setAffineTransform(rotate)
        }
        else if image.imageOrientation == UIImage.Orientation.down {
            let rotate = CGAffineTransform(rotationAngle: .pi)
            onLayer.setAffineTransform(rotate)
        }
        else if image.imageOrientation == UIImage.Orientation.right {
            let rotate = CGAffineTransform(rotationAngle: -.pi/2)
            onLayer.setAffineTransform(rotate)
        }
    }
    /// 返回修正方向、大小、位置后的视频层指令
    /// - Parameters:
    ///   - track: 创作视频轨
    ///   - asset: 插入的视频资源
    ///   - targetSize: 目标尺寸
    /// - Returns: 层指令
    private func videoCompositionInstructionForTrack(track: AVCompositionTrack, asset: AVAsset, targetSize: CGSize) -> AVMutableVideoCompositionLayerInstruction {
        
        let instruction = AVMutableVideoCompositionLayerInstruction(assetTrack: track)
        let assetTrack = asset.tracks(withMediaType: AVMediaType.video)[0]

        let transform = assetTrack.fixedPreferredTransform //修正后的形变
        let assetInfo = orientationFromTransform(transform)
        
        var scaleToFitRatio = targetSize.width / assetTrack.naturalSize.width
        if assetInfo.isPortrait {
            // Scale to fit target size
            scaleToFitRatio = targetSize.width / assetTrack.naturalSize.height
            let scaleFactor = CGAffineTransform(scaleX: scaleToFitRatio, y: scaleToFitRatio)
            
            // Align center Y
            let newY = targetSize.height/2 - (assetTrack.naturalSize.width * scaleToFitRatio)/2
            let moveCenterFactor = CGAffineTransform(translationX: 0, y: newY)
            
            let finalTransform = transform.concatenating(scaleFactor).concatenating(moveCenterFactor)

            instruction.setTransform(finalTransform, at: .zero)
        } else {
            // Scale to fit target size
            let scaleFactor = CGAffineTransform(scaleX: scaleToFitRatio, y: scaleToFitRatio)
            
            // Align center Y
            let newY = targetSize.height/2 - (assetTrack.naturalSize.height * scaleToFitRatio)/2
            let moveCenterFactor = CGAffineTransform(translationX: 0, y: newY)
            
            let finalTransform = transform.concatenating(scaleFactor).concatenating(moveCenterFactor)
            
            instruction.setTransform(finalTransform, at: .zero)
        }

        return instruction
    }
    
    /// 返回形变的方向
    /// - Parameter transform: 原来的形变
    /// - Returns: 方向
    private func orientationFromTransform(_ transform: CGAffineTransform) -> (orientation: UIImage.Orientation, isPortrait: Bool) {
        var assetOrientation = UIImage.Orientation.up
        var isPortrait = false
        
        switch [transform.a, transform.b, transform.c, transform.d] {
        case [0.0, 1.0, -1.0, 0.0]:
            assetOrientation = .right
            isPortrait = true
            
        case [0.0, -1.0, 1.0, 0.0]:
            assetOrientation = .left
            isPortrait = true
            
        case [1.0, 0.0, 0.0, 1.0]:
            assetOrientation = .up
            
        case [-1.0, 0.0, 0.0, -1.0]:
            assetOrientation = .down

        default:
            break
        }
    
        return (assetOrientation, isPortrait)
    }
}
// MARK: - 导出
extension YFMediaEditManager {
    
    /// 导出资源
    /// - Parameters:
    ///   - asset: 资源
    ///   - audioMix: 混音配置
    ///   - videoComposition: 视频创作
    ///   - completion: 回调
    func export(_ asset:AVAsset,_ audioMix: AVMutableAudioMix? = nil,_ videoComposition: AVVideoComposition? = nil, completion:  @escaping (Result<URL,Error>) -> Void) {
        exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
        exportSession?.outputURL = tempExportURL()
        exportSession?.outputFileType = .mp4
        exportSession?.audioMix = audioMix
        exportSession?.shouldOptimizeForNetworkUse = true
        exportSession?.videoComposition = videoComposition
        exportSession?.exportAsynchronously {[weak self] in
            DispatchQueue.main.async {
                self?.exportCompleted(completion: completion)
            }
        }
        exportProgressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateExportProgress(_:)), userInfo: exportSession, repeats: true)
    }
    
    /// 写入资源到相册
    /// - Parameters:
    ///   - assetURL: 资源路径
    ///   - completion: 回调
    func writeAssetToPhotoLibrary(_ assetURL: URL,_ completion:  @escaping (Error?) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                do {
                    try PHPhotoLibrary.shared().performChangesAndWait {
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: assetURL)
                    }
                    print("保存相册成功")
                    completion(nil)
                } catch {
                    print("保存相册失败:\(error) ")
                    completion(error)
                }
            } else {
                completion(YFMediaEditError.PHAuthorization)
            }
        }
    }
    
    /// 临时文件路径
    /// - Returns: 路径
    private func tempExportURL() -> URL {
        let filePath = NSTemporaryDirectory().appending("tempEditVideo.mp4")
        let url = URL(fileURLWithPath: filePath)
        FileManager.default.removeItemIfExisted(url)
        return url
    }
    
    /// 导出结束处理
    private func exportCompleted(completion:  @escaping (Result<URL,Error>) -> Void) {
        guard let videoURL = exportSession?.outputURL else { return }
        if let exportProgressTimer {
            exportProgressTimer.invalidate()
            self.exportProgressTimer = nil
        }
        
        if case .completed  = exportSession?.status {
            completion(.success(videoURL))
            print("导出视频成功")
            exportSession = nil
        }else {
            let error = exportSession?.error ?? YFMediaEditError.exportFail
            completion(.failure(error))
            print("导出视频出错:\(error)")
        }
    }
    
    /// 更新导出进度
    /// - Parameter timer: 定时器
    @objc private func updateExportProgress(_ timer: Timer) {
        guard let session = timer.userInfo as? AVAssetExportSession else { return }
        if session.status == .exporting {
            print("导出进度:\(session.progress)")
        }
    }
}

struct YFTextData {
    var text = ""
    var fontSize: CGFloat = 40
    var textColor = UIColor.red
    var showTime: CGFloat = 0
    var endTime: CGFloat = 0
    var textFrame = CGRect(x: 0, y: 0, width: 500, height: 500)
}

class YFTextLayer : CATextLayer {
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(layer: aDecoder)
    }
    
    override func draw(in ctx: CGContext) {
        let height = self.bounds.size.height
        let fontSize = self.fontSize
        let yDiff = (height-fontSize)/2 - fontSize/10
        
        ctx.saveGState()
        ctx.translateBy(x: 0.0, y: yDiff)
        super.draw(in: ctx)
        ctx.restoreGState()
    }
}
