//
//  NSObject+KVCExceptionHandler.m
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import "NSObject+KVCExceptionHandler.h"

@implementation NSObject (KVCExceptionHandler)

- (nullable id)valueForUndefinedKey:(NSString *)key {
    NSString *errorMsg = [NSString stringWithFormat:@"⚠️KVC: %@ 不存在 key: %@",NSStringFromClass(self.class),key];
    NSAssert(NO, @"\n%@\n%@\n%@\n",errorMsg,errorMsg,errorMsg);
    return nil;
}

- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    NSString *errorMsg = [NSString stringWithFormat:@"⚠️KVC: %@ 不存在 key: %@",NSStringFromClass(self.class),key];
    NSAssert(NO, @"\n%@\n%@\n%@\n",errorMsg,errorMsg,errorMsg);
}

@end
