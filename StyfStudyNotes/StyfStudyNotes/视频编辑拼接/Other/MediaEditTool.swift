//
//  MediaEditTool.swift
//  SwiftApp
//
//  Created by styf on 2022/10/21.
//

import Foundation
import AVFoundation
import Photos
import UIKit

enum MediaEditError: Error {
    case baseVideo(message: String)
    case other(message: String)
    case export(message: String?)
}

class MediaEditTool {
    static let shared = MediaEditTool()
    
    private var videoWidth: CGFloat = 1080
    private var videoHeight: CGFloat = 1920
    
    /// 图片生成视频
    /// - Parameters:
    ///   - image: 图片
    ///   - duration: 视频时长
    /// - Returns: 组合
    func video(from image: UIImage,_ duration: CMTime) throws -> (AVMutableComposition, AVVideoComposition) {
        guard let url = Bundle.main.url(forResource: "baseVideo2", withExtension: "mp4") else {
            throw MediaEditError.baseVideo(message: "找不到baseVideo.mp4")
        }
        let asset = AVAsset(url: url)
        guard let videoTrack = asset.tracks(withMediaType: .video).first else {
            throw MediaEditError.baseVideo(message: "baseVideo.mp4有误")
        }
        
        let composition = AVMutableComposition()
        guard let compositionVideoTrack = composition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid) else { throw MediaEditError.other(message: "添加视频轨道失败") }
        
        try compositionVideoTrack.insertTimeRange(CMTimeRange(start: .zero, duration: duration), of: videoTrack, at: .zero)
        
        let videolayer = CALayer()
        videolayer.frame = CGRect(x: 0, y: 0, width: videoWidth, height: videoHeight)

        let parentlayer = CALayer()
        parentlayer.frame = CGRect(x: 0, y: 0, width: videoWidth, height: videoHeight)
        parentlayer.addSublayer(videolayer)
        
        let horizontalRatio = videoWidth / image.size.width
        let verticalRatio = videoHeight / image.size.height
        let aspectRatio = min(horizontalRatio, verticalRatio)
        let newSize: CGSize = CGSize(width: image.size.width * aspectRatio, height: image.size.height * aspectRatio)
        let x = newSize.width < videoWidth ? (videoWidth - newSize.width) / 2 : 0
        let y = newSize.height < videoHeight ? (videoHeight - newSize.height) / 2 : 0

        let blackLayer = CALayer()
        blackLayer.frame = CGRect(x: 0, y: 0, width: videoWidth, height: videoHeight)
        blackLayer.backgroundColor = UIColor.black.cgColor

        let imageLayer = CALayer()
        imageLayer.backgroundColor = UIColor.black.cgColor
        imageLayer.frame = CGRect(x: x, y: y, width: newSize.width, height: newSize.height)
        imageLayer.contents = image.cgImage
        blackLayer.addSublayer(imageLayer)

        parentlayer.addSublayer(blackLayer)
        
