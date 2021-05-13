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
    
    NSString *urlString = @"";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\", \"Google Chrome\";v=\"90\"" forHTTPHeaderField:@"sec-ch-ua"];
    [request addValue:@"?0" forHTTPHeaderField:@"sec-ch-ua-mobile"];
    [request addValue:@"none" forHTTPHeaderField:@"sec-fetch-site"];
    [request addValue:@"navigate" forHTTPHeaderField:@"sec-fetch-mode"];
    [request addValue:@"?1" forHTTPHeaderField:@"sec-fetch-user"];
    [request addValue:@"document" forHTTPHeaderField:@"sec-fetch-dest"];
    
    //request携带
    [request setHTTPShouldHandleCookies:YES];
//    [request setValue:[NSString stringWithFormat:@"%@=%@;",@"name", @"lisi"] forHTTPHeaderField:@"Cookie"];

    NSString *str = @"cookie: cna=6sH0Fxu6KSACAbeBpyrblsJz"
    @"cookie: tracknick=%5Cu5929%5Cu9E45%5Cu4F24%5Cu5FC3"
    @"cookie: thw=cn"
    @"cookie: enc=x%2BtIUkq33Utr0D2uYbE%2FfMdcoh8Wfp%2FNNg0BIEDs2hADg95mnF%2Fm7HeXD%2BGmoGVY5umPEpO9uVqW6%2FSmRUImDA%3D%3D"
    @"cookie: hng=CN%7Czh-CN%7CCNY%7C156"
    @"cookie: t=9bd6e955b91b61417373e37532a2b3ff"
    @"cookie: lgc=%5Cu5929%5Cu9E45%5Cu4F24%5Cu5FC3"
    @"cookie: cookie2=2c4644f57b689e3d33bc8b5343dc3a18"
    @"cookie: _tb_token_=56e4ebe5d3733"
    @"cookie: v=0"
    @"cookie: xlly_s=1"
    @"cookie: _samesite_flag_=true"
    @"cookie: dnk=%5Cu5929%5Cu9E45%5Cu4F24%5Cu5FC3"
    @"cookie: publishItemObj=Ng%3D%3D"
    @"cookie: mt=ci=43_1"
    @"cookie: _m_h5_tk=00e32a0f358db35bc62e453abcf01ab6_1620358334086"
    @"cookie: _m_h5_tk_enc=cb07afd1f010f77c4621a3b64991f8e8"
    @"cookie: sgcookie=E100Vt2greBm3kb2sxxbqNygZxA7kzwsoz5JkaJpvH1RrNKZsnEj3OwTY%2FHkschC56y2zOXSEPlOvB9bsbjj10%2B1Zg%3D%3D"
    @"cookie: unb=233347633"
    @"cookie: uc1=cookie21=WqG3DMC9FxUx&existShop=false&cookie15=Vq8l%2BKCLz3%2F65A%3D%3D&cookie16=Vq8l%2BKCLySLZMFWHxqs8fwqnEw%3D%3D&pas=0&cookie14=Uoe2zXnKaksxSw%3D%3D"
    @"cookie: uc3=nk2=r7lQF6olJdU%3D&vt3=F8dCuwlORqQrWaJO7O4%3D&lg2=Vq8l%2BKCLz3%2F65A%3D%3D&id2=UUtIFvMn%2FaxK"
    @"cookie: csg=52202e55"
    @"cookie: cookie17=UUtIFvMn%2FaxK"
    @"cookie: skt=c7402da679febcda"
    @"cookie: existShop=MTYyMDM4ODA2NQ%3D%3D"
    @"cookie: uc4=id4=0%40U2lyjOaokd9v6qunkjfMUyK4K60%3D&nk4=0%40rVsqfQ8gRpMfzUOsMGSKogDOvA%3D%3D"
    @"cookie: _cc_=URm48syIZQ%3D%3D"
    @"cookie: _l_g_=Ug%3D%3D"
    @"cookie: sg=%E5%BF%833e"
    @"cookie: _nk_=%5Cu5929%5Cu9E45%5Cu4F24%5Cu5FC3"
    @"cookie: cookie1=U%2BbKNvji6fB7Fy4%2FzslyKMy2AbQjzmVs5u4zNZL67qM%3D"
    @"cookie: tfstk=ck6cBm_1fUgCIaAlO-9fD9pWph6GZmiykN7fUO5SPWSXLH6PidGrT1r_ZUbcBf1.."
    @"cookie: l=eBxU4ECIQ6fRVxQ9BOfwlurza77tRIRAguPzaNbMiOCP_G5W5c55W665qiYXCnGVh6kJR3JmV3D6BeYBcCqlgJqme5DDwLDmn"
    @"cookie: isg=BAMDfgPpZ__zEhU5j0WyBFF-ksGteJe6f_oPGDXgdmLZ9CMWvUu8C0luaoS61O-y";

    
    for (NSHTTPCookie *cookie in NSHTTPCookieStorage.sharedHTTPCookieStorage.cookies) {
        [NSHTTPCookieStorage.sharedHTTPCookieStorage deleteCookie:cookie];
    }
    
    NSArray *array = [str componentsSeparatedByString:@"cookie: "];
    for (NSString *s in array) {
        if (s.length) {
            NSArray *arr = [s componentsSeparatedByString:@"="];
            if (arr.count) {
                NSHTTPCookie *cookie = [self cookieWithDomain:url.host name:arr[0] value:arr[1]];
                [request setValue:[NSString stringWithFormat:@"%@;",[self _getCookieString:cookie]] forHTTPHeaderField:@"Cookie"];
                [NSHTTPCookieStorage.sharedHTTPCookieStorage setCookie:cookie];
            }
        }
    }
    
    NSDictionary *requestHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:NSHTTPCookieStorage.sharedHTTPCookieStorage.cookies];
    request.allHTTPHeaderFields = requestHeaderFields;
    
    
    //    //js注入写cookie
    //    //通过document.cookie设置Cookie
    //    WKUserContentController* userContentController = [[WKUserContentController alloc] init];
    //    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource: @"document.cookie = 'name=lisi_handsome';" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    //    [userContentController addUserScript:cookieScript];
    //    configuration.userContentController = userContentController;
    
//    NSHTTPCookie *cookie = [self cookieWithDomain:url.host name:@"name" value:@"lisi2"];
//    [request setValue:[NSString stringWithFormat:@"%@;",[self _getCookieString:cookie]] forHTTPHeaderField:@"Cookie"];
//
//    [NSHTTPCookieStorage.sharedHTTPCookieStorage setCookie:cookie];
//    NSDictionary *requestHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:NSHTTPCookieStorage.sharedHTTPCookieStorage.cookies];
//    request.allHTTPHeaderFields = requestHeaderFields;
    
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

- (NSHTTPCookie *)cookieWithDomain:(NSString *)cookieDomain
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
//    NSHTTPCookieStorage *cookieJar2 = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    int i = 1;
//    for (NSHTTPCookie *cookie in cookieJar2.cookies) {
//        NSLog(@"NSHTTPCookieStorage 中的cookie%@", cookie);
////        NSLog(@"cookie-%d:%@=%@",i++,cookie.name,cookie.value);
//    }
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
