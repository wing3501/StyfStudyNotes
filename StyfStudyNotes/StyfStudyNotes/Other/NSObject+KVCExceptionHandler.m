//
//  NSObject+KVCExceptionHandler.m
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import "NSObject+KVCExceptionHandler.h"

@implementation NSObject (KVCExceptionHandler)

- (nullable id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    NSAssert(YES, @"KVO:%@ 不存在key: %@",NSStringFromClass(self.class),key);
}

@end
