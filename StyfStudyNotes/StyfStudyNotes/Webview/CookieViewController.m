//
//  CookieViewController.m
//  StyfStudyNotes
//
//  Created by styf on 2021/11/2.
//

#import "CookieViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
@interface CookieViewController ()<WKHTTPCookieStoreObserver, WKNavigationDelegate, WKUIDelegate>
/// webview
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation CookieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;

    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];

    
//    //js注入写cookie
//    //通过document.cookie设置Cookie
//    WKUserContentController* userContentController = [[WKUserContentController alloc] init];
//    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource: @"document.cookie = 'name=lisi_handsome';" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
//    [userContentController addUserScript:cookieScript];
//    configuration.userContentController = userContentController;

    
    
    //创建webView
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    self.webView.navigationDelegate = self;

    NSString *urlString = @"http://mytest.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    //request携带
    [request setHTTPShouldHandleCookies:YES];
//    [request setValue:[NSString stringWithFormat:@"%@=%@;",@"name", @"lisi"] forHTTPHeaderField:@"Cookie"];

    NSHTTPCookie *cookie = [CookieViewController cookieWithDomain:url.host name:@"name" value:@"lisi2"];
    [request setValue:[NSString stringWithFormat:@"%@;",[self _getCookieString:cookie]] forHTTPHeaderField:@"Cookie"];

//    [NSHTTPCookieStorage.sharedHTTPCookieStorage setCookie:cookie];
//    NSDictionary *requestHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:NSHTTPCookieStorage.sharedHTTPCookieStorage.cookies];
//    request.allHTTPHeaderFields = requestHeaderFields;
//
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [self.webView loadRequest:request];


//    NSHTTPCookie *cookie = [DCookieViewController cookieWithDomain:url.host name:@"name" value:@"zhangsan"];
//    //iOS 11, 正确的方式
//    WKWebsiteDataStore.defaultDataStore.httpCookieStore addObserver:(nonnull id<WKHTTPCookieStoreObserver>)
//    //[self.wkHttpCookieStore addObserver:(nonnull id<WKHTTPCookieStoreObserver>)]
//    __weak typeof(self) weakSelf = self; //block
//    [self.wkHttpCookieStore setCookie:cookie completionHandler:^{
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [weakSelf.webView loadRequest:request];
//    }];
    

}


- (void)dealloc {
    [self.webView.configuration.websiteDataStore.httpCookieStore removeObserver:self];
}

- (NSString *)_getCookieString:(NSHTTPCookie *)cookie {

    NSString *string = [NSString stringWithFormat:@"%@=%@;domain=%@;expiresDate=%@;path=%@;sessionOnly=%@;isSecure=%@",
                                                  cookie.name,
                                                  cookie.value,
                                                  cookie.domain,
                                                  cookie.expiresDate,
                                                  cookie.path ?: @"/",
                                                  cookie.isSecure ? @"TRUE":@"FALSE",
                                                  cookie.sessionOnly ? @"TRUE":@"FALSE"];

    return string;
}

- (WKHTTPCookieStore *)wkHttpCookieStore {
    //return [WKWebsiteDataStore defaultDataStore].httpCookieStore;
    return self.webView.configuration.websiteDataStore.httpCookieStore;
}

+ (NSHTTPCookie *)cookieWithDomain:(NSString *)cookieDomain
                              name:(NSString *)cookieName
                             value:(NSString *)cookieValue {
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    properties[NSHTTPCookieName] = cookieName;
    properties[NSHTTPCookieValue] = cookieValue;
    properties[NSHTTPCookieDomain] = cookieDomain;
    properties[NSHTTPCookiePath] = @"/";

    //有效时间
    properties[NSHTTPCookieExpires] = [NSDate dateWithTimeInterval:365 * 86400 sinceDate:[NSDate new]];

    NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
    return cookie;
}


/*
//设cookie
- (void)setCookie {

    //cookie重新回调
    [self.wkHttpCookieStore addObserver:self]; //监听 wkhttpCookieStore
    for (NSHTTPCookie *cookie in NSHTTPCookieStorage.sharedHTTPCookieStorage.cookies) {
        [self.wkHttpCookieStore setCookie:cookie completionHandler:^{
            NSLog(@"====wkhttpCookieStore %s 成功回调", __func__);
        }];
    }

}

//js方式设置cookie
- (NSString *)setCcookieJS {
    NSMutableString *jsScript = [NSMutableString string];
    [jsScript appendString:@"var cookieNames = document.cookie.split('; ').map(function(cookie) { return cookie.split('=')[0] } );\n"];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        if ([cookie.value rangeOfString:@"'"].location != NSNotFound) {
            continue;
        }
        NSString *string = [NSString stringWithFormat:@"%@=%@;domain=%@;path=%@",
                                                      cookie.name,
                                                      cookie.value,
                                                      cookie.domain,
                                                      cookie.path ?: @"/"];

        [jsScript appendFormat:@"if (cookieNames.indexOf('%@') == -1) { document.cookie='%@'; };\n", cookie.name, string];
    }
    return jsScript;
}

//#pragma mark - WKNavigationDelegate
//
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
//    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
//    //方式1 读取wkwebview中的cookie
//    for (NSHTTPCookie *cookie in cookies) {
//        NSLog(@"wkwebview 中取出的cookie:%@", cookie);
////        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//    }
//
//    //方式2 读取Set-Cookie字段
//    NSString *cookieString = [[response allHeaderFields] valueForKey:@"Set-Cookie"];
//    NSLog(@"wkwebview 中取出的cookie:%@", cookieString);
//
//    //打印 NSHTTPCookieStorage 没有
//    NSHTTPCookieStorage *cookieJar2 = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in cookieJar2.cookies) {
//        NSLog(@"NSHTTPCookieStorage 中的cookie%@", cookie);
//    }
//    decisionHandler(WKNavigationResponsePolicyAllow);
//}

#pragma mark - WKHTTPCookieStoreObserver

//观察CookieStore
- (void)cookiesDidChangeInCookieStore:(WKHTTPCookieStore *)cookieStore API_AVAILABLE(ios(11.0)) {
    NSLog(@" %s ==== cookie 监听到发生了变化 ...", __func__);

//    //取 cookie
//    [self getCookie];
}

//取cookie
- (void)getCookie {

    // 使用WKHTTPCookieStore 取 cookie
    [self.wkHttpCookieStore getAllCookies:^(NSArray *cookies) {

        NSString *cookieText = @"";
        for (NSHTTPCookie *cookie in cookies) {
            BOOL containDomain = [cookie.domain containsString:@"mytest.com"];
            if (!containDomain) {  //判断是否是当前域
                continue;
            }

            cookieText = [NSString stringWithFormat:@"%@=%@;", cookie.name, cookie.value];
        }

        NSLog(@"====WKHTTPCookieStore 取 cookies:%@ \n", cookieText);

    }];

//    //document.cookie 方式取 cookie
//    [self.webView evaluateJavaScript:@"document.cookie" completionHandler:^(NSString *cookies, NSError *_Nullable error) {
//        NSLog(@"====document.cookie 取 cookies:%@ \n",cookies);
//    }];


}
*/
@end
