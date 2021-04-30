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
@interface DemoNSOperation ()

@end

@implementation DemoNSOperation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self serviceTest];
    
}

- (void)serviceTest {
    
    [[TaskService sharedInstance]addSyncTaskOnMainQueue:@"微博SDK" executionBlock:^{
        NSLog(@"微博SDK--初始化start");
        sleep(2);
        NSLog(@"微博SDK--初始化end");
    }];
//
//    [[TaskService sharedInstance] addAsyncTaskOnMainQueue:@"友盟SDK" afterDelay:0 executionBlock:^(void (^ _Nonnull doneBlock)(void)) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSLog(@"友盟SDK--初始化start %@",[NSThread currentThread]);
//            sleep(2);
//            NSLog(@"友盟SDK--初始化end");
//            doneBlock();
//        });
//    }];
    
    [[TaskService sharedInstance] addSyncTaskOnMainQueue:@"友盟SDK" afterDelay:2.1 executionBlock:^{
        NSLog(@"友盟SDK--初始化start");
        sleep(2);
        NSLog(@"友盟SDK--初始化end");
    }];
}

- (void)test {
    //    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //    queue.maxConcurrentOperationCount = 2;
    //    for (int i = 1; i < 5; i++) {
    //        NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
    //            sleep(1);
    //            NSLog(@"任务%d,当前线程%@", i, [NSThread currentThread]);
    //
    //        }];
    //        [queue addOperation:blockOperation];
    ////        [blockOperation start];
    //    }
        
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
    //        NSBlockOperation *AOperation=[NSBlockOperation blockOperationWithBlock:^{
    //            NSLog(@"任务A开始，当前线程%@", [NSThread currentThread]);
    //            sleep(1);
    //            NSLog(@"任务A完成，当前线程%@", [NSThread currentThread]);
    //        }];
    //        [queue addOperation:AOperation];
    //        NSBlockOperation *BOperation=[NSBlockOperation blockOperationWithBlock:^{
    //            NSLog(@"任务B开始，当前线程%@", [NSThread currentThread]);
    //            sleep(3);
    //            NSLog(@"任务B完成，当前线程%@", [NSThread currentThread]);
    //        }];
    //        [queue addOperation:BOperation];
    //        NSBlockOperation *COperation = [NSBlockOperation blockOperationWithBlock:^{
    //            NSLog(@"任务C开始，当前线程%@", [NSThread currentThread]);
    //            sleep(1);
    //            NSLog(@"任务C完成，当前线程%@", [NSThread currentThread]);
    //        }];
    //        //让操作C依赖操作A
    //        [COperation addDependency:AOperation];
    //        //让操作C依赖操作B
    //        [COperation addDependency:BOperation];
    //        //将操作C加入队列
    //        [queue addOperation:COperation];
        
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
