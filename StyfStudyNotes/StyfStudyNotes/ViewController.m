//
//  ViewController.m
//  StyfStudyNotes
//
//  Created by styf on 2021/2/9.
//

#import "ViewController.h"
#import "StyfStudyNotes-Swift.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
///
@property (nonatomic, strong) UITableView *tableView;
///
@property (nonatomic, strong) NSArray<NSDictionary *> *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = @[
                   @{@"title":@"WWDC",@"class":@"WWDCDemo"},
                   @{@"title":@"Leetcode",@"class":@"Leetcode"},
                   @{@"title":@"__attribute__",@"class":@"AttributeSection"},
                   @{@"title":@"DesignPatten",@"class":@"DesignPatten"},
                   @{@"title":@"Other",@"class":@"Other"},
                   @{@"title":@"内存泄漏",@"class":@"LeaksDemo"},
                   @{@"title":@"懒加载动态库",@"class":@"LazyLoadDynamicFramework"},
                   @{@"title":@"Mach-O",@"class":@"MachO_Note"},
                   @{@"title":@"系统通知库",@"class":@"SystemNotify"},
                   @{@"title":@"__builtin_",@"class":@"Builtin"},
                   @{@"title":@"mmap",@"class":@"MMAPNote"},
                   @{@"title":@"NSOperation",@"class":@"DemoNSOperation"},
                   @{@"title":@"嵌套滚动",@"class":@"ScrollViewDemo"},
                   @{@"title":@"WebView",@"class":@"WebViewDemo"},
                   @{@"title":@"网络拦截",@"class":@"NetworkDemo"},
                   @{@"title":@"Swift",@"class":@"_TtC14StyfStudyNotes9SwiftDemo"},
                   @{@"title":@"打开设置",@"class":@"OpenSetting"},
                   @{@"title":@"Flutter",@"class":@"OpenFlutter"},
                   @{@"title":@"DiffableDataSource",@"class":@"DiffableDataSourceDemo"},
                   @{@"title":@"问题",@"class":@"Question"},
                   @{@"title":@"KVO",@"class":@"KVO"},
                   @{@"title":@"蓝牙",@"class":@"BluetoothDemo"},
                   @{@"title":@"PDF",@"class":@"PDFDemo"},
                   @{@"title":@"字符串安全",@"class":@"SaveKeyDemo"},                   
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
