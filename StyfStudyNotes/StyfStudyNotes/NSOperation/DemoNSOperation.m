//
//  DemoNSOperation.m
//  StyfStudyNotes
//
//  Created by styf on 2021/4/29.
//  https://www.jianshu.com/p/8620b30815ae
//  https://www.jianshu.com/p/cffd3ace0653

#import "DemoNSOperation.h"
#import "OperationTask.h"
#import "TaskService.h"
#import <QuartzCore/QuartzCore.h>
@interface DemoNSOperation ()
/// 串行队列
@property (nonatomic, strong) NSOperationQueue *serialQueue;
/// 并发队列
@property (nonatomic, strong) NSOperationQueue *concurrentQueue;
@end

@implementation DemoNSOperation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self serviceTest];
//    [self test];
}

- (void)serviceTest {
    _serialQueue = [[NSOperationQueue alloc] init];
    _serialQueue.maxConcurrentOperationCount = 1;

    _concurrentQueue = [[NSOperationQueue alloc] init];
    _concurrentQueue.maxConcurrentOperationCount = 2;
    
    OperationTask *A2 = [[OperationTask alloc]initWithAsyncTaskBlock:^(void (^ _Nonnull doneBlock)(void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"任务A2开始，当前线程%@", [NSThread currentThread]);
            sleep(2);
            NSLog(@"任务A2完成，当前线程%@", [NSThread currentThread]);
            doneBlock();
        });
    }];
    
    OperationTask *A3 = [[OperationTask alloc]initWithAsyncTaskBlock:^(void (^ _Nonnull doneBlock)(void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"任务A3开始，当前线程%@", [NSThread currentThread]);
            sleep(3);
            NSLog(@"任务A3完成，当前线程%@", [NSThread currentThread]);
            doneBlock();
        });
    }];
    
    OperationTask *A4 = [[OperationTask alloc]initWithAsyncTaskBlock:^(void (^ _Nonnull doneBlock)(void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"任务A4开始，当前线程%@", [NSThread currentThread]);
            sleep(4);
            NSLog(@"任务A4完成，当前线程%@", [NSThread currentThread]);
            doneBlock();
        });
    }];
    
    OperationTask *A5 = [[OperationTask alloc]initWithAsyncTaskBlock:^(void (^ _Nonnull doneBlock)(void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"任务A5开始，当前线程%@", [NSThread currentThread]);
            sleep(5);
            NSLog(@"任务A5完成，当前线程%@", [NSThread currentThread]);
            doneBlock();
        });
    }];
    
    OperationTask *A1 = [[OperationTask alloc]initWithAsyncTaskBlock:^(void (^ _Nonnull doneBlock)(void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"任务A1开始，当前线程%@", [NSThread currentThread]);
            sleep(1);
            NSLog(@"任务A1完成，当前线程%@", [NSThread currentThread]);
            [A4 cancel];
            [A5 cancel];
            doneBlock();
        });
    }];
    
    OperationTask *B1 = [[OperationTask alloc]initWithAsyncTaskBlock:^(void (^ _Nonnull doneBlock)(void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"任务B1开始，当前线程%@", [NSThread currentThread]);
            sleep(0.5);
            NSLog(@"任务B1完成，当前线程%@", [NSThread currentThread]);
            doneBlock();
        });
    }];
    
    OperationTask *B2 = [[OperationTask alloc]initWithAsyncTaskBlock:^(void (^ _Nonnull doneBlock)(void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"任务B2开始，当前线程%@", [NSThread currentThread]);
            sleep(4);
            NSLog(@"任务B2完成，当前线程%@", [NSThread currentThread]);
            doneBlock();
        });
    }];
    
    OperationTask *B3 = [[OperationTask alloc]initWithAsyncTaskBlock:^(void (^ _Nonnull doneBlock)(void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"任务B3开始，当前线程%@", [NSThread currentThread]);
            sleep(5);
            NSLog(@"任务B3完成，当前线程%@", [NSThread currentThread]);
            doneBlock();
        });
    }];
    
    [_concurrentQueue addOperation:A1];
    [_concurrentQueue addOperation:A2];
    [_concurrentQueue addOperation:A3];
    [_concurrentQueue addOperation:A4];
    [_concurrentQueue addOperation:A5];
    [_concurrentQueue addBarrierBlock:^{
        NSLog(@"所有A任务已经完成----%@",[NSThread currentThread]);
    }];

