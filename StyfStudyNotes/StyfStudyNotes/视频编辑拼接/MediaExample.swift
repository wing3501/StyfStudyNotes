//
//  CMTimeExample.swift
//  SwiftApp
//
//  Created by styf on 2022/10/19.
//

import UIKit
import AVFoundation

class MediaExample: NSObject {
    
    func CMTimeExample() {
        // 0.5 秒
        let _ = CMTime(value: 1, timescale: 2)
        // 5秒
        let _ = CMTime(value: 5, timescale: 1)
        // 0
        let _: CMTime = .zero
        
        // 3秒
        let _ = CMTime(value: 3, timescale: 1)
        let _ = CMTime(value: 1800, timescale: 600)
        let _ = CMTime(value: 3000, timescale: 1000)
        let _ = CMTime(value: 132300, timescale: 44100)
        // 打印时间
        CMTimeShow(CMTime(value: 3, timescale: 1))
        // 时间相加
        let time1 = CMTime(value: 5, timescale: 1)
        let time2 = CMTime(value: 3, timescale: 1)
        var result = CMTimeAdd(time1, time2) // 8s
        // 时间相减
        result = CMTimeSubtract(time1, time2) // 2s
        // CMTimeRange由两个CMTime组成，第一个定义时间范围起点，第二个定义时间范围的持续时间
        // 从5秒开始，持续5秒
        let fiveSecondsTime = CMTime(value: 5, timescale: 1)
        let _ = CMTimeRange(start: fiveSecondsTime, duration: fiveSecondsTime)
        // 另一个初始化方式 起点到终点
        let tenSecondsTime = CMTime(value: 10, timescale: 1)
        let _ = CMTimeRange(start: fiveSecondsTime, end: tenSecondsTime)
        // 交集
        let range1 = CMTimeRange(start: CMTime.zero, duration: CMTime(value: 5, timescale: 1))
        let range2 = CMTimeRange(start: CMTime(value: 2, timescale: 1), end: CMTime(value: 5, timescale: 1))
        let intersectionRange = CMTimeRangeGetIntersection(range1, otherRange: range2)
        // 并集
        let unionRange = CMTimeRangeGetUnion(range1, otherRange: range2)
    }
    
    func audioMixInputParametersExample() {
        let composition = AVMutableComposition()
        let track = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        let twoSeconds = CMTime(value: 2, timescale: 1)
        let fourSeconds = CMTime(value: 4, timescale: 1)
        let sevenSeconds = CMTime(value: 7, timescale: 1)
        
        let parameters = AVMutableAudioMixInputParameters(track: track)
        // 起始音量设为一半
        parameters.setVolume(0.5, at: CMTime.zero)
        // 2秒到4秒，声音渐变到0.8
        let range = CMTimeRange(start: twoSeconds, end: fourSeconds)
        parameters.setVolumeRamp(fromStartVolume: 0.5, toEndVolume: 0.8, timeRange: range)
        // 第7秒的时候，声音掉到0.3
        parameters.setVolume(0.3, at: sevenSeconds)
        
        let audioMix = AVMutableAudioMix()
        audioMix.inputParameters = [parameters]
        // 在播放时使用
        let playerItem = AVPlayerItem(asset: composition)
        playerItem.audioMix = audioMix
        
        // 在导出时使用
        let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)
        exportSession?.audioMix = audioMix
    }
}
