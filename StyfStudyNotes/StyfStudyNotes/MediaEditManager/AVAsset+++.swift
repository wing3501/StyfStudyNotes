//
//  AVAsset+++.swift
//  
//
//  Created by styf on 2022/10/19.
//

import Foundation
import AVFoundation

extension AVAsset {
    
    /// 获取标题，注意提前加载Key "commonMetadata"
    var title: String {
        let status = self.statusOfValue(forKey: "commonMetadata", error: nil)
        if status == .loaded {
            let items = AVMetadataItem.metadataItems(from: self.commonMetadata, withKey: AVMetadataKey.commonKeyTitle, keySpace: AVMetadataKeySpace.common)
            if !items.isEmpty,
               let titleItem = items.first,
               let title = titleItem.value as? String{
                return title
            }
        }
        return ""
    }
    
    /// 所有字幕特征的标题，注意提前加载Key "availableMediaCharacteristicsWithMediaSelectionOptions"
    var subtitles: [String] {
        if let group = mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristic.legible) {
            return group.options.map { $0.displayName }
        }
        return []
    }
    
    /// 整个媒体区间
    var allTimeRange: CMTimeRange {
        CMTimeRange(start: .zero, duration: duration)
    }
    
    /// 打印媒体特性数据：字幕、备用音频、备用视频
    func mediaCharacteristicsDescription() {
        availableMediaCharacteristicsWithMediaSelectionOptions.forEach { characteristic in
            if let group = mediaSelectionGroup(forMediaCharacteristic: characteristic) {
                print("[\(characteristic)]")
                group.options.forEach { option in
                    print("Option: \(option.displayName)")
                }
            }
        }
    }
    
}