//    [_concurrentQueue addOperation:B1];
//    [_concurrentQueue addOperation:B2];
//    [_concurrentQueue addOperation:B3];
//    [_concurrentQueue addBarrierBlock:^{
//        NSLog(@"所有B任务已经完成----%@",[NSThread currentThread]);
//    }];
    
   
    
    //------------
//    [[TaskService sharedInstance]addSyncTaskOnMainQueue:@"微博SDK" executionBlock:^{
//        NSLog(@"微博SDK--初始化start");
//        sleep(2);
//        NSLog(@"微博SDK--初始化end");
//    }];
//
//    [[TaskService sharedInstance] addSyncTaskOnMainQueue:@"友盟SDK" afterDelay:2.1 executionBlock:^{
//        NSLog(@"友盟SDK--初始化start");
//        sleep(2);
//        NSLog(@"友盟SDK--初始化end");
//    }];
//
//    [[TaskService sharedInstance]addTaskOnSerialQueue:@"微信SDK" executionBlock:^{
//        NSLog(@"微信SDK--初始化start");
//        sleep(1);
//        NSLog(@"微信SDK--初始化end");
//    }];
//
//    [[TaskService sharedInstance]addTaskOnSerialQueue:@"支付宝SDK" executionBlock:^{
//        NSLog(@"支付宝SDK--初始化start");
//        sleep(1);
//        NSLog(@"支付宝SDK--初始化end");
//    }];
//
//    [[TaskService sharedInstance]addTaskOnSerialQueue:@"极光SDK" executionBlock:^{
//        NSLog(@"极光SDK--初始化start");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            sleep(1);
//            NSLog(@"极光SDK--do");
//        });
//        NSLog(@"极光SDK--初始化end");
//    }];
//
//    for (NSInteger i = 0; i < 10; i++) {
//        NSString *name = [NSString stringWithFormat:@"请求%ld",(long)i];
//        [[TaskService sharedInstance]addTaskOnConcurrentQueue:name executionBlock:^{
//            NSLog(@"%@--初始化start",name);
//            sleep(1);
//            NSLog(@"%@--初始化end",name);
//        }];
//    }
//
//    [[TaskService sharedInstance]addTaskOnConcurrentQueue:@"请求99" executionBlock:^{
//        NSLog(@"请求99--初始化start");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            sleep(3);
//            NSLog(@"请求99--do");
//        });
//        NSLog(@"请求99--初始化end");
//    }];
//
//    [[TaskService sharedInstance]addTaskOnConcurrentQueue:@"请求100" afterDelay:6 executionBlock:^{
//        NSLog(@"请求100--初始化start");
//        sleep(1);
//        NSLog(@"请求100--初始化end");
//    }];
//
//    [[TaskService sharedInstance]addAsyncTaskOnMainQueue:@"xxx" executionBlock:^(void (^ _Nonnull doneBlock)(void)) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            sleep(5);
//            doneBlock();
//        });
//    }];
    
//    [[TaskService sharedInstance]addSyncTaskOnMainQueue:@"主队列任务1" executionBlock:^{
//        NSLog(@"主队列任务1----do");
//    }];
//
//    [[TaskService sharedInstance]addAsyncTaskOnMainQueue:@"主队列任务2" executionBlock:^(void (^ _Nonnull doneBlock)(void)) {
//        NSLog(@"主队列任务2----do");
//        doneBlock();
//    }];
//
//    [[TaskService sharedInstance]addSyncTaskOnMainThread:@"主线程任务11" executionBlock:^{
//        NSLog(@"主线程任务11----do");
//        sleep(1);
//        NSLog(@"主线程任务11----done");
//    }];
//
//    [[TaskService sharedInstance]start];
//    NSLog(@"任务开始了--------------");
}

