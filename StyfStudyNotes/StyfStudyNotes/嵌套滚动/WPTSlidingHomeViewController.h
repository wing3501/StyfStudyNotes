//
//  WPTSlidingHomeViewController.h
//  WeiPaiTangClient
//
//  Created by styf on 2020/6/30.
//  Copyright © 2020 杭州微拍堂文化创意有限公司. All rights reserved.
//


#import "WPTSlidingViewController.h"
#import "WPTSlidingHeaderViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface WPTSlidingHomeViewController : UIViewController
/// 头图控制器  
@property (nonatomic, weak) WPTSlidingHeaderViewController *header;

//例子
//WPTSlidingHomeViewController *vc = [[WPTSlidingHomeViewController alloc]initWithHeaderHeight:450 categoryViewHeight:45 suspendContentOffsetY:(450-45) subVCArray:@[[[WPTSlidingDemoViewController alloc]init],[[WPTSlidingDemoViewController alloc]init],[[WPTSlidingDemoViewController alloc]init]] titles:@[@"作品",@"转发",@"喜欢"]];
//[self.cm_viewController presentViewController:vc animated:YES completion:nil];

/// 初始化
/// @param headerHeight 头图高度
/// @param categoryViewHeight 分段选择器的高度
/// @param suspendContentOffsetY 悬停时的contentOffsetY
/// @param vcArray 子控制器数组
/// @param titles 分段选择器的标题数组
- (instancetype)initWithHeaderHeight:(CGFloat)headerHeight categoryViewHeight:(CGFloat)categoryViewHeight suspendContentOffsetY:(CGFloat)suspendContentOffsetY subVCArray:(NSArray<UIViewController<WPTUserProfileSlidingViewSubVCDelegate> *> *)vcArray titles:(NSArray *)titles;
@end

NS_ASSUME_NONNULL_END
