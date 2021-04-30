//
//  TaskService.m
//  StyfStudyNotes
//
//  Created by styf on 2021/4/29.
//

#import "TaskService.h"
#import "OperationTask.h"
#import <QuartzCore/QuartzCore.h>

@interface TaskCollectionModel : NSObject
/// 任务标识
@property (nonatomic, copy) NSString *taskID;
/// 任务名称
@property (nonatomic, copy) NSString *taskName;
@end

@implementation TaskCollectionModel

- (instancetype)initWithTaskID:(NSString *)taskID taskName:(NSString *)taskName {
    self = [super init];
    if (self) {
        _taskID = taskID;
        _taskName = taskName;
    }
    return self;
}

+ (instancetype)modelWithTaskID:(NSString *)taskID taskName:(NSString *)taskName {
    return [[self alloc]initWithTaskID:taskID taskName:taskName];
}

@end

@interface TaskCollection : NSObject
/// 任务ID-->所在组下标
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSNumber *> *taskIDtoArrayIndex;
/// 任务名称数组
@property (nonatomic, strong) NSMutableArray<NSMutableArray<TaskCollectionModel *> *> *taskArray;
@end

@implementation TaskCollection

/// 添加任务到主队列
/// @param taskName 任务名称
/// @param taskID 任务标识
- (void)addTaskToMainQueue:(NSString *)taskName taskID:(NSString *)taskID {
    [self addTask:taskName taskID:taskID toArrayIndex:0];
}
/// 添加任务到串行队列
/// @param taskName 任务名称
/// @param taskID 任务标识
- (void)addTaskToSerialQueue:(NSString *)taskName taskID:(NSString *)taskID {
    [self addTask:taskName taskID:taskID toArrayIndex:1];
}
/// 添加任务到并发队列
/// @param taskName 任务名称
/// @param taskID 任务标识
- (void)addTaskToConcurrentQueue:(NSString *)taskName taskID:(NSString *)taskID {
    [self addTask:taskName taskID:taskID toArrayIndex:2];
}

/// 添加任务
/// @param taskName 任务名称
/// @param taskID 任务标识
/// @param index 第几组
- (void)addTask:(NSString *)taskName taskID:(NSString *)taskID toArrayIndex:(NSInteger)index {
    [self.taskIDtoArrayIndex setObject:@(index) forKey:taskID];
    NSMutableArray *array = self.taskArray[index];
    [array addObject:[TaskCollectionModel modelWithTaskID:taskID taskName:taskName]];
}

/// 移除任务
/// @param taskID 任务标识
- (void)removeTask:(NSString *)taskID {
    NSNumber *arrayIndex = [self.taskIDtoArrayIndex objectForKey:taskID];
    if (arrayIndex) {
        [self.taskIDtoArrayIndex removeObjectForKey:taskID];
        NSMutableArray *array = self.taskArray[arrayIndex.unsignedIntegerValue];
        NSInteger index = -1;
        for (NSInteger i = 0; i < array.count; i++) {
            TaskCollectionModel *model = array[i];
            if ([model.taskID isEqualToString:taskID]) {
                index = i;
                break;
            }
        }
        if (index > -1) {
            [array removeObjectAtIndex:index];
        }
    }
}

/// 查找任务名称
/// @param taskID 任务标识
- (NSString *)taskNameForTaskID:(NSString *)taskID {
    NSNumber *arrayIndex = [self.taskIDtoArrayIndex objectForKey:taskID];
    if (arrayIndex) {
        NSMutableArray *array = self.taskArray[arrayIndex.unsignedIntegerValue];
        for (NSInteger i = 0; i < array.count; i++) {
            TaskCollectionModel *model = array[i];
            if ([model.taskID isEqualToString:taskID]) {
                return model.taskName;
            }
        }
    }
    return nil;
}