- (void)test {
    
    //------------并发+串行
//    _serialQueue = [[NSOperationQueue alloc] init];
//    _serialQueue.maxConcurrentOperationCount = 1;
//
//    _concurrentQueue = [[NSOperationQueue alloc] init];
//    _concurrentQueue.maxConcurrentOperationCount = 4;
//
//    NSBlockOperation *A1 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"任务A1开始，当前线程%@", [NSThread currentThread]);
//        sleep(1);
//        NSLog(@"任务A1完成，当前线程%@", [NSThread currentThread]);
//    }];
//
//    NSBlockOperation *A2 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"任务A2开始，当前线程%@", [NSThread currentThread]);
//        sleep(3);
//        NSLog(@"任务A2完成，当前线程%@", [NSThread currentThread]);
//    }];
//
//    NSBlockOperation *A3 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"任务A3开始，当前线程%@", [NSThread currentThread]);
//        sleep(2);
//        NSLog(@"任务A3完成，当前线程%@", [NSThread currentThread]);
//    }];
//
//    NSBlockOperation *A = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"任务A开始，当前线程%@", [NSThread currentThread]);
//        sleep(1);
//        NSLog(@"任务A完成，当前线程%@", [NSThread currentThread]);
//    }];
//
//    NSBlockOperation *B1 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"任务B1开始，当前线程%@", [NSThread currentThread]);
//        sleep(0.5);
//        NSLog(@"任务B1完成，当前线程%@", [NSThread currentThread]);
//    }];
//
//    NSBlockOperation *B2 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"任务B2开始，当前线程%@", [NSThread currentThread]);
//        sleep(1);
//        NSLog(@"任务B2完成，当前线程%@", [NSThread currentThread]);
//    }];
//
//    NSBlockOperation *B3 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"任务B3开始，当前线程%@", [NSThread currentThread]);
//        sleep(4);
//        NSLog(@"任务B3完成，当前线程%@", [NSThread currentThread]);
//    }];
//
//    NSBlockOperation *C1 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"任务C1开始，当前线程%@", [NSThread currentThread]);
//        sleep(3);
//        NSLog(@"任务C1完成，当前线程%@", [NSThread currentThread]);
//    }];
//
//    NSBlockOperation *C2 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"任务C2开始，当前线程%@", [NSThread currentThread]);
//        sleep(4);
//        NSLog(@"任务C2完成，当前线程%@", [NSThread currentThread]);
//    }];
//
//    NSBlockOperation *C3 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"任务C3开始，当前线程%@", [NSThread currentThread]);
//        sleep(5);
//        NSLog(@"任务C3完成，当前线程%@", [NSThread currentThread]);
//    }];
//
//    [_concurrentQueue addOperation:A1];
//    [_concurrentQueue addOperation:A2];
//    [_concurrentQueue addOperation:A3];
//    [_concurrentQueue addBarrierBlock:^{
//        NSLog(@"所有A任务已经完成----%@",[NSThread currentThread]);
//    }];
//
//    [_concurrentQueue addOperation:B1];
//    [_concurrentQueue addOperation:B2];
//    [_concurrentQueue addOperation:B3];
//    [_concurrentQueue addBarrierBlock:^{
//        NSLog(@"所有B任务已经完成----%@",[NSThread currentThread]);
//    }];
//
//    [_concurrentQueue addOperation:C1];
//    [_concurrentQueue addOperation:C2];
//    [_concurrentQueue addOperation:C3];
//    [_concurrentQueue addBarrierBlock:^{
//        NSLog(@"所有C任务已经完成----%@",[NSThread currentThread]);
//    }];
    
    //---------------------
//        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//        queue.maxConcurrentOperationCount = 2;
//        for (int i = 1; i < 5; i++) {
//            NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
//                sleep(1);
//                NSLog(@"任务%d,当前线程%@", i, [NSThread currentThread]);
//
//            }];
//            [queue addOperation:blockOperation];
//    //        [blockOperation start];
//        }
        
    //    OperationTask *o1 = [[OperationTask alloc]init];
    //    o1.name = @"任务1";
    //    OperationTask *o2 = [[OperationTask alloc]init];
    //    o2.name = @"任务2";
    //    [queue addOperation:o1];
    //    [queue addOperation:o2];
    //    [o1 addDependency:o2];
        
    //    NSBlockOperation *blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
    //        NSLog(@"任务111111");
    //        sleep(1);
    //        NSLog(@"任务111111完成");
    //    }];
    //    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
    //        NSLog(@"任务222222");
    //        sleep(2);
    //        NSLog(@"任务222222完成");
    //    }];
    //    [blockOperation1 addDependency:blockOperation2];
    //    [queue addOperation:blockOperation2];
    //    [queue addOperation:blockOperation1];
        
        
        //创建操作队列
            //创建最后一个操作
//            NSBlockOperation *AOperation=[NSBlockOperation blockOperationWithBlock:^{
//                NSLog(@"任务A开始，当前线程%@", [NSThread currentThread]);
//                sleep(1);
//                NSLog(@"任务A完成，当前线程%@", [NSThread currentThread]);
//            }];
//            [queue addOperation:AOperation];
//            NSBlockOperation *BOperation=[NSBlockOperation blockOperationWithBlock:^{
//                NSLog(@"任务B开始，当前线程%@", [NSThread currentThread]);
//                sleep(3);
//                NSLog(@"任务B完成，当前线程%@", [NSThread currentThread]);
//            }];
//            [queue addOperation:BOperation];
//            NSBlockOperation *COperation = [NSBlockOperation blockOperationWithBlock:^{
//                NSLog(@"任务C开始，当前线程%@", [NSThread currentThread]);
//                sleep(1);
//                NSLog(@"任务C完成，当前线程%@", [NSThread currentThread]);
//            }];
//            //让操作C依赖操作A
//            [COperation addDependency:AOperation];
//            //让操作C依赖操作B
//            [COperation addDependency:BOperation];
//            //将操作C加入队列
//            [queue addOperation:COperation];
        
    //    for (int i = 1; i < 2; i++) {
    //            dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //                NSLog(@"GCD第%d次任务，子线程%@", i, [NSThread currentThread]);
    //                NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
    ////                    sleep(1);
    //                    NSLog(@"任务%d,当前i线程%@", i, [NSThread currentThread]);
    //                }];
    //                [blockOperation start];
    //            });
    //        }
    //        NSLog(@"主线程执行，当前线程%@",[NSThread currentThread]);
        
        
        
    //    NSOperationQueue *queue= [NSOperationQueue mainQueue];
    //    NSBlockOperation * blockOperation = [NSBlockOperation blockOperationWithBlock:^{
    //        NSLog(@"操作开始执行 %@", [NSThread currentThread]);
    //        sleep(2);
    //        NSLog(@"操作结束执行 %@", [NSThread currentThread]);
    //    }];
    //    [queue addOperation:blockOperation];
    //    for (int i = 0; i < 5; i++) {
    //        [blockOperation addExecutionBlock:^{
    //            sleep(1);
    //            NSLog(@"追加操作--%d %@", i, [NSThread currentThread]);
    //        }];
    //    }
        
    //    OperationTask *task = [[OperationTask alloc]initWithTaskBlock:^(OperationTask * _Nonnull task) {
    //        NSLog(@"操作开始执行 %@", [NSThread currentThread].name);
    //        sleep(2);
    //        NSLog(@"操作结束执行 %@", [NSThread currentThread].name);
    //    }];
    //    task.completionBlock = ^{
    //        NSLog(@"结束了");
    //    };
    //    [task addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
    //    [task addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew context:nil];
    //    [task start];
}

@end
