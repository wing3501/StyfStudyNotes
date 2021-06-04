//
//  OpenFlutter.m
//  StyfStudyNotes
//
//  Created by styf on 2021/6/4.
//

#import "OpenFlutter.h"
#import <Flutter/Flutter.h>

@interface OpenFlutter ()
/// <#name#>
@property (nonatomic, strong) FlutterEngine *flutterEngine;
@end

@implementation OpenFlutter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.brownColor;
    
    NSLog(@"初始化flutter");
    self.flutterEngine = [[FlutterEngine alloc]initWithName:@"styf"];
    [self.flutterEngine run];
    NSLog(@"flutter初始化完毕");
    
    FlutterViewController *flutterVC = [[FlutterViewController alloc]initWithEngine:self.flutterEngine nibName:nil bundle:nil];
    flutterVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:flutterVC animated:YES completion:nil];
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
