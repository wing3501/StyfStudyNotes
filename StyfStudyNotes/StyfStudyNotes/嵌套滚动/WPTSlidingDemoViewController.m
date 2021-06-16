//
//  WPTSlidingDemoViewController.m
//  WeiPaiTangClient
//
//  Created by styf on 2020/6/30.
//  Copyright © 2020 杭州微拍堂文化创意有限公司. All rights reserved.
//

#import "WPTSlidingDemoViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+Ext.h"

#define UIColorFrom10RGBA(RED, GREEN, BLUE,ALPHA) [UIColor colorWithRed:RED/255.0 green:GREEN/255.0 blue:BLUE/255.0 alpha:ALPHA]
#define UIColorFrom10RGB(RED, GREEN, BLUE) UIColorFrom10RGBA(RED, GREEN, BLUE,1)
#define RandomColor UIColorFrom10RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface WPTSlidingDemoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/// 列表
@property (nonatomic, strong) UICollectionView *collectionView;
/// 头图高度
@property (nonatomic, assign) CGFloat headerHeight;
@end

@implementation WPTSlidingDemoViewController

/// 初始化
/// @param headerHeight 视图高度
- (instancetype)initWithHeaderHeight:(CGFloat)headerHeight {
    self = [super init];
    if (self) {
        _headerHeight = headerHeight;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UIScrollView *)scrollView {
    return self.collectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = RandomColor;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerViewId" forIndexPath:indexPath];
        headView.backgroundColor = RandomColor;
        return headView;
    }
    return [UICollectionReusableView new];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, self.headerHeight);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        layout.footerReferenceSize = CGSizeZero;
        CGFloat itemW = floor(([UIScreen mainScreen].bounds.size.width - 2 * 2) /3.0);
        layout.itemSize = CGSizeMake(itemW, itemW);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor cm_colorWithHexString:@"#F4F6F6"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerViewId"];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
    }
    return _collectionView;
}
@end
