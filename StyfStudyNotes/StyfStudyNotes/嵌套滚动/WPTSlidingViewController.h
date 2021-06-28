//
//  WPTSlidingViewController.h
//   
//
//  Created by styf on 2020/6/30.
//  Copyright © 2020   . All rights reserved.
//


#import "JXCategoryView.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol WPTUserProfileSlidingViewSubVCDelegate <NSObject>

/// 返回子控制器中的滚动视图
- (UIScrollView *)scrollView;

@end

@protocol WPTSlidingViewDelegate <NSObject>

/// 子滚动视图上下滚动时通知代理
/// @param contentOffset 滚动偏移
- (void)horizontalScrollContentOffsetChange:(CGPoint)contentOffset;

@end

@interface WPTSlidingViewController : UIViewController<JXCategoryViewDelegate>
/// 横向滚动
@property (nonatomic, strong) UIScrollView *scrollView;
/// 代理
@property (nonatomic, weak) id<WPTSlidingViewDelegate> delegate;
/// 分段选择器
@property (nonatomic, weak) JXCategoryTitleView *categoryView;

/// 初始化
/// @param vcArray 控制器数组
/// @param suspendContentOffsetY 悬停时的contentOffsetY
- (instancetype)initWithSubVCArray:(NSArray<UIViewController<WPTUserProfileSlidingViewSubVCDelegate> *> *)vcArray suspendContentOffsetY:(CGFloat)suspendContentOffsetY;
@end

NS_ASSUME_NONNULL_END
