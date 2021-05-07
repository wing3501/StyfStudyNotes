//
//  TaskService.h
//  StyfStudyNotes
//
//  Created by styf on 2021/4/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define SyncTask(name,block) [[TaskService sharedInstance] addSyncTaskOnMainThread:name executionBlock:block];
#define AsyncTask(name,block) [[TaskService sharedInstance] addTaskOnConcurrentQueue:name executionBlock:block];

@interface TaskService : NSObject

+ (instancetype)sharedInstance;

/// 添加主线程阻塞任务
/// @param name 任务名称
/// @param block 任务操作
- (void)addSyncTaskOnMainThread:(NSString *)name executionBlock:(void(^)(void))block;

/// 添加异步任务到主队列
/// @param name 任务名称
/// @param delay 延迟添加时间
/// @param block 任务操作
- (void)addAsyncTaskOnMainQueue:(NSString *)name afterDelay:(NSTimeInterval)delay executionBlock:(void(^)(void(^doneBlock)(void)))block;
- (void)addAsyncTaskOnMainQueue:(NSString *)name executionBlock:(void(^)(void(^doneBlock)(void)))block;

/// 添加同步任务到主队列
/// @param name 任务名称
/// @param delay 延迟添加时间
/// @param block 任务操作
- (void)addSyncTaskOnMainQueue:(NSString *)name afterDelay:(NSTimeInterval)delay executionBlock:(void(^)(void))block;
- (void)addSyncTaskOnMainQueue:(NSString *)name executionBlock:(void(^)(void))block;

/// 添加异步串行队列
/// @param name 任务名称
/// @param delay 延迟添加时间
/// @param block 任务操作
- (void)addTaskOnSerialQueue:(NSString *)name afterDelay:(NSTimeInterval)delay executionBlock:(void(^)(void))block;
- (void)addTaskOnSerialQueue:(NSString *)name executionBlock:(void(^)(void))block;

/// 添加任务到异步并发队列
/// @param name 任务名称
/// @param delay 延迟添加时间
/// @param block 任务操作
- (void)addTaskOnConcurrentQueue:(NSString *)name afterDelay:(NSTimeInterval)delay executionBlock:(void(^)(void))block;
- (void)addTaskOnConcurrentQueue:(NSString *)name executionBlock:(void(^)(void))block;


/// 开始处理任务
- (void)start;
@end

NS_ASSUME_NONNULL_END
