//
//  LazyLoadDynamicFramework.m
//  StyfStudyNotes
//
//  Created by styf on 2021/4/12.
//  参考资料：https://www.jianshu.com/p/3063053a6114

#import "LazyLoadDynamicFramework.h"
#include <mach-o/dyld.h>
#include <dlfcn.h>
//#import <SDWebImage/SDWebImage.h>

typedef void(^MySDImageLoaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL);
typedef void(^MySDInternalCompletionBlock)(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, NSInteger cacheType, BOOL finished, NSURL * _Nullable imageURL);

@protocol MySDWebImageManager <NSObject>

- (id)loadImageWithURL:(NSURL *)url options:(NSUInteger)options progress:(MySDImageLoaderProgressBlock)progressBlock completed:(MySDInternalCompletionBlock)completedBlock;

+ (nonnull instancetype)sharedManager;
@end

@interface LazyLoadDynamicFramework ()
///
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LazyLoadDynamicFramework

static void _rebind_symbols_for_image(const struct mach_header *header,
                                      intptr_t slide) {
    Dl_info info;
    if (dladdr(header, &info) == 0) {
      return;
    }
//    printf("image: %s",info.dli_fname);
}

+ (void)load {
    _dyld_register_func_for_add_image(_rebind_symbols_for_image);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = CGRectMake(100, 100, 200, 200);
    _imageView.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:_imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self loadImage1];
    
    [self loadImage2];
}

- (void)loadImage1 {
//    [[SDWebImageManager sharedManager]loadImageWithURL:[NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3153405721,1524067674&fm=26&gp=0.jpg"] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//        self.imageView.image = image;
//    }];
}

- (void)loadImage2 {
    //删除 OTHER_LDFLAGS = -framework "SDWebImage"
    Class class = NSClassFromString(@"SDWebImageManager");
    if (!class) {
        NSLog(@"SDWebImageManager 不存在");
        [self lazyLoadFrameWork:@"SDWebImage"];
    }else {
        NSLog(@"SDWebImageManager 已存在");
        Class<MySDWebImageManager> myClass = class;
        [[myClass sharedManager] loadImageWithURL:[NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3153405721,1524067674&fm=26&gp=0.jpg"] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, NSInteger cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            self.imageView.image = image;
        }];
    }
}

- (void *)lazyLoadFrameWork:(NSString *)frameworkName{
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingFormat:@"/Frameworks/%@.framework/%@",frameworkName,frameworkName];
    void *rest = dlopen([path UTF8String], RTLD_LAZY);
    return rest;
}

@end
