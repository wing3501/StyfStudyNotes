//
//  WPTSlidingDemoViewController.h
//  WeiPaiTangClient
//
//  Created by styf on 2020/6/30.
//  Copyright © 2020 杭州微拍堂文化创意有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPTSlidingViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface WPTSlidingDemoViewController : UIViewController<WPTUserProfileSlidingViewSubVCDelegate>
/// 初始化
/// @param headerHeight 视图高度
- (instancetype)initWithHeaderHeight:(CGFloat)headerHeight;
@end

NS_ASSUME_NONNULL_END
