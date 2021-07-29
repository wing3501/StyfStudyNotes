//
//  DiffableDataSourceDemo.m
//  StyfStudyNotes
//
//  Created by styf on 2021/7/23.
//

#import "DiffableDataSourceDemo.h"
#import <Masonry/Masonry.h>
#import "SaleHeaderFooterView.h"
#import "SaleCell.h"
#import "SaleModel.h"
#import "SaleHeaderFooterModel.h"
static NSString * const CellReuseIdentifier = @"SaleCell";
static NSString * const HeaderFooterViewReuseIdentifier = @"SaleHeaderFooterView";

@interface DiffableDataSourceDemo ()<UITableViewDelegate>
///
@property (nonatomic, strong) UITableView *tableView;
/// <#name#>
@property (nonatomic, strong) UITableViewDiffableDataSource<SaleHeaderFooterModel *,SaleModel *> *dataSource;
@end

@implementation DiffableDataSourceDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _dataSource = [[UITableViewDiffableDataSource alloc]initWithTableView:_tableView cellProvider:^UITableViewCell * _Nullable(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, id _Nonnull model) {
            
        SaleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
        cell.model = model;
        return cell;
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self addData];
    }];
}

- (void)addData {
    static int count = 1;
    
    NSDiffableDataSourceSnapshot<SaleHeaderFooterModel *,SaleModel *> *snapshot = [[NSDiffableDataSourceSnapshot alloc]init];
    SaleHeaderFooterModel *headerFooterModel = [[SaleHeaderFooterModel alloc]init];
    [snapshot appendSectionsWithIdentifiers:@[headerFooterModel]];
    
    int count1 = count;
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < count1 + 1; i++) {
        SaleModel *model = [[SaleModel alloc]init];
        model.name = [NSString stringWithFormat:@"产品%d",count++];
        [array addObject:model];
    }
    [snapshot appendItemsWithIdentifiers:array];
    
    [_dataSource applySnapshot:snapshot animatingDifferences:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SaleHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderFooterViewReuseIdentifier];
    view.isHeader = YES;
    view.number = section;
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SaleHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderFooterViewReuseIdentifier];
    view.isHeader = NO;
    view.number = section;
    return view;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
        _tableView.delegate = self;
        [_tableView registerClass:SaleCell.class forCellReuseIdentifier:CellReuseIdentifier];
        [_tableView registerClass:SaleHeaderFooterView.class forHeaderFooterViewReuseIdentifier:HeaderFooterViewReuseIdentifier];
        _tableView.backgroundColor = [UIColor lightGrayColor];
    }
    return _tableView;
}

@end
