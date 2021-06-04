//
//  OpenSetting.m
//  StyfStudyNotes
//
//  Created by styf on 2021/5/24.
//iOS 极致速度优化：快速打开任意 APP 的设置界面
//https://mp.weixin.qq.com/s?__biz=MzAxMzk0OTg5MQ==&mid=2247485562&idx=1&sn=53bc1a086460ce03920579cc29072424&scene=21#wechat_redirect

#import "OpenSetting.h"

@interface LSApplicationWorkspaceHook : NSObject

+ (instancetype)defaultWorkspace;
- (void)openURL:(NSURL *)url;

@end

@implementation OpenSetting

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 调用 LSApplicationWorkspace 的单例方法
   Class aClass = NSClassFromString(@"LSApplicationWorkspace");
   LSApplicationWorkspaceHook *hook = [aClass defaultWorkspace];
   // 调用 LSApplicationWorkspace 的 `openURL:` 方法
   [hook openURL:[NSURL URLWithString:@"app-prefs:com.styf.StyfStudyNotes"]];
}

@end
