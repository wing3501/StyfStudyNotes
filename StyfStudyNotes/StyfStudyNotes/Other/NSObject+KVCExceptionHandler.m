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

@end