/// 打印所有任务名称
- (void)printAllTaskName {
    NSLog(@"主队列任务：%ld",(long)self.taskArray[0].count);
    [self.taskArray[0] enumerateObjectsUsingBlock:^(TaskCollectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"任务%ld:%@",(long)(idx + 1),obj.taskName);
    }];
    
    NSLog(@"串行队列任务：%ld",(long)self.taskArray[1].count);
     [self.taskArray[1] enumerateObjectsUsingBlock:^(TaskCollectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         NSLog(@"任务%ld:%@",(long)(idx + 1),obj.taskName);
     }];
    
    NSLog(@"并行队列任务：%ld",(long)self.taskArray[2].count);
      [self.taskArray[2] enumerateObjectsUsingBlock:^(TaskCollectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          NSLog(@"任务%ld:%@",(long)(idx + 1),obj.taskName);
      }];
}

/// 集合是否为空
- (BOOL)isEmpty {
    return self.taskArray[0].count == 0 && self.taskArray[1].count == 0 && self.taskArray[2].count == 0;
}

- (NSMutableDictionary<NSString *,NSNumber *> *)taskIDtoArrayIndex {
    if (!_taskIDtoArrayIndex) {
        _taskIDtoArrayIndex = [NSMutableDictionary dictionary];
    }
    return _taskIDtoArrayIndex;
}

- (NSMutableArray<NSMutableArray<NSString *> *> *)taskArray {
    if (!_taskArray) {
        _taskArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 3; i++) {
            [_taskArray addObject:[NSMutableArray array]];
        }
    }
    return _taskArray;
}

@end

@interface TaskService()
/// 主队列
@property (nonatomic, strong) NSOperationQueue *mainQueue;
/// 自定义串行队列
@property (nonatomic, strong) NSOperationQueue *serialQueue;
/// 自定义并发队列 
@property (nonatomic, strong) NSOperationQueue *concurrentQueue;
/// 是否是第一个任务开始执行
@property (nonatomic, assign) BOOL isFirstTaskExecute;
/// 任务名称集合 打印日志用 非线程安全
@property (nonatomic, strong) TaskCollection *taskCollection;
/// 任务执行总时间
@property (nonatomic, assign) CFTimeInterval now;
@end

@implementation TaskService

#pragma mark - SingleInstance

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

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _isFirstTaskExecute = YES;
    }
    return self;
}

#pragma mark - public

/// 添加异步任务到主队列
/// @param name 任务名称
/// @param delay 延迟添加时间
/// @param block 任务操作
- (void)addAsyncTaskOnMainQueue:(NSString *)name afterDelay:(NSTimeInterval)delay executionBlock:(void(^)(void(^doneBlock)(void)))block {
    NSAssert(name.length != 0, @"必须填写任务名称!");
    OperationTask *task = [[OperationTask alloc]initWithAsyncTaskBlock:block];
    task.name = name;
    [self addObserverForTask:task];
#ifdef DEBUG
            [self.taskCollection addTaskToMainQueue:name taskID:[NSString stringWithFormat:@"%p",task]];
#endif
    if (delay == 0) {
        [self.mainQueue addOperation:task];
        NSLog(@"任务:%@ 添加到主队列",name);
    }else {
        NSLog(@"任务:%@ 延迟%.1fs添加到主队列",name,delay);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mainQueue addOperation:task];
        });
    }
}
- (void)addAsyncTaskOnMainQueue:(NSString *)name executionBlock:(void(^)(void(^doneBlock)(void)))block {
    [self addAsyncTaskOnMainQueue:name afterDelay:0 executionBlock:block];
}

/// 添加同步任务到主队列
/// @param name 任务名称
/// @param delay 延迟添加时间
/// @param block 任务操作
- (void)addSyncTaskOnMainQueue:(NSString *)name afterDelay:(NSTimeInterval)delay executionBlock:(void(^)(void))block {
    NSAssert(name.length != 0, @"必须填写任务名称!");
    OperationTask *task = [[OperationTask alloc]initWithSyncTaskBlock:block];
    task.name = name;
    [self addObserverForTask:task];
#ifdef DEBUG
    [self.taskCollection addTaskToMainQueue:delay == 0 ? name : [NSString stringWithFormat:@"延迟%.1fs_%@",delay,name] taskID:[NSString stringWithFormat:@"%p",task]];
#endif
    if (delay == 0) {
        [self.mainQueue addOperation:task];
        NSLog(@"任务:%@ 添加到主队列",name);
    }else {
        NSLog(@"任务:%@ 延迟%.1fs添加到主队列",name,delay);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mainQueue addOperation:task];
        });
    }
}