        let videoComposition = AVMutableVideoComposition()
        videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        videoComposition.renderSize = CGSize(width: videoWidth, height: videoHeight)
        videoComposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videolayer, in: parentlayer)
        
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: composition.duration)
        let layerinstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: compositionVideoTrack)
        MediaEditTool.fixVideoTransform(videoTrack: videoTrack, targetVideoSize: CGSize(width: videoWidth, height: videoHeight), layerInstruction: layerinstruction)
        instruction.layerInstructions = [layerinstruction]
        videoComposition.instructions = [instruction]
        
        return (composition,videoComposition)
    }
    
    /// 合并多个视频
    /// - Parameters:
    ///   - videoTuples: 视频路径、要插入的区间
    ///   - audioURL: 音频路径
    /// - Returns: 组合
    func merge(_ urlTuples: [(URL,CMTimeRange?)],_ audioURL: URL?,_ transitionDuration: CMTime = .zero) -> (AVMutableComposition,AVVideoComposition) {
        // 加载资源
        let videoAssetsTuples = urlTuples.map { (url, range) in
            // 使用AVURLAssetPreferPreciseDurationAndTimingKey在载入时就计算时长
            (AVURLAsset(url: url, options: [AVURLAssetPreferPreciseDurationAndTimingKey: true]),range)
        }
        return mergeVideos(videoAssetsTuples, audioURL, transitionDuration)
    }
    
    /// 合并多个视频
    /// - Parameters:
    ///   - videoTuples: 视频路径、要插入的区间
    ///   - audioURL: 音频路径
    /// - Returns: 组合
    func mergeVideos(_ videoTuples: [(AVAsset,CMTimeRange?)],_ audioURL: URL?,_ transitionDuration: CMTime = .zero) -> (AVMutableComposition,AVVideoComposition) {
        
        let videoAssets = videoTuples.map({$0.0})
        
        let audioAsset = audioURL != nil ? AVURLAsset(url: audioURL!, options: [AVURLAssetPreferPreciseDurationAndTimingKey: true]): nil
        // 创建组合、轨道
        let composition = AVMutableComposition()
        composition.naturalSize = CGSize(width: videoWidth, height: videoHeight)
        // 使用两个视频轨道错开，用来做转场效果
        let videoTrack1 = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let videoTrack2 = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let videoTracks = [videoTrack1,videoTrack2]
        let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        // 将独立的媒体片段插入轨道内
        var cursorTime = CMTime.zero
//        let transitionDuration = CMTime(value: 1, timescale: 1) //转场时间1秒
        // "通过"的时间范围：希望单一轨道不进行混合地通过的区域
        var passThroughTimeRanges: [NSValue] = []
        // "过渡"的时间范围：组合中视频片段重合的，用来应用过渡效果的区域
        var transitionTimeRanges: [NSValue] = []
        // 所有视频轨道
        var assetVideoTracks: [AVAssetTrack] = []
        
        // 多视频轨道
        videoAssets.enumerated().forEach { (index, asset) in
            if let assetTrack = asset.tracks(withMediaType: .video).first {
                assetVideoTracks.append(assetTrack)
                
                let trackIndex = index % 2
                let assetRange = videoTuples[index].1 ?? asset.allTimeRange
                do {
                    var passRange = CMTimeRange(start: cursorTime, duration: assetRange.duration)
                    // 计算通过区域
                    if index > 0 {
                        //设置为下一段“通过”区域的起点
                        passRange.start = CMTimeAdd(passRange.start, transitionDuration)
                        passRange.duration = CMTimeSubtract(passRange.duration, transitionDuration)
                    }
                    if index + 1 < videoAssets.count {
                        passRange.duration = CMTimeSubtract(passRange.duration, transitionDuration)
                    }
                    passThroughTimeRanges.append(NSValue(timeRange: passRange))
                    // 插入轨道
                    try videoTracks[trackIndex]?.insertTimeRange(assetRange, of: assetTrack, at: cursorTime)
                    cursorTime = CMTimeAdd(cursorTime, assetRange.duration)
                    //减去转场时间，让视频轨道内容交界处有重叠
                    cursorTime = CMTimeSubtract(cursorTime, transitionDuration)
                    
                    if index + 1 < videoAssets.count {
                        // 计算重叠区域
                        passRange = CMTimeRange(start: cursorTime, duration: transitionDuration)
                        if !(transitionDuration == .zero) {
                            transitionTimeRanges.append(NSValue(timeRange: passRange))
                        }
                    }
                } catch {
                    print("插入视频片段到轨道失败:\(index) \(error.localizedDescription)")
                }
            }
        }
        
        let transitions = transitionTimeRanges.map({ VideoTransition(type: .dissolve, timeRange: $0.timeRangeValue, duration: transitionDuration, direction: .leftToRight) })
        
        // 手动创建组合和层指令
//        let videoComposition = self.buildVideoCompositionAndInstructions(composition, passThroughTimeRanges, transitionTimeRanges)
        
        // 只处理过渡指令
//        let videoComposition = buildVideoComposition(composition, transitions)
        
        let videoComposition = buildVideoComposition(composition, assetVideoTracks , passThroughTimeRanges, transitionTimeRanges, transitions)
        
        // 将音频插入整个轨道
        if let audioAsset,
           let assetTrack = audioAsset.tracks(withMediaType: .audio).first {
            do {
                cursorTime = .zero
                try audioTrack?.insertTimeRange(composition.allTimeRange, of: assetTrack, at: cursorTime)
            } catch {
                print("插入音频片段到轨道失败: \(error.localizedDescription)")
            }
        }
        
        return (composition, videoComposition)
    }
    
    /// 合并多个视频 单轨道
    /// - Parameters:
    ///   - videoTuples: 视频路径、要插入的区间
    ///   - audioURL: 音频路径
    /// - Returns: 组合
    func mergeVideosSingleTrack(_ videoTuples: [(AVAsset,CMTimeRange?)],_ audioURL: URL?) -> (AVMutableComposition,AVVideoComposition) {
        
        let videoAssets = videoTuples.map({$0.0})
        
        let audioAsset = audioURL != nil ? AVURLAsset(url: audioURL!, options: [AVURLAssetPreferPreciseDurationAndTimingKey: true]): nil
        // 创建组合、轨道
        let composition = AVMutableComposition()
        composition.naturalSize = CGSize(width: videoWidth, height: videoHeight)
        // 使用一个轨道
        let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        // 将独立的媒体片段插入轨道内
        var cursorTime = CMTime.zero
        // 所有视频轨道
        var assetVideoTracks: [AVAssetTrack] = []
        var passThroughTimeRanges: [NSValue] = []
        
        // 所有指令
        var compositionInstructions: [AVMutableVideoCompositionInstruction] = []
        
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = CGSize(width: videoWidth, height: videoHeight)
        videoComposition.frameDuration = CMTime(value: 1, timescale: 30)
        
        // 单视频轨道
        videoAssets.enumerated().forEach { (index, asset) in
            if let assetTrack = asset.tracks(withMediaType: .video).first {
                assetVideoTracks.append(assetTrack)
                
                let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
                
                let assetRange = videoTuples[index].1 ?? asset.allTimeRange
                do {
                    let passRange = CMTimeRange(start: cursorTime, duration: assetRange.duration)
                    passThroughTimeRanges.append(NSValue(timeRange: passRange))
                    // 插入轨道
                    try compositionVideoTrack?.insertTimeRange(assetRange, of: assetTrack, at: cursorTime)
                    cursorTime = CMTimeAdd(cursorTime, assetRange.duration)
                    
                    // 处理“通过“区域图层
                    let instruction = AVMutableVideoCompositionInstruction()
                    instruction.timeRange = passRange
                    let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: compositionVideoTrack!)
                    MediaEditTool.fixVideoTransform(videoTrack: assetTrack, targetVideoSize: videoComposition.renderSize, layerInstruction: layerInstruction)
                    instruction.layerInstructions = [layerInstruction]
                    compositionInstructions.append(instruction)
                } catch {
                    print("插入视频片段到轨道失败:\(index) \(error.localizedDescription)")
                }
            }
        }

        videoComposition.instructions = compositionInstructions
        
        // 将音频插入整个轨道
        if let audioAsset,
           let assetTrack = audioAsset.tracks(withMediaType: .audio).first {
            do {
                cursorTime = .zero
                try audioTrack?.insertTimeRange(composition.allTimeRange, of: assetTrack, at: cursorTime)
            } catch {
                print("插入音频片段到轨道失败: \(error.localizedDescription)")
            }
        }
        
        return (composition, videoComposition)
    }
    
    
    var exportSession: AVAssetExportSession?
    var exporting = false
    var exportProgress: Float = 0 {
        didSet {
            print("导出进度:\(exportProgress)")
        }
    }
    
    /// 导出一个资源到相册
    /// - Parameter asset: 资源
    func export(_ asset:AVAsset,_ audioMix: AVMutableAudioMix? = nil,_ videoComposition: AVVideoComposition? = nil, completion:  @escaping (Result<URL,Error>) -> Void) {
        exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
        let videoURL = self.tempExportURL()
        exportSession?.outputURL = videoURL
        exportSession?.outputFileType = .mp4
        exportSession?.audioMix = audioMix
        exportSession?.shouldOptimizeForNetworkUse = true
        exportSession?.videoComposition = videoComposition
        exportSession?.exportAsynchronously {[weak self] in
            DispatchQueue.main.async {
                if case .completed  = self?.exportSession?.status {
                    do {
                        try self?.writeExportedVideoToAssetsLibrary(videoURL)
                        completion(.success(videoURL))
                        print("导出视频成功")
                    } catch {
                        completion(.failure(error))
                        print("保存视频到相册失败:\(error.localizedDescription)")
                    }
                    try? FileManager.default.removeItem(at: videoURL)
                    self?.exportSession = nil
                }else {
                    let error = self?.exportSession?.error ?? MediaEditError.export(message: "导出视频出错")
                    completion(.failure(error))
                    print("导出视频出错:\(error)")
                }
            }
        }
        exporting = true
        monitorExportProgress()
    }
    
    /// 临时文件路径
    /// - Returns: 路径
    func tempExportURL() -> URL {
        var filePath = NSTemporaryDirectory()
        filePath.append("\(UUID()).mp4")
        return URL(fileURLWithPath: filePath)
    }
    
    /// 观察导出进度
    func monitorExportProgress() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {[weak self] in
            if let exportSession = self?.exportSession,
               exportSession.status == .exporting {
                self?.exportProgress = exportSession.progress
                self?.monitorExportProgress()
            }else {
                self?.exporting = false
                self?.exportProgress = 0
            }
        }
    }
    
    /// 写入资源到相册
    /// - Parameter assetURL: 资源路径
    func writeExportedVideoToAssetsLibrary(_ assetURL: URL) throws {
        try PHPhotoLibrary.shared().performChangesAndWait {
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: assetURL)
        }
    }
    
    /// 构建混音配置
    /// - Parameters:
    ///   - track: 音轨
    ///   - volumeAutomations: 音量变化
    /// - Returns: 混音设置
    func buildAudioMix(_ track: AVCompositionTrack,_ volumeAutomations: [(Float,Float,CMTimeRange)]) -> AVAudioMix? {
        guard !volumeAutomations.isEmpty else { return nil }
        let audioMix = AVMutableAudioMix()
        let parameters = AVMutableAudioMixInputParameters(track: track)
        for (startVolume, endVolume, timeRange) in volumeAutomations {
            parameters.setVolumeRamp(fromStartVolume: startVolume, toEndVolume: endVolume, timeRange: timeRange)
        }
        audioMix.inputParameters = [parameters]
        return audioMix
    }
    
    ///  完全手动创建组合和层指令
    /// - Parameters:
    ///   - composition: 组合
    ///   - passThroughTimeRanges: "通过"的区域时间
    ///   - transitionTimeRanges: "过渡"的区域时间
    /// - Returns: 视频组合
    private func buildVideoCompositionAndInstructions(_ composition: AVComposition,_ passThroughTimeRanges: [NSValue],_ transitionTimeRanges: [NSValue]) -> AVMutableVideoComposition {
        var compositionInstructions: [AVMutableVideoCompositionInstruction] = []
        let tracks = composition.tracks(withMediaType: .video)
        
        passThroughTimeRanges.enumerated().forEach { (index, timeRange) in
            let trackIndex = index % 2
            let currentTrack = tracks[trackIndex]
            
            // 处理“通过“区域图层
            let instruction = AVMutableVideoCompositionInstruction()
            instruction.timeRange = timeRange.timeRangeValue
            let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: currentTrack)
            instruction.layerInstructions = [layerInstruction]
            
            compositionInstructions.append(instruction)
            // 处理“过渡”区域图层
            if index < transitionTimeRanges.count {
                let foregroundTrack = tracks[trackIndex]
                let backgroundTrack = tracks[1 - trackIndex]
                
                let instruction = AVMutableVideoCompositionInstruction()
                instruction.timeRange = transitionTimeRanges[index].timeRangeValue
                
                let fromLayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: foregroundTrack)
                let toLayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: backgroundTrack)
                instruction.layerInstructions = [fromLayerInstruction, toLayerInstruction]
                compositionInstructions.append(instruction)
            }
        }
