//
//  SystemNotify.m
//  StyfStudyNotes
//
//  Created by styf on 2021/4/25.
//  iOS系统的底层通知框架库
//  https://juejin.cn/post/6844903837690494989
// 系统通知库中的通知消息注册和发送是可以用来实现跨进程通信的一种底层的通知机制。

#import "SystemNotify.h"
#include <notify.h>
#include <notify_keys.h>

@interface SystemNotify ()

@end

@implementation SystemNotify {
    int block_out_token;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self notifyRegister];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        printf("暂停-----\n");
        notify_suspend(block_out_token);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            printf("恢复-----\n");
            notify_resume(block_out_token);
        });
    });
}

- (void)notifyRegister {
//    //基于block处理的通知注册
//    uint32_t notify_register_dispatch(const char *name, int *out_token, dispatch_queue_t queue, notify_handler_t handler)
//
//    //基于信号处理的通知注册
//    uint32_t notify_register_signal(const char *name, int sig, int *out_token);
//
//    //基于mach port消息的通知注册
//    uint32_t notify_register_mach_port(const char *name, mach_port_t *notify_port, int flags, int *out_token);
//
//    //基于文件描述符的通知注册。
//    uint32_t notify_register_file_descriptor(const char *name, int *notify_fd, int flags, int *out_token);
    
    notify_register_dispatch("block_notify", &block_out_token, dispatch_get_main_queue(), ^(int token) {
        printf("block_notify-----\n");
    });
}

- (void)notifyPost {
//    uint32_t notify_post(const char *name);
    notify_post("block_notify");
}

- (void)notifySuspend {
//    //通知的暂停，设置后此token将暂时不会接受消息的通知。
//    uint32_t notify_suspend(int token)
//    //通知的恢复，设置后此token将恢复接受消息的通知。
//    uint32_t notify_resume(int token)
//    //通知的取消，设置后此token将不再接受消息的通知。
//    uint32_t notify_cancel(int token);

}

- (void)notifyState {
//    uint32_t notify_set_state(int token, uint64_t state64)
//    uint32_t notify_get_state(int token, uint64_t *state64)
}

- (void)notifySys {
//    操作系统底层支持了一些预置的通知消息，这些通知消息在头文件#include <notify_keys.h>中被声明。
    int  token1, token2, token3;
    //注册监听网络状态改变的通知。
    notify_register_dispatch(kNotifySCNetworkChange, & token1, dispatch_get_main_queue(), ^(int token) {
        //...
    });
     
    //注册监听系统磁盘空间不足的通知
    notify_register_dispatch(kNotifyVFSLowDiskSpaceRootFS, &token2, dispatch_get_main_queue(), ^(int token) {
        //....
    });
   //注册监听系统时间被改变的通知。
    notify_register_dispatch(kNotifyClockSet, &token3, dispatch_get_main_queue(), ^(int token) {
        //...
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self notifyPost];
}


@end
