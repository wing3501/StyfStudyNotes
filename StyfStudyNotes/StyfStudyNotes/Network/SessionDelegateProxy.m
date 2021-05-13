//
//  SessionDelegateProxy.m
//  StyfStudyNotes
//
//  Created by styf on 2021/5/13.
//

#import "SessionDelegateProxy.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface SessionDelegateProxyHandle : NSObject
///
@property (nonatomic, weak) id target;
@end

@implementation SessionDelegateProxyHandle
- (instancetype)initWithTarget:(id)target {
    self = [super init];
    if (self) {
        _target = target;
    }
    return self;
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
                                 didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"拦截11111----request:%@",dataTask.currentRequest);
    NSLog(@"拦截11111----response:%@",response);
    
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionDataTask *, NSURLResponse *, id))objc_msgSend)(self.target, _cmd, session, dataTask, response, completionHandler);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    NSString *str = [[NSString alloc]initWithData:data encoding:4];
    NSLog(@"拦截22222----%@ data:%@",dataTask.currentRequest.URL,str);
    
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionDataTask *, NSData *))objc_msgSend)(self.target, _cmd, session, dataTask, data);
}
@end

@interface SessionDelegateProxy ()<NSURLSessionDelegate>
///
@property (nonatomic, strong) SessionDelegateProxyHandle *handle;
@end

@implementation SessionDelegateProxy

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSessionWithConfiguration];
    });
}

+ (void)swizzleSessionWithConfiguration {
    Class oriCls = [NSURLSession class];
    SEL oriSel = @selector(sessionWithConfiguration:delegate:delegateQueue:);
    Method oriMethod = class_getClassMethod(oriCls, oriSel);
    
    Class swizzledCls = [self class];
    SEL swizzledSEL = @selector(mySessionWithConfiguration:delegate:delegateQueue:);
    Method swizzledMethod = class_getClassMethod(swizzledCls, swizzledSEL);
    
    class_addMethod(object_getClass(oriCls), swizzledSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    swizzledMethod = class_getClassMethod(oriCls, swizzledSEL);
    
    method_exchangeImplementations(oriMethod, swizzledMethod);
}

+ (NSURLSession *)mySessionWithConfiguration:(NSURLSessionConfiguration *)configuration delegate:(nullable id <NSURLSessionDelegate>)delegate delegateQueue:(nullable NSOperationQueue *)queue {
    return [self mySessionWithConfiguration:configuration delegate:[SessionDelegateProxy proxyWithTarget:delegate] delegateQueue:queue];
}

- (instancetype)initWithTarget:(id)target {
    _handle = [[SessionDelegateProxyHandle alloc]initWithTarget:target];
    return self;
}

+ (instancetype)proxyWithTarget:(id)target {
    return [[self alloc] initWithTarget:target];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    static NSArray<NSString *> *whiteNames = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        whiteNames = @[
            NSStringFromSelector(@selector(URLSession:dataTask:didReceiveResponse:completionHandler:)),
            NSStringFromSelector(@selector(URLSession:dataTask:didReceiveData:))
        ];
    });
    if ([whiteNames containsObject:NSStringFromSelector(selector)]) {
        return _handle;
    }
    return _handle.target;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_handle.target respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object {
    return [_handle.target isEqual:object];
}

- (NSUInteger)hash {
    return [_handle.target hash];
}

- (Class)superclass {
    return [_handle.target superclass];
}

- (Class)class {
    return [_handle.target class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_handle.target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_handle.target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_handle.target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [_handle.target description];
}

- (NSString *)debugDescription {
    return [_handle.target debugDescription];
}

@end
