//
//  WebViewDemo.m
//  StyfStudyNotes
//
//  Created by styf on 2021/5/7.
//

#import "WebViewDemo.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>

@interface WebViewDemo ()<WKHTTPCookieStoreObserver, WKNavigationDelegate, WKUIDelegate>
/// webview
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation WebViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;

    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    self.webView.navigationDelegate = self;
    
    NSString *urlString = @"https://item.taobao.com/item.htm?id=631891547330";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    self.webView.customUserAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36";
    
    [request setHTTPShouldHandleCookies:YES];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [self.webView loadRequest:request];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"getCookie" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getCookie) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.height.equalTo(@50);
        make.width.equalTo(@100);
    }];
}

- (WKHTTPCookieStore *)wkHttpCookieStore {
    //return [WKWebsiteDataStore defaultDataStore].httpCookieStore;
    return self.webView.configuration.websiteDataStore.httpCookieStore;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    //方式1 读取wkwebview中的cookie
//    for (NSHTTPCookie *cookie in cookies) {
//        NSLog(@"wkwebview 中取出的cookie:%@", cookie);
////        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//    }

//    //方式2 读取Set-Cookie字段
//    NSString *cookieString = [[response allHeaderFields] valueForKey:@"Set-Cookie"];
//    NSLog(@"wkwebview 中取出的cookie:%@", cookieString);
//
//    //打印 NSHTTPCookieStorage 没有
    NSHTTPCookieStorage *cookieJar2 = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookieJar2.cookies) {
        NSLog(@"NSHTTPCookieStorage 中的cookie%@", cookie);
    }
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//取cookie
- (void)getCookie {

    // 使用WKHTTPCookieStore 取 cookie
    [self.wkHttpCookieStore getAllCookies:^(NSArray *cookies) {

        NSString *cookieText = @"";
        for (NSHTTPCookie *cookie in cookies) {
//            BOOL containDomain = [cookie.domain containsString:@"mytest.com"];
//            if (!containDomain) {  //判断是否是当前域
//                continue;
//            }

            cookieText = [NSString stringWithFormat:@"%@=%@;", cookie.name, cookie.value];
        }

        NSLog(@"====WKHTTPCookieStore 取 cookies:%@ \n", cookieText);

    }];

//    //document.cookie 方式取 cookie
//    [self.webView evaluateJavaScript:@"document.cookie" completionHandler:^(NSString *cookies, NSError *_Nullable error) {
//        NSLog(@"====document.cookie 取 cookies:%@ \n",cookies);
//    }];
}

@end
