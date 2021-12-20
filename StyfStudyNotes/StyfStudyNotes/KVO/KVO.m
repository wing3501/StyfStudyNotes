//
//  KVO.m
//  StyfStudyNotes
//
//  Created by styf on 2021/11/3.
// 一种基于KVO的页面加载，渲染耗时监控方法
//  http://satanwoo.github.io/2017/11/27/KVO-Swizzle/

#import "KVO.h"
#import "KVODemoViewController.h"
#import "UIViewController+KVO.h"

@interface KVO ()

@end

@implementation KVO

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.yellowColor;
    [self swizzleVCinitMethod];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    KVODemoViewController *kvo = [[KVODemoViewController alloc]init];
    [self.navigationController pushViewController:kvo animated:YES];
}

@end
