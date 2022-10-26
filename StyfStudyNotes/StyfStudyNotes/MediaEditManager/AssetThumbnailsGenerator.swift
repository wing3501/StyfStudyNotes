//
//  AssetThumbnailsGenerator.swift
//  
//
//  Created by styf on 2022/10/20.
//

import Foundation
import AVFoundation
import UIKit

class AssetThumbnailsGenerator {
    public static let shared = AssetThumbnailsGenerator()
    private var imageGenerator: AVAssetImageGenerator?
    
    /// 生成一批缩略图
    /// - Parameters:
    ///   - asset: 资源
    ///   - size: 缩略图宽度
    ///   - count: 生成数量
    ///   - completionHandler: 生成回调
    func generateThumbnails(_ asset: AVAsset,_ size: CGFloat = 300,_ count: Int = 20,_ completionHandler: @escaping ([(UIImage,CMTime)]) -> Void) {
        imageGenerator = AVAssetImageGenerator(asset: asset)
        // maximumSize属性会自动对图片的尺寸进行缩放并显著提高性能
        // 生成的图片会遵循这个宽度，并根据宽高比自动设置高度
        imageGenerator?.maximumSize = CGSize(width: size, height: 0)
        
        let duration = asset.duration;
        var times: [CMTime] = []
        let increment: CMTimeValue = duration.value / Int64(count)
        var currentValue: CMTimeValue = 0
        while currentValue <= duration.value {
            times.append(CMTime(value: currentValue, timescale: duration.timescale))
            currentValue += increment
        }
        
        var thumbnails: [(UIImage,CMTime)] = []
        var finishedCount = 0
        imageGenerator?.generateCGImagesAsynchronously(forTimes: times.map({
            NSValue(time: $0)
        }), completionHandler: { requestedTime, imageRef, actualTime, result, error in
//                        CMTime requestedTime,//请求的最初时间
//                        CGImageRef imageRef,//图片，没生成就是NULL
//                        CMTime actualTime,//图片实际生成的时间
//                        AVAssetImageGeneratorResult result,//生成成功还是失败
            if case .succeeded = result,
                let imageRef {
                thumbnails.append((UIImage(cgImage: imageRef),actualTime))
            }
            finishedCount += 1
            if finishedCount == count {
                completionHandler(thumbnails)
            }
        })
    }
}


