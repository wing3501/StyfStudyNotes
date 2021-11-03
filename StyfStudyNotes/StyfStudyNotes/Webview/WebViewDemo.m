//
//  WebViewDemo.m
//  StyfStudyNotes
//
//  Created by styf on 2021/5/7.
//

#import "WebViewDemo.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import "SingleWKProcessPool.h"
@interface WebViewDemo ()<WKHTTPCookieStoreObserver, WKNavigationDelegate, WKUIDelegate>
/// webview
@property (nonatomic, strong) WKWebView *webView;
/// 新建了一个cookieWebview专门处理cookie的问题
@property (nonatomic, strong) WKWebView *cookieWebview;
/// <#name#>
@property (nonatomic, strong) NSMutableSet *cookieURLs;
/// <#name#>
@property (nonatomic, copy) NSString *webviewCookie;
/// <#name#>
@property (nonatomic, strong) NSDictionary *cookieData;
@end

@implementation WebViewDemo


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSDictionary *cookieDict = @{@"name":@"zhangsan"};
    _cookieData = cookieDict;
    [self addCookieWithDict:cookieDict forHost:@".3dmgame.com"];
    [self createCookieScript:cookieDict];
    

    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    configuration.processPool = [SingleWKProcessPool sharedInstance];

    //创建webView
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    self.webView.navigationDelegate = self;

    NSString *urlString = @"https://www.3dmgame.com/";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
//    通过iOS8推出的WKUserContentController来管理webView的cookie，通过NSHTTPCookieStorage来管理网络请求的cookie，例如H5发出的请求。通过NSURLSession、NSURLConnection发出的请求，都会默认带上NSHTTPCookieStorage中的cookie，H5内部的请求也会被系统交给NSURLSession处理。
    
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [self.webView loadRequest:request];
    [self.webView.configuration.websiteDataStore.httpCookieStore addObserver:self]; //监听 wkhttpCookieStore
}


- (void)dealloc {
    [self.webView.configuration.websiteDataStore.httpCookieStore removeObserver:self];
}

- (void)createCookieScript:(NSDictionary *)cookieDict {
    NSMutableString *scriptString = [NSMutableString string];
    for (NSString *key in cookieDict.allKeys) {
        NSString *cookieString = [NSString stringWithFormat:@"%@=%@", key, cookieDict[key]];
        [scriptString appendString:[NSString stringWithFormat:@"document.cookie = '%@;expires=Fri, 31 Dec 9999 23:59:59 GMT;';", cookieString]];
    }
    self.webviewCookie = scriptString;
}

- (void)addCookieWithDict:(NSDictionary *)dict forHost:(NSString *)host {
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull value, BOOL * _Nonnull stop) {
        NSMutableDictionary *properties = [NSMutableDictionary dictionary];
        [properties setObject:key forKey:NSHTTPCookieName];
        [properties setObject:value forKey:NSHTTPCookieValue];
        [properties setObject:host forKey:NSHTTPCookieDomain];
        [properties setObject:@"/" forKey:NSHTTPCookiePath];
        [properties setValue:[NSDate dateWithTimeIntervalSinceNow:60*60*72] forKey:NSHTTPCookieExpires];
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:properties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }];
}

- (void)removeWKWebviewCookie {
    self.webviewCookie = nil;
    [self.cookieWebview.configuration.userContentController removeAllUserScripts];
    
    NSMutableArray<NSHTTPCookie *> *cookies = [NSMutableArray array];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull cookie, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.cookieData.allKeys containsObject:cookie.name]) {
            [cookies addObject:cookie];
        }
    }];
    
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull cookie, NSUInteger idx, BOOL * _Nonnull stop) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }];
}

- (void)setCookieWithUrl:(NSURL *)url {
    //判断此域名是否种过cookie，如果没有则种cookie
    NSString *host = [url host];
    if ([self.cookieURLs containsObject:host]) {
        return;
    }
    [self.cookieURLs addObject:host];
    
    WKUserScript *wkcookieScript = [[WKUserScript alloc] initWithSource:self.webviewCookie
                                                          injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                                       forMainFrameOnly:NO];
    [self.cookieWebview.configuration.userContentController addUserScript:wkcookieScript];
    
    NSString *baseWebUrl = [NSString stringWithFormat:@"%@://%@", url.scheme, url.host];
    [self.cookieWebview loadHTMLString:@"" baseURL:[NSURL URLWithString:baseWebUrl]];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    [self setCookieWithUrl:navigationAction.request.URL];
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark - WKHTTPCookieStoreObserver

//观察CookieStore
- (void)cookiesDidChangeInCookieStore:(WKHTTPCookieStore *)cookieStore API_AVAILABLE(ios(11.0)) {
    NSLog(@" %s ==== cookie 监听到发生了变化 ...", __func__);

//    //取 cookie
    [self getCookie];
}

//取cookie
- (void)getCookie {

    //document.cookie 方式取 cookie
    [self.webView evaluateJavaScript:@"document.cookie" completionHandler:^(NSString *cookies, NSError *_Nullable error) {
        NSLog(@"====document.cookie 取 cookies:%@ \n",cookies);
    }];

}

#pragma mark - getter

- (WKWebView *)cookieWebview {
    if (!_cookieWebview) {
        WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
        configuration.processPool = [SingleWKProcessPool sharedInstance];
        _cookieWebview = [[WKWebView alloc]initWithFrame:CGRectZero configuration:configuration];
    }
    return _cookieWebview;
}

- (NSMutableSet *)cookieURLs {
    if (!_cookieURLs) {
        _cookieURLs = [NSMutableSet set];
    }
    return _cookieURLs;
}
@end
