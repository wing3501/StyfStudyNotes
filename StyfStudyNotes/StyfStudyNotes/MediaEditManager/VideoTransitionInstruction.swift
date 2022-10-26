//
//  VideoTransition.swift
//  
//
//  Created by styf on 2022/10/21.
//

import Foundation
import AVFoundation

enum VideoTransitionType {
case none,dissolve,push,wipe
}

enum VideoPushTransitionDirection {
case leftToRight,rightToLeft,topToBotton,bottomToTop
}

struct VideoTransition {
    var type: VideoTransitionType
    var timeRange: CMTimeRange
    var duration: CMTime
    var direction: VideoPushTransitionDirection
}

struct VideoTransitionInstruction {
    var compositionInstruction: AVMutableVideoCompositionInstruction
    var fromLayerInstruction: AVMutableVideoCompositionLayerInstruction
    var toLayerInstruction: AVMutableVideoCompositionLayerInstruction
    var transition: VideoTransition
}
