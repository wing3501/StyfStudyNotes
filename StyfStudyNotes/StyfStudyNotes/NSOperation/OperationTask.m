//
//  OperationTask.m
//  StyfStudyNotes
//
//  Created by styf on 2021/4/29.
//

#import "OperationTask.h"
#import <QuartzCore/QuartzCore.h>

@interface OperationTask()
/// 同步任务block
@property (nonatomic, copy) SyncTaskBlock syncTaskBlock;
/// 异步任务block
@property (nonatomic, copy) AsyncTaskBlock asyncTaskBlock;
/// 执行时间
@property (nonatomic, assign) CFTimeInterval now;
@end

@implementation OperationTask

@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)initWithSyncTaskBlock:(SyncTaskBlock)syncTaskBlock {
    self = [super init];
    if (self) {
        _syncTaskBlock = syncTaskBlock;
    }
    return self;
}

- (instancetype)initWithAsyncTaskBlock:(AsyncTaskBlock)asyncTaskBlock {
    self = [super init];
    if (self) {
        _asyncTaskBlock = asyncTaskBlock;
    }
    return self;
}

- (void)start {
    _now = CACurrentMediaTime();
    @synchronized (self) {
        if (self.isCancelled) {
            self.finished = YES;
            return;
        }
        
        self.finished = NO;
        self.executing = YES;
        NSLog(@"任务:%@ 开始执行 %@",self.name,[NSThread currentThread]);
        
        if (self.syncTaskBlock) {
            self.syncTaskBlock();
            [self done];
        }else if (self.asyncTaskBlock) {
            self.asyncTaskBlock(^{
                [self done];
            });
        }else {
            self.executing = NO;
            self.finished = YES;
        }
    }
}

- (void)done {
    @synchronized (self) {
        if (self.isExecuting) {
            NSLog(@"任务:%@ 执行结束,耗时：%f",self.name,(CACurrentMediaTime() - _now) * 1000.0);
            self.executing = NO;
            self.finished = YES;
        }
    }
}

- (void)cancel {
    @synchronized (self) {
        [super cancel];
        if (self.isExecuting) {
            self.executing = NO;
            self.finished = YES;
        }
    }
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isAsynchronous {
    return YES;
}
@end
