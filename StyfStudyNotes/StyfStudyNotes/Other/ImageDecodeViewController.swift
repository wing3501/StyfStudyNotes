//
//  ImageDecodeViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/11/14.
//  iOS平台图片编解码入门教程（Image/IO篇） https://dreampiggy.com/2017/10/30/iOS%E5%B9%B3%E5%8F%B0%E5%9B%BE%E7%89%87%E7%BC%96%E8%A7%A3%E7%A0%81%E5%85%A5%E9%97%A8%E6%95%99%E7%A8%8B%EF%BC%88Image:IO%E7%AF%87%EF%BC%89/
//  探秘越来越复杂的ImageIO框架
//  https://dreampiggy.com/2022/11/07/%E6%8E%A2%E7%A7%98%E8%B6%8A%E6%9D%A5%E8%B6%8A%E5%A4%8D%E6%9D%82%E7%9A%84ImageIO%E6%A1%86%E6%9E%B6/

import UIKit
import ImageIO

class ImageDecodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    private func staticImageDecode() {
//        静态图的解码，基本可以分为以下步骤：
//        1 创建CGImageSource
//        CGImageSourceCreateWithData： 从一个内存中的二进制数据（CGData）中创建ImageSource，相对来说最为常用的一个
//        CGImageSourceCreateWithURL： 从一个URL（支持网络图的HTTP URL，或者是文件系统的fileURL）创建ImageSource，
//        CGImageSourceCreateWithDataProvider：从一个DataProvide中创建ImageSource，DataProvider提供了很多种输入，包括内存，文件，网络，流等。很多CG的接口会用到这个来避免多个额外的接口。
        if let url = Bundle.main.url(forResource: "IMG_2587", withExtension: "JPG"),
           let data = try? Data(contentsOf: url) {
            var ptr = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count)
            data.copyBytes(to: ptr, count: data.count)
            guard let cfData = CFDataCreate(kCFAllocatorDefault, ptr, data.count),
               let cgImageSource = CGImageSourceCreateWithData(cfData, nil) else { return } // 一般这时候都是输入图像数据的格式不支持
            
            // 2 读取图像格式元数据（可选）
//            图像格式：CGImageSourceGetType
            let cftype = CGImageSourceGetType(cgImageSource)
//            图像数量（动图）：CGImageSourceGetCount
            let count = CGImageSourceGetCount(cgImageSource)
//            对于图像容器的属性（EXIF等），我们需要使用CGImageSourceCopyProperties即可，然后根据不同的Key去获取对应的信息
            if let properties: CFDictionary = CGImageSourceCopyProperties(cgImageSource, nil) {
                let key = Unmanaged.passRetained(kCGImagePropertyFileSize as NSString).autorelease().toOpaque()// 没什么用的文件大小
                // EXIF信息   kCGImagePropertyExifDictionary
                // EXIF拍摄时间   kCGImagePropertyExifDateTimeOriginal
                let fileSize = CFDictionaryGetValue(properties, key)
                let a = kCGImagePropertyFileSize
            }
            
            // 对应的数据不是字典，而是一个CGImageMetadata
            if let metadata: CGImageMetadata = CGImageSourceCopyMetadataAtIndex(cgImageSource, 0, nil) {
                //            NSDictionary *imageProperties = (__bridge NSDictionary *) CGImageSourceCopyPropertiesAtIndex(source, 0, NULL);
                //            NSUInteger width = [imageProperties[(__bridge NSString *)kCGImagePropertyPixelWidth] unsignedIntegerValue]; //宽度，像素值
                //            NSUInteger height = [imageProperties[(__bridge NSString *)kCGImagePropertyPixelHeight] unsignedIntegerValue]; //高度，像素值
                //            BOOL hasAlpha = [imageProperties[(__bridge NSString *)kCGImagePropertyHasAlpha] boolValue]; //是否含有Alpha通道
                //            CGImagePropertyOrientation exifOrientation = [imageProperties[(__bridge NSString *)kCGImagePropertyOrientation] integerValue]; // 这里也能直接拿到EXIF方向信息，和前面的一样。如果是iOS 7，就用NSInteger取吧 :)
            }
            
            // 3 解码得到CGImage
            if let imageRef = CGImageSourceCreateImageAtIndex(cgImageSource, 0, nil) {
                // 4 生成上层的UIImage，清理
                // UIImageOrientation和CGImagePropertyOrientation枚举定义顺序不同，封装一个方法搞一个switch case就行
//                UIImageOrientation imageOrientation = [self imageOrientationFromExifOrientation:exifOrientation];
//                UIImage *image = [[UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:imageOrientation];
            }
        }
    }
}
