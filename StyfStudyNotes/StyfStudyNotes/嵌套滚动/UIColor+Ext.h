//
//  UIColor+Ext.h
//  StyfStudyNotes
//
//  Created by styf on 2021/6/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Ext)

/**
 NSString -> UIColor

 @param aColorString normal:@“#AB12FF” or @“AB12FF” or gray: @"C7"
 @return UIColor
 */
+ (nonnull UIColor *)cm_colorWithHexString:(nonnull NSString *)aColorString;

/**
 NSString -> UIColor with alpha

 @param aColorString normal:@“#AB12FF” or @“AB12FF” or gray: @"C7"
 @param aAlpha       alpha 0-1.0
 @return UIColor
 */
+ (nonnull UIColor *)cm_colorWithHexString:(nonnull NSString *)aColorString alpha:(CGFloat)aAlpha;

/**
 UIColor -> NSString

 @param aColor UIColor
 @return NSString（format: @“#AB12FF”）
 */
+ (nonnull NSString *)cm_hexValuesFromUIColor:(nonnull UIColor *)aColor;

/// 适配黑暗模式动态颜色
/// @param lightColor 普通颜色 传nil默认白色
/// @param darkColor 黑暗模式颜色 传nil默认黑色
+ (UIColor *)cm_dynamicColorWithLight:(id)lightColor darkColor:(id)darkColor;
@end

NS_ASSUME_NONNULL_END
