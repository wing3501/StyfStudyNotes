//
//  WPTSlidingHeaderViewController.m
//   
//
//  Created by styf on 2020/6/30.
//  Copyright © 2020   . All rights reserved.
//

#import "WPTSlidingHeaderViewController.h"
#import <Masonry/Masonry.h>
#import "UIView+Ext.h"
#import "UIColor+Ext.h"

@interface WPTSlidingHeaderViewController ()
/// <#name#>
@property (nonatomic, strong) UIImageView *imageView;
/// 视图高度
@property (nonatomic, assign) CGFloat viewHeight;
/// 悬停时的contentOffsetY
@property (nonatomic, assign) CGFloat suspendContentOffsetY;
@end

@implementation WPTSlidingHeaderViewController

#pragma mark - life cycle

/// 初始化
/// @param viewHeight 视图高度
/// @param suspendContentOffsetY 悬停时的contentOffsetY
- (instancetype)initWithViewHeight:(CGFloat)viewHeight suspendContentOffsetY:(CGFloat)suspendContentOffsetY {
    self = [super init];
    if (self) {
        _viewHeight = viewHeight;
        _suspendContentOffsetY = suspendContentOffsetY;
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
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.imageView];
}

/// 自动布局
- (void)autoLayout {
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(self.categoryViewHeight > 0 ? self.categoryViewHeight : 45));
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.categoryView.mas_top);
    }];
}
#pragma mark - overwrite

#pragma mark - request

#pragma mark - public

#pragma mark - notification

#pragma mark - 埋点

#pragma mark - event response

#pragma mark - private

#pragma mark - WPTSlidingViewDelegate

/// 子滚动视图上下滚动时通知代理
/// @param contentOffset 滚动偏移
- (void)horizontalScrollContentOffsetChange:(CGPoint)contentOffset {
    if (contentOffset.y > 0) {//上拉
        //头图跟着滚动
        CGFloat offsetY = MIN(contentOffset.y, self.suspendContentOffsetY);
        if (self.view.cm_y != -offsetY) {
            self.view.cm_y = -offsetY;
        }
    }else{//下拉
        //头图拉长
        [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(MAX(self.viewHeight - contentOffset.y, self.viewHeight)));
        }];
    }
}

#pragma mark - getter and setter

- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc]init];
        _categoryView.titleFont = [UIFont systemFontOfSize:15];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:15];
        _categoryView.titleColor = [UIColor cm_colorWithHexString:@"666666"];
        _categoryView.titleSelectedColor = [UIColor cm_colorWithHexString:@"AB3B3A"];
        _categoryView.backgroundColor = [UIColor whiteColor];
        _categoryView.titleColorGradientEnabled = NO;
        
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorHeight = 2;
        lineView.indicatorWidth = 25;
        lineView.indicatorCornerRadius = JXCategoryViewAutomaticDimension;
        lineView.indicatorColor = [UIColor cm_colorWithHexString:@"AB3B3A"];
        lineView.verticalMargin = 6;
        _categoryView.indicators = @[lineView];
    }
    return _categoryView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"header"];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}
@end