//        let videoComposition = AVMutableVideoComposition()
//        videoComposition.instructions = compositionInstructions
//        videoComposition.renderSize = CGSize(width: 1280, height: 720)
//        videoComposition.frameDuration = CMTime(value: 1, timescale: 30)
//        videoComposition.renderScale = 1;
    
        let videoComposition = AVMutableVideoComposition(propertiesOf: composition)
        videoComposition.instructions = compositionInstructions
        return videoComposition
    }
    
    /// 创建组合和层指令、设置转场、修正方向位置
    func buildVideoComposition(_ composition: AVComposition,_ assetVideoTracks : [AVAssetTrack],_ passThroughTimeRanges: [NSValue],_ transitionTimeRanges: [NSValue],_ transitions: [VideoTransition]) -> AVMutableVideoComposition {
        
        let videoComposition = AVMutableVideoComposition(propertiesOf: composition)
        videoComposition.renderSize = CGSize(width: videoWidth, height: videoHeight)
        // 需要做转场的指令
        var transitionInstructions: [VideoTransitionInstruction] = []
        var transitionIndex = 0
        // 所有指令
        var compositionInstructions: [AVMutableVideoCompositionInstruction] = []
        let tracks = composition.tracks(withMediaType: .video)
        
        assetVideoTracks.enumerated().forEach { (index, assetVideoTrack) in
            let trackIndex = index % 2
            let currentTrack = tracks[trackIndex]
            
            // 处理“通过“区域图层
            let instruction = AVMutableVideoCompositionInstruction()
            instruction.timeRange = passThroughTimeRanges[index].timeRangeValue
            let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: currentTrack)
            MediaEditTool.fixVideoTransform(videoTrack: assetVideoTrack, targetVideoSize: videoComposition.renderSize, layerInstruction: layerInstruction)
            instruction.layerInstructions = [layerInstruction]
            
            compositionInstructions.append(instruction)
            // 处理“过渡”区域图层
            if index < transitionTimeRanges.count {
                let foregroundTrack = tracks[trackIndex]
                let backgroundTrack = tracks[1 - trackIndex]
                
                let instruction = AVMutableVideoCompositionInstruction()
                instruction.timeRange = transitionTimeRanges[index].timeRangeValue
                
                let fromLayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: foregroundTrack)
                let toLayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: backgroundTrack)
                MediaEditTool.fixVideoTransform(videoTrack: assetVideoTrack, targetVideoSize: videoComposition.renderSize, layerInstruction: fromLayerInstruction)
                MediaEditTool.fixVideoTransform(videoTrack: assetVideoTracks[index + 1], targetVideoSize: videoComposition.renderSize, layerInstruction: toLayerInstruction)
                
                instruction.layerInstructions = [fromLayerInstruction, toLayerInstruction]
                compositionInstructions.append(instruction)
                // 收集需要做转场动画的信息
                transitionInstructions.append(VideoTransitionInstruction(compositionInstruction: instruction, fromLayerInstruction: fromLayerInstruction, toLayerInstruction: toLayerInstruction, transition: transitions[transitionIndex]))
                transitionIndex += 1
            }
        }
        
        videoComposition.instructions = compositionInstructions
        
        // 过渡指令设置转场
        transitionInstructions.forEach { instruction in
            let timeRange = instruction.compositionInstruction.timeRange
            let fromLayer = instruction.fromLayerInstruction
            let toLayer = instruction.toLayerInstruction
            
            // 设置转场效果
            switch instruction.transition.type {
            case .dissolve:
                fromLayer.setOpacityRamp(fromStartOpacity: 1, toEndOpacity: 0, timeRange: timeRange)
            case .push:
                let identityTransform = CGAffineTransformIdentity
                let videoWidth = videoComposition.renderSize.width
                let fromDestTransform = CGAffineTransformMakeTranslation(-videoWidth, 0)
                let toStartTransform = CGAffineTransformMakeTranslation(videoWidth, 0)
                fromLayer.setTransformRamp(fromStart: identityTransform, toEnd: fromDestTransform, timeRange: timeRange)
                toLayer.setTransformRamp(fromStart: toStartTransform, toEnd: identityTransform, timeRange: timeRange)
            case .wipe:
                let videoWidth = videoComposition.renderSize.width
                let videoHeight = videoComposition.renderSize.height
                let startRect = CGRect(x: 0, y: 0, width: videoWidth, height: videoHeight)
                let endRect = CGRect(x: 0, y: videoHeight, width: videoWidth, height: 0)
                fromLayer.setCropRectangleRamp(fromStartCropRectangle: startRect, toEndCropRectangle: endRect, timeRange: timeRange)
            default:
                print("None")
            }
            instruction.compositionInstruction.layerInstructions = [fromLayer, toLayer]
        }
        return videoComposition
    }
    
    /// 创建组合和层指令
    func buildVideoComposition(_ composition: AVComposition,_ transitions: [VideoTransition]) -> AVVideoComposition {
        let videoComposition = AVMutableVideoComposition(propertiesOf: composition)
        // 提取过渡指令
        let transitionInstructions = transitionInstructions(in: videoComposition, transitions)
        transitionInstructions.forEach { instruction in
            let timeRange = instruction.compositionInstruction.timeRange
            let fromLayer = instruction.fromLayerInstruction
            let toLayer = instruction.toLayerInstruction
            
            // 设置转场效果
            switch instruction.transition.type {
            case .dissolve:
                fromLayer.setOpacityRamp(fromStartOpacity: 1, toEndOpacity: 0, timeRange: timeRange)
            case .push:
                let identityTransform = CGAffineTransformIdentity
                let videoWidth = videoComposition.renderSize.width
                let fromDestTransform = CGAffineTransformMakeTranslation(-videoWidth, 0)
                let toStartTransform = CGAffineTransformMakeTranslation(videoWidth, 0)
                fromLayer.setTransformRamp(fromStart: identityTransform, toEnd: fromDestTransform, timeRange: timeRange)
                toLayer.setTransformRamp(fromStart: toStartTransform, toEnd: identityTransform, timeRange: timeRange)
            case .wipe:
                let videoWidth = videoComposition.renderSize.width
                let videoHeight = videoComposition.renderSize.height
                let startRect = CGRect(x: 0, y: 0, width: videoWidth, height: videoHeight)
                let endRect = CGRect(x: 0, y: videoHeight, width: videoWidth, height: 0)
                fromLayer.setCropRectangleRamp(fromStartCropRectangle: startRect, toEndCropRectangle: endRect, timeRange: timeRange)
            default:
                print("None")
            }
            instruction.compositionInstruction.layerInstructions = [fromLayer, toLayer]
        }
        return videoComposition
    }
    // 提取过渡指令
    func transitionInstructions(in videoComposition: AVVideoComposition,_ transitions: [VideoTransition]) -> [VideoTransitionInstruction] {
        var transitionInstructions: [VideoTransitionInstruction] = []
        var layerInstructionIndex = 1
        var transitionIndex = 0
        if let compositionInstructions = videoComposition.instructions as? [AVMutableVideoCompositionInstruction] {
            compositionInstructions.enumerated().forEach { (index,compositionInstruction) in
                let layerInstructions = compositionInstruction.layerInstructions
                if layerInstructions.count == 2 { // 需要做转场的组合指令
                    let instruction = VideoTransitionInstruction(
                        compositionInstruction: compositionInstruction,
                        fromLayerInstruction: layerInstructions[1 - layerInstructionIndex] as! AVMutableVideoCompositionLayerInstruction,
                        toLayerInstruction: layerInstructions[layerInstructionIndex] as! AVMutableVideoCompositionLayerInstruction,
                        transition: transitions[transitionIndex])
                    transitionInstructions.append(instruction)
                    layerInstructionIndex = layerInstructionIndex == 1 ? 0 : 1
                    transitionIndex += 1
                }
            }
        }
        return transitionInstructions
    }
}


