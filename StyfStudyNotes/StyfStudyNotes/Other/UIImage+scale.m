//
//  UIImage+scale.m
//  StyfStudyNotes
//
//  Created by styf on 2021/11/4.
//

#import "UIImage+scale.h"

@implementation UIImage (scale)

// 常见的UIimage缩放写法
+ (UIImage *)scaleImage:(UIImage *)image newSize:(CGSize)newSize{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

// 节约内存的ImageIO缩放写法
+ (UIImage *)scaledImageWithData:(NSData *)data withSize:(CGSize)size scale:(CGFloat)scale orientation:(UIImageOrientation)orientation {
    CGFloat maxPixelSize = MAX(size.width, size.height);
    CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
    NSDictionary *options = @{(__bridge id)kCGImageSourceCreateThumbnailFromImageAlways : (__bridge id)kCFBooleanTrue,
                              (__bridge id)kCGImageSourceThumbnailMaxPixelSize : [NSNumber numberWithFloat:maxPixelSize]};
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(sourceRef, 0, (__bridge CFDictionaryRef)options);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:scale orientation:orientation];
    CGImageRelease(imageRef);
    CFRelease(sourceRef);
    return resultImage;
}


/*
 根据图片大小，获取图片压缩因子
 */
+ (CGFloat)getCompressRateByImageSize:(CGFloat)imageSize targetSize:(CGFloat)targetSize {
    NSUInteger rate = (NSUInteger)(imageSize / targetSize);
    rate = (rate == 0) ? 1 : rate;

    // 默认0.8压缩因子
    CGFloat maxCompressRate = 0.8;
    CGFloat minCompressRate = 0.2;

    // 反比例压缩函数
    CGFloat compressRate = 0.8 / rate;

    compressRate = MIN(MAX(compressRate, minCompressRate), maxCompressRate);
    return compressRate;
}

/*!
 *    【iOS手把手实战系列】还在循环压图片？有风险！试试先压后缩!
 *       https://juejin.cn/post/7072762992877633543
 *  @brief 使图片压缩后刚好小于指定大小
 *
 *  @param image 当前要压缩的图 maxLength 压缩后的大小
 *
 *  @return 图片对象
 */
+ (NSData *)compressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength {
    // 压
    NSData *data = UIImageJPEGRepresentation(image, 1);
    if (data.length < maxLength) {
        return data;
    }

    CGFloat compressRate = [self.class getCompressRateByImageSize:data.length targetSize:maxLength];
    data = UIImageJPEGRepresentation(image, compressRate);
    if (data.length < maxLength) {
        return data;
    }

    // 缩
    UIImage *resultImage = [UIImage imageWithData:data];
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)), (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        if (CGSizeEqualToSize(size, CGSizeZero) || size.width < 10 || size.height < 10) {
            break;
        }
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compressRate);
    }

    return data;
}

@end
