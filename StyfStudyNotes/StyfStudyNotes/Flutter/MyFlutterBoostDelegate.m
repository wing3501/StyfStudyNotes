//
//  MyFlutterBoostDelegate.m
//  StyfStudyNotes
//
//  Created by styf on 2021/6/11.
//

#import "MyFlutterBoostDelegate.h"

@implementation MyFlutterBoostDelegate

#pragma mark - FlutterBoostDelegate

- (void) pushNativeRoute:(NSString *) pageName arguments:(NSDictionary *) arguments {
    BOOL animated = [arguments[@"animated"] boolValue];
    BOOL present= [arguments[@"present"] boolValue];
    
    if (pageName.length) {
        UIViewController *vc = [[NSClassFromString(pageName) alloc]init];
        if(present){
            [self.navigationController presentViewController:vc animated:animated completion:^{
            }];
        }else{
            [self.navigationController pushViewController:vc animated:animated];
        }
    }
    
    //例子
//    UIViewControllerDemo *nvc = [[UIViewControllerDemo alloc] initWithNibName:@"UIViewControllerDemo" bundle:[NSBundle mainBundle]];
//    if(present){
//        [self.navigationController presentViewController:nvc animated:animated completion:^{
//        }];
//    }else{
//        [self.navigationController pushViewController:nvc animated:animated];
//    }
}

- (void) pushFlutterRoute:(NSString *) pageName uniqueId:(NSString *)uniqueId arguments:(NSDictionary *) arguments completion:(void(^)(BOOL)) completion {
    FlutterEngine* engine =  [[FlutterBoost instance ] engine];
    engine.viewController = nil;
    
    FBFlutterViewContainer *vc = FBFlutterViewContainer.new ;
    
    [vc setName:pageName uniqueId:uniqueId params:arguments];
    
    BOOL animated = [arguments[@"animated"] boolValue];
    BOOL present= [arguments[@"present"] boolValue];
    if(present){
        [self.navigationController presentViewController:vc animated:animated completion:^{
            !completion ?: completion(YES);
        }];
    }else{
        [self.navigationController pushViewController:vc animated:animated];
        !completion ?: completion(YES);
    }
}


- (void) popRoute:(NSString *)uniqueId {
    FBFlutterViewContainer *vc = (id)self.navigationController.presentedViewController;
    
    if([vc isKindOfClass:FBFlutterViewContainer.class] && [vc.uniqueIDString isEqual: uniqueId]){
        [vc dismissViewControllerAnimated:YES completion:^{}];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
