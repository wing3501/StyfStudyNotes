//
//  NetworkDemo.m
//  StyfStudyNotes
//
//  Created by styf on 2021/5/13.
//

#import "NetworkDemo.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

@interface NetworkDemo ()

@end

@implementation NetworkDemo

static AFHTTPSessionManager *_sessionManager;
+ (void)initialize
{
    if (self == [NetworkDemo class]) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.timeoutInterval = 5.f;
        [self setRequestSerializer];
        [self setResponseSerializer];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
}
+ (void)setRequestSerializer {
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer {
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [AFJSONResponseSerializer serializer];
    
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"开始请求---");
    NSURLSessionTask *sessionTask = [_sessionManager POST:@"https://www.baidu.com/" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *string = [[NSString alloc]initWithData:responseObject encoding:4];
        NSLog(@"请求成功:%@",string);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@",error);
    }];
}

@end
