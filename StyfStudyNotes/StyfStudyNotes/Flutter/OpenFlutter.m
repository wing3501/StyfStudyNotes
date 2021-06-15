//
//  OpenFlutter.m
//  StyfStudyNotes
//
//  Created by styf on 2021/6/4.
//

#import "OpenFlutter.h"
#import <Flutter/Flutter.h>
#import <flutter_boost/FlutterBoost.h>

@interface OpenFlutter ()
/// <#name#>
@property (nonatomic, strong) FlutterEngine *flutterEngine;
@end

@implementation OpenFlutter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.brownColor;
    
    
    //FlutterBoost 原生打开Flutter页面
//    [[FlutterBoost instance] open:@"flutterPage" arguments:@{@"animated":@(YES)}  ];
//    [[FlutterBoost instance] open:@"secondStateful" arguments:@{@"present":@(YES)}];
    
    
    
    
    //普通混编方式
//    NSLog(@"初始化flutter");
//    self.flutterEngine = [[FlutterEngine alloc]initWithName:@"styf"];
//    [self.flutterEngine run];
//    NSLog(@"flutter初始化完毕");
//    
//    FlutterViewController *flutterVC = [[FlutterViewController alloc]initWithEngine:self.flutterEngine nibName:nil bundle:nil];
//    flutterVC.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:flutterVC animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [[FlutterBoost instance]open:@"/callnative" arguments:@{@"present":@(YES),@"animated":@(YES)} completion:nil];
    [[FlutterBoost instance]open:@"/callnative" arguments:@{@"animated":@(YES)} completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
