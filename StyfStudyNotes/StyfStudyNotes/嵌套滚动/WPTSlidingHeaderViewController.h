//
//  WPTSlidingHeaderViewController.h
//  WeiPaiTangClient
//
//  Created by styf on 2020/6/30.
//  Copyright © 2020 杭州微拍堂文化创意有限公司. All rights reserved.
//


#import "JXCategoryView.h"
#import "WPTSlidingViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface WPTSlidingHeaderViewController : UIViewController<WPTSlidingViewDelegate>
/// 分段选择器
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
/// 分段选择器高度 默认45
@property (nonatomic, assign) CGFloat categoryViewHeight;

/// 初始化
/// @param viewHeight 视图高度
/// @param suspendContentOffsetY 悬停时的contentOffsetY
- (instancetype)initWithViewHeight:(CGFloat)viewHeight suspendContentOffsetY:(CGFloat)suspendContentOffsetY;
@end

NS_ASSUME_NONNULL_END
