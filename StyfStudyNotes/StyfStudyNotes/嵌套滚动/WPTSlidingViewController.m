//
//  WPTSlidingViewController.m
//   
//
//  Created by styf on 2020/6/30.
//  Copyright © 2020   . All rights reserved.
//

#import "WPTSlidingViewController.h"
#import "NSObject+FBKVOController.h"
#import <Masonry/Masonry.h>

@interface WPTSlidingViewController ()<UIScrollViewDelegate>
/// 子控制器数组
@property (nonatomic, strong) NSArray<UIViewController<WPTUserProfileSlidingViewSubVCDelegate> *> *vcArray;
/// 子控制器的滚动视图
@property (nonatomic, strong) NSMutableArray<UIScrollView *> *scrollViewArray;
/// 悬停时的contentOffsetY
@property (nonatomic, assign) NSInteger suspendContentOffsetY;
@end

@implementation WPTSlidingViewController

#pragma mark - life cycle

/// 初始化
/// @param vcArray 控制器数组
/// @param suspendContentOffsetY 悬停时的contentOffsetY
- (instancetype)initWithSubVCArray:(NSArray<UIViewController<WPTUserProfileSlidingViewSubVCDelegate> *> *)vcArray suspendContentOffsetY:(CGFloat)suspendContentOffsetY {
    self = [super init];
    if (self) {
        _vcArray = vcArray;
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
    _scrollViewArray = @[].mutableCopy;
    [self setupUI];
    [self autoLayout];
    [self setupSubVCs];
}

/// 设置视图
- (void)setupUI {
    [self.view addSubview:self.scrollView];
    
}

/// 自动布局
- (void)autoLayout {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - overwrite

#pragma mark - request

#pragma mark - public

#pragma mark - notification

#pragma mark - 埋点

#pragma mark - event response

#pragma mark - private

/// 设置子视图
- (void)setupSubVCs {
    for (NSInteger i = 0; i < self.vcArray.count; i++) {
        UIViewController<WPTUserProfileSlidingViewSubVCDelegate> *vc = self.vcArray[i];
        [self addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView);
            make.left.equalTo(self.scrollView).offset([UIScreen mainScreen].bounds.size.width * i);
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
            make.height.equalTo(self.scrollView);
        }];
        
        UIScrollView *scrollView = [vc scrollView];
        [self.scrollViewArray addObject:scrollView];
        //监听子滚动视图的偏移量变化，子滚动视图上下滚动时，通知外面的头图frame变化
        __weak typeof(self) weakSelf = self;
        [self.KVOController observe:scrollView keyPath:@"contentOffset" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
            [weakSelf.delegate horizontalScrollContentOffsetChange:[change[NSKeyValueChangeNewKey] CGPointValue]];
        }];
    }
}

/// 同步滚动视图的偏移量
static BOOL isFixOffset = NO;//是否正在修正其他子滚动视图偏移量，防止在横向滚动的时候不断修正，修正一次偏移就够了
- (void)resetOtherSubviewOffsetIfNeeded:(NSUInteger)currentIndex {
    if (isFixOffset) {
        return;
    }else{
        isFixOffset = YES;
        for (NSInteger i = 0; i < self.scrollViewArray.count; i++) {
            CGFloat offsetY = self.scrollViewArray[currentIndex].contentOffset.y;
            if (i != currentIndex && offsetY >= 0) {//把另外两个视图的偏移
                CGPoint offset = CGPointMake(0, MIN(offsetY, self.suspendContentOffsetY));
                [self.scrollViewArray[i] setContentOffset:offset animated:NO];
            }
        }
    }
}

#pragma mark - JXCategoryViewDelegate

/**
 点击选中的情况才会调用该方法

 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    //点击分段选择时，categoryView.selectedIndex 会直接变为目标index,但是同步时要以当前的index为准
    CGFloat ratio = self.scrollView.contentOffset.x/self.scrollView.bounds.size.width;
    NSUInteger currentIndex = floorf( MAX(0, MIN(self.scrollView.subviews.count - 1, ratio)));
    [self resetOtherSubviewOffsetIfNeeded:currentIndex];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //横向滚动的时候，把其他的滚动视图的偏移都设置到和当前页一样
    [self resetOtherSubviewOffsetIfNeeded:self.categoryView.selectedIndex];//手指滑动时的偏移同步
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    isFixOffset = NO;//手指滑动结束，标志位还原
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    isFixOffset = NO;//点击分段选择器的滚动结束，标志位还原
}

#pragma mark - getter and setter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.vcArray.count, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
@end
