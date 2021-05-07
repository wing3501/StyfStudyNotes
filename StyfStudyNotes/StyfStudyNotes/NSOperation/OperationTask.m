//
//  OperationTask.m
//  StyfStudyNotes
//
//  Created by styf on 2021/4/29.
//

#import "OperationTask.h"
#import <QuartzCore/QuartzCore.h>

@interface OperationTaskDoneBlockChecker : NSObject
/// block已经被执行过了
@property (nonatomic, readonly, assign) BOOL hasBeenCalled;
@end

@implementation OperationTaskDoneBlockChecker

- (void)dealloc {
    if (_hasBeenCalled)
        return;
    [NSException raise:NSInternalInconsistencyException format:@"doneBlock not called!"];
}

- (void)didCalled {
    _hasBeenCalled = YES;
}

@end

@interface OperationTask()
/// 同步任务block
@property (nonatomic, copy) SyncTaskBlock syncTaskBlock;
/// 异步任务block
@property (nonatomic, copy) AsyncTaskBlock asyncTaskBlock;

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
    _cost = CACurrentMediaTime();
    @synchronized (self) {
        if (self.isCancelled) {
            self.finished = YES;
            return;
        }
        
        self.finished = NO;
        self.executing = YES;
#ifdef DEBUG
        NSLog(@"任务:%@ 开始执行 %@",self.name,[NSThread currentThread]);
#endif
        
        if (self.syncTaskBlock) {
            self.syncTaskBlock();
            [self done];
        }else if (self.asyncTaskBlock) {
            OperationTaskDoneBlockChecker *checker = [[OperationTaskDoneBlockChecker alloc]init];
            self.asyncTaskBlock(^{
                if (checker.hasBeenCalled) {
                    return;
                }
                [checker didCalled];
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
#ifdef DEBUG
            _cost = (CACurrentMediaTime() - _cost) * 1000.0;
            NSLog(@"任务:%@ 执行结束,耗时：%f %@",self.name,_cost,[NSThread currentThread]);
#endif
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

- (void)dealloc {
//    NSLog(@"%@ --- dealloc",self.name);
}
@end
