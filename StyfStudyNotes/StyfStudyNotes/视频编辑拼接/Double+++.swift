//
//  Double+++.swift
//  
//
//  Created by styf on 2022/10/26.
//

import Foundation
import AVKit

extension Double {
    func toCMTime() -> CMTime {
        return CMTime(seconds: self, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
    }
}
