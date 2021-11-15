//
//  Question.m
//  StyfStudyNotes
//
//  Created by styf on 2021/10/27.
//

#import "Question.h"

@interface Question ()<UITableViewDelegate,UITableViewDataSource>
///
@property (nonatomic, strong) UITableView *tableView;
///
@property (nonatomic, strong) NSArray<NSDictionary *> *dataArray;

@end

@implementation Question

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = @[
        @{@"title":@"Crash收集",@"class":@"CrashHelper"},
        @{@"title":@"内存",@"class":@"MemoryHelper"},
    ];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *classString = _dataArray[indexPath.row][@"class"];
    [self.navigationController pushViewController:[NSClassFromString(classString) new] animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataArray[indexPath.row][@"title"];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
