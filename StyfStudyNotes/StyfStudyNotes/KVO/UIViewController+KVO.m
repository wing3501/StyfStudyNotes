//
//  UIViewController+KVO.m
//  StyfStudyNotes
//
//  Created by styf on 2021/11/3.
//

#import "UIViewController+KVO.h"
#import <objc/runtime.h>

static NSString *kvo_associateRemoveKey;

@interface UIViewControllerKVORemover : NSObject
/// vc
@property (nonatomic, weak) id vc;
/// kvokey
@property (nonatomic, copy) NSString *keypath;
@end

@implementation UIViewControllerKVORemover

- (void)dealloc {
    NSLog(@"UIViewControllerKVORemover dealloc");
    [_vc removeObserver:self forKeyPath:_keypath];
}

@end


@implementation UIViewController (KVO)

static void swizzleMethod(Class class,SEL origSel,SEL swizSel) {
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
     
    //class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        //origMethod and swizMethod already exist
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

- (void)swizzleVCinitMethod {
//    swizzleMethod([UIViewController class], @selector(initWithNibName:bundle:), @selector(kvo_initWithNibName:bundle:));
    swizzleMethod([UIViewController class], @selector(initWithCoder:), @selector(kvo_initWithCoder:));
    swizzleMethod([UIViewController class], @selector(init), @selector(kvo_init));
}

- (instancetype)kvo_init {
    id obj = [self kvo_init];
    [self addkvo];
    return obj;
}

- (instancetype)kvo_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    id obj = [self kvo_initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self addkvo];
    return obj;
}

- (instancetype)kvo_initWithCoder:(NSCoder *)coder {
    id obj = [self kvo_initWithCoder:coder];
    [self addkvo];
    return obj;
}

- (void)addkvo {
    NSString *identifier = [NSString stringWithFormat:@"kvo_%@", [[NSProcessInfo processInfo] globallyUniqueString]];
    UIViewControllerKVORemover *remover = [UIViewControllerKVORemover new];
    remover.vc = self;
    remover.keypath = identifier;
    [self addObserver:remover forKeyPath:identifier options:NSKeyValueObservingOptionNew context:nil];
    objc_setAssociatedObject(self, &kvo_associateRemoveKey, remover, OBJC_ASSOCIATION_RETAIN);
    
    Class kvoCls = object_getClass(self);
    NSLog(@"kvoCls------>%@",NSStringFromClass(kvoCls));
    Class originCls = class_getSuperclass(kvoCls);
    NSLog(@"originCls------>%@",NSStringFromClass(originCls));
    
    // 获取原来实现的encoding
    const char *originViewDidLoadEncoding = method_getTypeEncoding(class_getInstanceMethod(originCls, @selector(viewDidLoad)));
//    const char *originViewDidAppearEncoding = method_getTypeEncoding(class_getInstanceMethod(originCls, @selector(viewDidAppear:)));
//    const char *originViewWillAppearEncoding = method_getTypeEncoding(class_getInstanceMethod(originCls, @selector(viewWillAppear:)));

    // 重点，添加方法。
    class_addMethod(kvoCls, @selector(viewDidLoad), (IMP)kvo_viewDidLoad, originViewDidLoadEncoding);
//    class_addMethod(kvoCls, @selector(viewDidAppear:), (IMP)kvo_viewDidAppear, originViewDidAppearEncoding);
//    class_addMethod(kvoCls, @selector(viewWillAppear:), (IMP)kvo_viewWillAppear, originViewWillAppearEncoding);
    
    //instance ---- NSKVONotifying_KVODemoViewController ---- DemoViewController
    //               kvo_viewDidLoad                     ----     真正的viewDidLoad
}

static void kvo_viewDidLoad(UIViewController *kvo_self, SEL _sel)
{
    Class kvo_cls = object_getClass(kvo_self);
    Class origin_cls = class_getSuperclass(kvo_cls);

    // 注意点
    IMP origin_imp = method_getImplementation(class_getInstanceMethod(origin_cls, _sel));
    assert(origin_imp != NULL);

    void(*func)(UIViewController *, SEL) =  (void(*)(UIViewController *, SEL))origin_imp;

    NSDate *date = [NSDate date];

    func(kvo_self, _sel);

    NSTimeInterval duration = [[NSDate date] timeIntervalSinceDate:date];
    NSLog(@"Class %@ cost %g in viewDidLoad", [kvo_self class], duration);
}

@end
