//
//  AppDelegate.m
//  StyfStudyNotes
//
//  Created by styf on 2021/2/9.
//

#import "AppDelegate.h"
#import "MyFlutterBoostDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupFlutterBoostWithApp:application];
    return YES;
}

- (void)setupFlutterBoostWithApp:(UIApplication *)application {
    //默认方法
    MyFlutterBoostDelegate* delegate = [[MyFlutterBoostDelegate alloc ] init];
    [[FlutterBoost instance] setup:application delegate:delegate callback:^(FlutterEngine *engine) {

    }];
    
    //下面是自定义参数的方法
//    FlutterBoostOptionsBuilder* builder = [[FlutterBoostOptionsBuilder alloc] init];
//    FlutterBoostOptions* options = [[[builder initalRoute:@"/"] dartEntryPoint:@"main"] build];
//
//    [[FlutterBoost instance] setup:application delegate:delegate callback:^(FlutterEngine *engine) {
//
//    } options:options];
    
    
    //FlutterBoost3.0报错解决方法一
    
//    ViewController *nativeVC = [[ViewController alloc]init];
//    nativeVC.title = @"nativeVC";
//    nativeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"nativeVC" image:nil tag:0];
//    UINavigationController *nativeNav = [[UINavigationController alloc] initWithRootViewController:nativeVC];
//
//    FBFlutterViewContainer *fluterVC = FBFlutterViewContainer.new ;
//    [fluterVC setName:@"/" uniqueId:@"main123" params:@{@"参数1":@"走你"}];
//    fluterVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"fluterVC" image:nil tag:1];
//
//    UITabBarController *tabVC = [[UITabBarController alloc] init];
//    tabVC.viewControllers = @[nativeNav,fluterVC];//解决
//    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:tabVC];
//    [rootNav setNavigationBarHidden:YES];
//    delegate.navigationController = rootNav;
//
//    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
//    self.window.rootViewController = rootNav;
//    [self.window makeKeyAndVisible];
    
    
    //FlutterBoost3.0报错解决方法二
    
    ViewController *nativeVC = [[ViewController alloc]init];
    nativeVC.title = @"nativeVC";
    UINavigationController *nativeNav = [[UINavigationController alloc] initWithRootViewController:nativeVC];
    
    FBFlutterViewContainer *fluterVC = FBFlutterViewContainer.new ;
    [fluterVC setName:@"/" uniqueId:@"main123" params:@{@"参数1":@"走你"}];
    delegate.navigationController = nativeNav;
    delegate.fluterVC = fluterVC;
    [nativeVC addChildViewController:fluterVC];//解决
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    self.window.rootViewController = nativeNav;
    [self.window makeKeyAndVisible];
}

@end
