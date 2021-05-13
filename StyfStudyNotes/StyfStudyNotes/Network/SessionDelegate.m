//
//  SessionDelegate.m
//  WeiPaiTangClient
//
//  Created by styf on 2021/5/12.
//  Copyright © 2021 styf. All rights reserved.
//

#import "SessionDelegate.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define MakeSureRespodsTo if (![self.forwardToDelegate respondsToSelector:_cmd]) { return ;}

@interface SessionDelegate()<NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionDataDelegate,NSURLSessionDownloadDelegate,NSURLSessionStreamDelegate,NSURLSessionWebSocketDelegate>
/// 原代理
@property (nonatomic, weak) id<NSURLSessionDelegate> forwardToDelegate;
@end

@implementation SessionDelegate

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [self swizzleSessionWithConfiguration];
    });
}

+ (instancetype)proxyWithSessionDelegate:(id<NSURLSessionDelegate>)delegate {
    return [[self alloc]initWithSessionDelegate:delegate];
}

- (instancetype)initWithSessionDelegate:(id<NSURLSessionDelegate>)delegate {
    self = [super init];
    if (self) {
        _forwardToDelegate = delegate;
    }
    return self;
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
    return [self mySessionWithConfiguration:configuration delegate:[SessionDelegate proxyWithSessionDelegate:delegate] delegateQueue:queue];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [self.forwardToDelegate respondsToSelector:aSelector];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    MakeSureRespodsTo
    [self.forwardToDelegate URLSession:session didBecomeInvalidWithError:error];
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    MakeSureRespodsTo
    [self.forwardToDelegate URLSession:session didReceiveChallenge:challenge completionHandler:completionHandler];
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    MakeSureRespodsTo
    [self.forwardToDelegate URLSessionDidFinishEventsForBackgroundURLSession:session];
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
                        willBeginDelayedRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLSessionDelayedRequestDisposition disposition, NSURLRequest * _Nullable newRequest))completionHandler API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0)) {
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession *, NSURLSessionTask *, NSURLRequest *, id))objc_msgSend)(self.forwardToDelegate, _cmd, session, task, request, completionHandler);
}

- (void)URLSession:(NSURLSession *)session taskIsWaitingForConnectivity:(NSURLSessionTask *)task
API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0)) {
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession *, NSURLSessionTask *))objc_msgSend)(self.forwardToDelegate, _cmd, session, task);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
                     willPerformHTTPRedirection:(NSHTTPURLResponse *)response
                                     newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionTask *, NSHTTPURLResponse *,NSURLRequest *, id))objc_msgSend)(self.forwardToDelegate, _cmd, session, task, response, request, completionHandler);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
                            didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionTask *, NSURLAuthenticationChallenge *, id))objc_msgSend)(self.forwardToDelegate, _cmd, session, task, challenge, completionHandler);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream * _Nullable bodyStream))completionHandler {
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionTask *, id))objc_msgSend)(self.forwardToDelegate, _cmd, session, task, completionHandler);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
                                didSendBodyData:(int64_t)bytesSent
                                 totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionTask *, int64_t, int64_t, int64_t))objc_msgSend)(self.forwardToDelegate, _cmd, session, task, bytesSent, totalBytesSent, totalBytesExpectedToSend);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0)) {
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionTask *, NSURLSessionTaskMetrics *))objc_msgSend)(self.forwardToDelegate, _cmd, session, task, metrics);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionTask *, NSError *))objc_msgSend)(self.forwardToDelegate, _cmd, session, task, error);
}

#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
                                 didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"拦截1111----request:%@",dataTask.currentRequest);
    NSLog(@"拦截1111----response:%@",response);
    
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionDataTask *, NSURLResponse *, id))objc_msgSend)(self.forwardToDelegate, _cmd, session, dataTask, response, completionHandler);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionDataTask *, NSURLSessionDownloadTask *))objc_msgSend)(self.forwardToDelegate, _cmd, session, dataTask, downloadTask);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
                                didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask
API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0)) {
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionDataTask *, NSURLSessionStreamTask *))objc_msgSend)(self.forwardToDelegate, _cmd, session, dataTask, streamTask);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    NSString *str = [[NSString alloc]initWithData:data encoding:4];
    NSLog(@"拦截2222----%@ data:%@",dataTask.currentRequest.URL,str);
    
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionDataTask *, NSData *))objc_msgSend)(self.forwardToDelegate, _cmd, session, dataTask, data);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
                                  willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler {
    MakeSureRespodsTo
    ((void (*)(id, SEL, NSURLSession*, NSURLSessionDataTask *, NSCachedURLResponse *, id))objc_msgSend)(self.forwardToDelegate, _cmd, session, dataTask, proposedResponse, completionHandler);
}

#pragma mark - NSURLSessionDownloadDelegate

#pragma mark - NSURLSessionStreamDelegate
//
//- (void)URLSession:(NSURLSession *)session readClosedForStreamTask:(NSURLSessionStreamTask *)streamTask {
//    MakeSureRespodsTo
//    ((void (*)(id, SEL, NSURLSession*, NSURLSessionStreamTask *))objc_msgSend)(self.forwardToDelegate, _cmd, session, streamTask);
//}
//
//- (void)URLSession:(NSURLSession *)session writeClosedForStreamTask:(NSURLSessionStreamTask *)streamTask {
//    MakeSureRespodsTo
//    ((void (*)(id, SEL, NSURLSession*, NSURLSessionStreamTask *))objc_msgSend)(self.forwardToDelegate, _cmd, session, streamTask);
//}
//
//- (void)URLSession:(NSURLSession *)session betterRouteDiscoveredForStreamTask:(NSURLSessionStreamTask *)streamTask {
//    MakeSureRespodsTo
//    ((void (*)(id, SEL, NSURLSession*, NSURLSessionStreamTask *))objc_msgSend)(self.forwardToDelegate, _cmd, session, streamTask);
//}
//
//- (void)URLSession:(NSURLSession *)session streamTask:(NSURLSessionStreamTask *)streamTask
//                                 didBecomeInputStream:(NSInputStream *)inputStream
//      outputStream:(NSOutputStream *)outputStream {
//    MakeSureRespodsTo
//    ((void (*)(id, SEL, NSURLSession*, NSURLSessionStreamTask *, NSInputStream *, NSOutputStream *))objc_msgSend)(self.forwardToDelegate, _cmd, session, streamTask, inputStream, outputStream);
//}

#pragma mark - NSURLSessionWebSocketDelegate
@end
