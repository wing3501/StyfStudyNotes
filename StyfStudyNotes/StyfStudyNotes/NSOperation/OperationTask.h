//
//  OperationTask.h
//  StyfStudyNotes
//
//  Created by styf on 2021/4/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class OperationTask;
typedef void (^SyncTaskBlock)(void);
typedef void (^AsyncTaskBlock)(void(^doneBlock)(void));

@interface OperationTask : NSOperation

- (instancetype)initWithSyncTaskBlock:(SyncTaskBlock)syncTaskBlock;
- (instancetype)initWithAsyncTaskBlock:(AsyncTaskBlock)asyncTaskBlock;
@end

NS_ASSUME_NONNULL_END
