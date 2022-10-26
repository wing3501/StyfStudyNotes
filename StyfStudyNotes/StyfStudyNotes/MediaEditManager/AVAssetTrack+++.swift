//
//  AVAssetTrack+++.swift
//  
//
//  Created by styf on 2022/10/26.
//

import Foundation
import AVFoundation

extension AVAssetTrack {
    var fixedPreferredTransform: CGAffineTransform {
        var newT = preferredTransform
        switch [newT.a, newT.b, newT.c, newT.d] {
        case [1, 0, 0, 1]:
            newT.tx = 0
            newT.ty = 0
        case [1, 0, 0, -1]:
            newT.tx = 0
            newT.ty = naturalSize.height
        case [-1, 0, 0, 1]:
            newT.tx = naturalSize.width
            newT.ty = 0
        case [-1, 0, 0, -1]:
            newT.tx = naturalSize.width
            newT.ty = naturalSize.height
        case [0, -1, 1, 0]:
            newT.tx = 0
            newT.ty = naturalSize.width
        case [0, 1, -1, 0]:
            newT.tx = naturalSize.height
            newT.ty = 0
        case [0, 1, 1, 0]:
            newT.tx = 0
            newT.ty = 0
        case [0, -1, -1, 0]:
            newT.tx = naturalSize.height
            newT.ty = naturalSize.width
        default:
            break
        }
        return newT
    }
}
