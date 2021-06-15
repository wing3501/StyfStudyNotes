//
//  MyFlutterBoostDelegate.h
//  StyfStudyNotes
//
//  Created by styf on 2021/6/11.
//

#import <Foundation/Foundation.h>
#import <flutter_boost/FlutterBoost.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyFlutterBoostDelegate : NSObject<FlutterBoostDelegate>

@property (nonatomic,strong) UINavigationController *navigationController;
/// <#name#>
@property (nonatomic, strong) FBFlutterViewContainer *fluterVC;
@end

NS_ASSUME_NONNULL_END
