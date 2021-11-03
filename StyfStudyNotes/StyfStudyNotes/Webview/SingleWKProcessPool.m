//
//  SingleWKProcessPool.m
//  StyfStudyNotes
//
//  Created by styf on 2021/11/3.
//

#import "SingleWKProcessPool.h"

@implementation SingleWKProcessPool

+ (instancetype)sharedInstance {
    static id sharedObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObj = [[super allocWithZone:NULL]init];
    });
    return sharedObj;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

+ (instancetype)alloc {
    return [self sharedInstance];
}

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return self;
}
@end
