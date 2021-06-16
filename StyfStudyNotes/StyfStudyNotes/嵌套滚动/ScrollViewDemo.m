//
//  ScrollViewDemo.m
//  StyfStudyNotes
//
//  Created by styf on 2021/6/16.
//

#import "ScrollViewDemo.h"
#import "WPTSlidingDemoViewController.h"
#import "WPTSlidingHomeViewController.h"
@interface ScrollViewDemo ()

@end

@implementation ScrollViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        WPTSlidingHomeViewController *vc = [[WPTSlidingHomeViewController alloc]initWithHeaderHeight:450 categoryViewHeight:45 suspendContentOffsetY:(450-45) subVCArray:@[[[WPTSlidingDemoViewController alloc]init],[[WPTSlidingDemoViewController alloc]init],[[WPTSlidingDemoViewController alloc]init]] titles:@[@"作品",@"转发",@"喜欢"]];
        [self presentViewController:vc animated:YES completion:nil];
    });
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
