//
//  Other.m
//  StyfStudyNotes
//
//  Created by styf on 2021/2/19.
//

#import "Other.h"

@interface Other ()
/// <#name#>
@property (nonatomic, assign) NSInteger data;
/// <#name#>
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;

@end

@implementation Other

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    _data = 1;
    _concurrentQueue = dispatch_queue_create("readwriteQueue", DISPATCH_QUEUE_CONCURRENT);
    
}

- (void)safeKeyPath {
#define MZKeyPath(OBJ, PATH) \
(((void)(NO && ((void)(((typeof(OBJ))nil).PATH), NO)), @# PATH))

    MZKeyPath(NSString *, lowercaseString.uppercaseString.length);
    MZKeyPath(self, title.lowercaseString.uppercaseString.UTF8String);
    
    (((void)(NO && ((void)(((typeof(self))nil).title.lowercaseString), NO)), @"title.lowercaseString"));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSInteger i = 0; i < 1000; i++) {
            [self readData];
        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSInteger i = 0; i < 1000; i++) {
            [self readData];
        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSInteger i = 0; i < 1000; i++) {
            [self writeData];
        }
    });
}

- (NSInteger)readData {
    __block NSInteger result;
    dispatch_sync(_concurrentQueue, ^{
        result = self.data;
        NSLog(@"读取：%ld",(long)result);
    });
    return result;
}
static NSInteger num = 1;
- (void)writeData {
    dispatch_barrier_async(_concurrentQueue, ^{
        num++;
        self.data = num;
        NSLog(@"写入：%ld",(long)num);
    });
}
@end
