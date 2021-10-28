//
//  CrashHelper.m
//  StyfStudyNotes
//
//  Created by styf on 2021/10/27.
//

#import "CrashHelper.h"

@interface TestObj : NSObject
/// <#name#>
@property (nonatomic, copy) NSString *name1;
@end

@implementation TestObj

@end


@interface CrashHelper ()
/// <#name#>
@property (nonatomic, assign) TestObj *obj;
@end

@implementation CrashHelper

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self registerCatch];
    
    _obj = [NSObject new];
    
    NSString *data = [[NSUserDefaults standardUserDefaults]objectForKey:@"Signal"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    label.text = data;
    label.backgroundColor = UIColor.yellowColor;
    label.numberOfLines = 0;
    [self.view addSubview:label];
}

- (void)dealloc {
    [self unregisterCatch];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *a = @[];
    a[1];
    
//    NSLog(@"---%@",_obj.name1);
}

- (void)registerCatch {
    NSSetUncaughtExceptionHandler(&HandleException);
    signal(SIGHUP, SignalHandler);
    signal(SIGINT, SignalHandler);
    signal(SIGQUIT, SignalHandler);
    signal(SIGILL, SignalHandler);
    signal(SIGTRAP, SignalHandler);
    signal(SIGABRT, SignalHandler);
#ifdef SIGPOLL
    signal(SIGPOLL, SignalHandler);
#endif
#ifdef SIGEMT
    signal(SIGEMT, SignalHandler);
#endif
    signal(SIGFPE, SignalHandler);
    signal(SIGKILL, SignalHandler);
    signal(SIGBUS, SignalHandler);
    signal(SIGSEGV, SignalHandler);
    signal(SIGSYS, SignalHandler);
    signal(SIGPIPE, SignalHandler);
    signal(SIGALRM, SignalHandler);
    signal(SIGTERM, SignalHandler);
    signal(SIGURG, SignalHandler);
    signal(SIGSTOP, SignalHandler);
    signal(SIGTSTP, SignalHandler);
    signal(SIGCONT, SignalHandler);
    signal(SIGCHLD, SignalHandler);
    signal(SIGTTIN, SignalHandler);
    signal(SIGTTOU, SignalHandler);
#ifdef SIGIO
    signal(SIGIO, SignalHandler);
#endif
    signal(SIGXCPU, SignalHandler);
    signal(SIGXFSZ, SignalHandler);
    signal(SIGVTALRM, SignalHandler);
    signal(SIGPROF, SignalHandler);
#ifdef SIGWINCH
    signal(SIGWINCH, SignalHandler);
#endif
#ifdef SIGINFO
    signal(SIGINFO, SignalHandler);
#endif
    signal(SIGUSR1, SignalHandler);
    signal(SIGUSR2, SignalHandler);
}