extension MediaEditTool {
    // 视频角度
    static func degress(of assetVideoTrack: AVAssetTrack) -> Int {
        let t = assetVideoTrack.preferredTransform
        switch(t.a,t.b,t.c,t.d) {
        case (0, 1.0, -1.0, 0):
            return 90 //Portrait
        case (0, -1.0, 1.0, 0):
            return 270 //PortraitUpsideDown
        case (1.0, 0, 0, 1.0):
            return 0 // LandscapeRight
        case (-1.0, 0, 0, -1.0):
            return 180 //LandscapeLeft
        default:
            return 90
        }
    }
    
    /// 修正视频方向、位置、尺寸
    /// - Parameters:
    ///   - videoTrack: 原视频轨道
    ///   - targetVideoSize: 目标视频尺寸
    ///   - layerInstruction: 层指令
    static func fixVideoTransform(videoTrack: AVAssetTrack, targetVideoSize: CGSize, layerInstruction: AVMutableVideoCompositionLayerInstruction) {
        var natureSize = videoTrack.naturalSize
        if degress(of: videoTrack) == 90 {
            natureSize = CGSize(width: natureSize.height, height: natureSize.width)
        }
        if (Int)(natureSize.width) % 2 != 0 {
            natureSize.width += 1.0
        }
        
        // 按竖屏处理，让视频层居中
        if degress(of: videoTrack) == 90 {
            let height = targetVideoSize.width * natureSize.height / natureSize.width
            let translateToCenter = CGAffineTransform.init(translationX: targetVideoSize.width, y: targetVideoSize.height/2 - natureSize.height/2)
            let t = translateToCenter.scaledBy(x:targetVideoSize.width/natureSize.width, y: height/natureSize.height)
            let mixedTransform = t.rotated(by: .pi/2)
            layerInstruction.setTransform(mixedTransform, at: .zero)
        }else if degress(of: videoTrack) == 180 {
            let height = targetVideoSize.width * natureSize.height / natureSize.width
            let t = CGAffineTransform(translationX: targetVideoSize.width, y: targetVideoSize.height * 0.5 + height * 0.5)
            let t1 = t.scaledBy(x:targetVideoSize.width/natureSize.width, y: height/natureSize.height)
            let t2 = t1.rotated(by: .pi)
            layerInstruction.setTransform(t2, at: .zero)
        }else{
            let height = targetVideoSize.width * natureSize.height / natureSize.width
            let translateToCenter = CGAffineTransform.init(translationX: 0, y: targetVideoSize.height/2 - height/2)
            let t = translateToCenter.scaledBy(x:targetVideoSize.width/natureSize.width, y: height/natureSize.height)
            layerInstruction.setTransform(t, at: .zero)
        }
    }
}
