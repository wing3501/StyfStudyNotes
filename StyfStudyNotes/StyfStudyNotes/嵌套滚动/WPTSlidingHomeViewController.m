//
//  WPTSlidingHomeViewController.m
//  WeiPaiTangClient
//
//  Created by styf on 2020/6/30.
//  Copyright © 2020 杭州微拍堂文化创意有限公司. All rights reserved.
//

#import "WPTSlidingHomeViewController.h"
#import <Masonry/Masonry.h>

@interface WPTSlidingHomeViewController ()
/// 头图高度
@property (nonatomic, assign) CGFloat headerHeight;
/// 悬停时的contentOffsetY
@property (nonatomic, assign) CGFloat suspendContentOffsetY;
/// 控制器数组
@property (nonatomic, strong) NSArray *vcArray;
/// 标题数组
@property (nonatomic, strong) NSArray *titles;
/// 分段选择器的高度
@property (nonatomic, assign) CGFloat categoryViewHeight;
@end

@implementation WPTSlidingHomeViewController

#pragma mark - life cycle
/// 初始化
/// @param headerHeight 头图高度
/// @param categoryViewHeight 分段选择器的高度
/// @param suspendContentOffsetY 悬停时的contentOffsetY
/// @param vcArray 子控制器数组
/// @param titles 分段选择器的标题数组
- (instancetype)initWithHeaderHeight:(CGFloat)headerHeight categoryViewHeight:(CGFloat)categoryViewHeight suspendContentOffsetY:(CGFloat)suspendContentOffsetY subVCArray:(NSArray<UIViewController<WPTUserProfileSlidingViewSubVCDelegate> *> *)vcArray titles:(NSArray *)titles {
    self = [super init];
    if (self) {
        _headerHeight = headerHeight;
        _suspendContentOffsetY = suspendContentOffsetY;
        _vcArray = vcArray;
        _titles = titles;
        _categoryViewHeight = categoryViewHeight;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

/// 初始化
- (void)commonInit {
    [self setupUI];
    [self autoLayout];
}

/// 设置视图
- (void)setupUI {
    WPTSlidingHeaderViewController *headerVC = [[WPTSlidingHeaderViewController alloc]initWithViewHeight:self.headerHeight suspendContentOffsetY:self.suspendContentOffsetY];
    [self addChildViewController:headerVC];
    headerVC.categoryViewHeight = self.categoryViewHeight;
    headerVC.categoryView.titles = self.titles;
    _header = headerVC;
    
    WPTSlidingViewController *slidingVC = [[WPTSlidingViewController alloc]initWithSubVCArray:self.vcArray suspendContentOffsetY:self.suspendContentOffsetY];
    slidingVC.delegate = headerVC;
    slidingVC.categoryView = headerVC.categoryView;
    headerVC.categoryView.contentScrollView = slidingVC.scrollView;
    [self addChildViewController:slidingVC];
    [self.view addSubview:slidingVC.view];
    [slidingVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:headerVC.view];
    [headerVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(self.headerHeight));
    }];
    
}

/// 自动布局
- (void)autoLayout {
    
}

#pragma mark - overwrite

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationFullScreen;
}

#pragma mark - request

#pragma mark - public

#pragma mark - notification

#pragma mark - 埋点

#pragma mark - event response

#pragma mark - private

#pragma mark - getter and setter

@end