- (void)unregisterCatch {
    NSSetUncaughtExceptionHandler(nil);
    signal(SIGHUP, SIG_DFL);
    signal(SIGINT, SIG_DFL);
    signal(SIGQUIT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGTRAP, SIG_DFL);
    signal(SIGABRT, SIG_DFL);
#ifdef SIGPOLL
    signal(SIGPOLL, SIG_DFL);
#endif
#ifdef SIGEMT
    signal(SIGEMT, SIG_DFL);
#endif
    signal(SIGFPE, SIG_DFL);
    signal(SIGKILL, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGSYS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    signal(SIGALRM, SIG_DFL);
    signal(SIGTERM, SIG_DFL);
    signal(SIGURG, SIG_DFL);
    signal(SIGSTOP, SIG_DFL);
    signal(SIGTSTP, SIG_DFL);
    signal(SIGCONT, SIG_DFL);
    signal(SIGCHLD, SIG_DFL);
    signal(SIGTTIN, SIG_DFL);
    signal(SIGTTOU, SIG_DFL);
#ifdef SIGIO
    signal(SIGIO, SIG_DFL);
#endif
    signal(SIGXCPU, SIG_DFL);
    signal(SIGXFSZ, SIG_DFL);
    signal(SIGVTALRM, SIG_DFL);
    signal(SIGPROF, SIG_DFL);
#ifdef SIGWINCH
    signal(SIGWINCH, SIG_DFL);
#endif
#ifdef SIGINFO
    signal(SIGINFO, SIG_DFL);
#endif
    signal(SIGUSR1, SIG_DFL);
    signal(SIGUSR2, SIG_DFL);
}

+ (void)saveException:(NSException *)exception {
    
    NSLog(@"Exception:%@",@{
        @"exception.name":exception.name ?: @"",
        @"exception.reason":exception.reason ?: @"",
        @"exception.userInfo":exception.userInfo ?: @"",
        @"exception.callStackSymbols":exception.callStackSymbols ?: @"",
        @"thread":[NSThread currentThread].description ?: @""
    });
}

void HandleException(NSException *exception)
{
    [CrashHelper saveException:exception];
    [exception raise];
}

void SignalHandler(int sig)
{
    // See https://stackoverflow.com/questions/40631334/how-to-intercept-exc-bad-instruction-when-unwrapping-nil.
    NSString *name = @"Unknown signal";
    switch (sig) {
        case SIGHUP:{
            name = @"SIGHUP";
        }
            break;
        case SIGINT:{
            name = @"SIGINT";
        }
            break;
        case SIGQUIT:{
            name = @"SIGQUIT";
        }
            break;
        case SIGILL:{
            name = @"SIGILL";
        }
            break;
        case SIGTRAP:{
            name = @"SIGTRAP";
        }
            break;
        case SIGABRT:{
            name = @"SIGABRT";
        }
            break;
#ifdef SIGPOLL
        case SIGPOLL:{
            name = @"SIGPOLL";
        }
            break;
#endif
        case SIGEMT:{
            name = @"SIGEMT";
        }
            break;
        case SIGFPE:{
            name = @"SIGFPE";
        }
            break;
        case SIGKILL:{
            name = @"SIGKILL";
        }
            break;
        case SIGBUS:{
            name = @"SIGBUS";
        }
            break;
        case SIGSEGV:{
            name = @"SIGSEGV";
        }
            break;
        case SIGSYS:{
            name = @"SIGSYS";
        }
            break;
        case SIGPIPE:{
            name = @"SIGPIPE";
        }
            break;
        case SIGALRM:{
            name = @"SIGALRM";
        }
            break;
        case SIGTERM:{
            name = @"SIGTERM";
        }
            break;
        case SIGURG:{
            name = @"SIGURG";
        }
            break;
        case SIGSTOP:{
            name = @"SIGSTOP";
        }
            break;
        case SIGTSTP:{
            name = @"SIGTSTP";
        }
            break;
        case SIGCONT:{
            name = @"SIGCONT";
        }
            break;
        case SIGCHLD:{
            name = @"SIGCHLD";
        }
            break;
        case SIGTTIN:{
            name = @"SIGTTIN";
        }
            break;
        case SIGTTOU:{
            name = @"SIGTTOU";
        }
            break;
#ifdef SIGIO
        case SIGIO:{
            name = @"SIGIO";
        }
            break;
#endif
        case SIGXCPU:{
            name = @"SIGXCPU";
        }
            break;
        case SIGXFSZ:{
            name = @"SIGXFSZ";
        }
            break;
        case SIGVTALRM:{
            name = @"SIGVTALRM";
        }
            break;
        case SIGPROF:{
            name = @"SIGPROF";
        }
            break;
#ifdef SIGWINCH
        case SIGWINCH:{
            name = @"SIGWINCH";
        }
            break;
#endif
#ifdef SIGINFO
        case SIGINFO:{
            name = @"SIGINFO";
        }
            break;
#endif
        case SIGUSR1:{
            name = @"SIGUSR1";
        }
            break;
        case SIGUSR2:{
            name = @"SIGUSR2";
        }
            break;
    }

    NSArray *callStackSymbols = [NSThread callStackSymbols];
    
    
    NSString *string = [NSString stringWithFormat:@"Signal:%@",@{
        @"name":name,
        @"stackSymbols":callStackSymbols,
        @"thread":[NSThread currentThread].description
    }];
    
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"Signal"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    kill(getpid(), SIGKILL);
}
@end
