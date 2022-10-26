//
//  AVPlayerItem+++.swift
//  
//
//  Created by styf on 2022/10/20.
//

import Foundation
import AVFoundation

extension AVPlayerItem {
    
    /// 选择字幕
    /// - Parameter subtitle: 字幕特征的标题
    func select(_ subtitle: String) {
        if let group = self.asset.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristic.legible) {
            if let option = group.options.filter({ $0.displayName == subtitle }).first {
                select(option, in: group)
            }else {
                select(nil, in: group) // 以便用户选择”None“时，移除字幕
            }
        }
    }
}
