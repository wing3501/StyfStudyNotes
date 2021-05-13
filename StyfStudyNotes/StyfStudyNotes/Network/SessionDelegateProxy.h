//
//  SessionDelegateProxy.h
//  StyfStudyNotes
//
//  Created by styf on 2021/5/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SessionDelegateProxy : NSProxy

- (nonnull instancetype)initWithTarget:(nonnull id)target;
+ (nonnull instancetype)proxyWithTarget:(nonnull id)target;


@end

NS_ASSUME_NONNULL_END
