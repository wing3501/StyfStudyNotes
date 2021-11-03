//
//  SingleWKProcessPool.h
//  StyfStudyNotes
//
//  Created by styf on 2021/11/3.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleWKProcessPool : WKProcessPool
+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