- (void)addSyncTaskOnMainQueue:(NSString *)name executionBlock:(void(^)(void))block {
    [self addSyncTaskOnMainQueue:name afterDelay:0 executionBlock:block];
}

/// 添加异步串行队列
/// @param name 任务名称
/// @param delay 延迟添加时间
/// @param block 任务操作
- (void)addTaskOnSerialQueue:(NSString *)name afterDelay:(NSTimeInterval)delay executionBlock:(void(^)(void))block {
    NSAssert(name.length != 0, @"必须填写任务名称!");
}

- (void)addTaskOnSerialQueue:(NSString *)name executionBlock:(void(^)(void))block {
    [self addTaskOnSerialQueue:name afterDelay:0 executionBlock:block];
}

/// 添加任务到异步并发任务
/// @param name 任务名称
/// @param delay 延迟添加时间
/// @param block 任务操作
- (void)addTaskOnConcurrentQueue:(NSString *)name afterDelay:(NSTimeInterval)delay executionBlock:(void(^)(void))block {
    NSAssert(name.length != 0, @"必须填写任务名称!");
}

- (void)addTaskOnConcurrentQueue:(NSString *)name executionBlock:(void(^)(void))block {
    [self addTaskOnConcurrentQueue:name afterDelay:0 executionBlock:block];
}

#pragma mark - private

/// 添加任务状态监听
/// @param task 任务
- (void)addObserverForTask:(id)task {
    [task addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
    [task addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew context:nil];
}

/// 打印所有任务
- (void)printAllTask {
    NSLog(@"------------------------------------------------");
    NSLog(@"任务填装完毕：");
    [self.taskCollection printAllTaskName];
    NSLog(@"------------------------------------------------");
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isExecuting"]) {
        BOOL isExecuting = [change[NSKeyValueChangeNewKey] boolValue];
        if (_isFirstTaskExecute && isExecuting) {
            _isFirstTaskExecute = NO;
#ifdef DEBUG
            _now = CACurrentMediaTime();
            //执行第一个任务前，打印一下本次所有的任务信息
            [self printAllTask];
#endif
        }
        
    }else if([keyPath isEqualToString:@"isFinished"]) {
        BOOL isFinished = [change[NSKeyValueChangeNewKey] boolValue];
        if (isFinished) {
#ifdef DEBUG
            [self.taskCollection removeTask:[NSString stringWithFormat:@"%p",object]];
            if ([self.taskCollection isEmpty]) {
                NSLog(@"任务全部结束，总耗时：%f",(CACurrentMediaTime() - self.now) * 1000.0);
            }
#endif
            if ([self.taskCollection isEmpty]) {
                _isFirstTaskExecute = YES;//所有任务结束后重置
            }
        }
    }
}

#pragma mark - getter and setter

- (NSOperationQueue *)mainQueue {
    if (!_mainQueue) {
        _mainQueue = [NSOperationQueue mainQueue];
    }
    return _mainQueue;
}

- (NSOperationQueue *)serialQueue {
    if (!_serialQueue) {
        _serialQueue = [[NSOperationQueue alloc]init];
        _serialQueue.maxConcurrentOperationCount = 1;
    }
    return _serialQueue;
}

- (NSOperationQueue *)concurrentQueue {
    if (!_concurrentQueue) {
        _concurrentQueue = [[NSOperationQueue alloc]init];
        _concurrentQueue.maxConcurrentOperationCount = 3;
    }
    return _concurrentQueue;
}

- (TaskCollection *)taskCollection {
    if (!_taskCollection) {
        _taskCollection = [[TaskCollection alloc]init];
    }
    return _taskCollection;
}
@end
