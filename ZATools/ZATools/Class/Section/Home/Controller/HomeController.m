//
//  ViewController.m
//  ZATools
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeController.h"
#import <React/RCTRootView.h>
#import <WebKit/WKWebView.h>
#import "WKWebViewJavascriptBridge.h"

@interface HomeController () <WKUIDelegate,WKNavigationDelegate>

@end

@implementation HomeController


-(NSString *)title{
    return @"首页";
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addReactView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebView{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    NSSet *dataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:dataTypes modifiedSince:[NSDate dateWithTimeIntervalSince1970:0] completionHandler:^{
        
    }];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20.f]];
    webView.navigationDelegate = self;
//    WKWebViewJavascriptBridge *bridge = [WKWebViewJavascriptBridge bridgeForWebView:webView];
    [self.view addSubview:webView];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)addReactView{
    NSURL *jsCodeLocation;
#ifdef DEBUG
    jsCodeLocation = [NSURL
                             URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
#else
    jsCodeLocation = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"index.ios" ofType:@"js"]];
#endif
    
    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                         moduleName        : @"ZATools"
                         initialProperties :
     @{
       @"scores" : @[
               @{
                   @"name" : @"Alex",
                   @"value": @"42"
                   },
               @{
                   @"name" : @"Joel",
                   @"value": @"10"
                   }
               ]
       }
                          launchOptions    : nil];
    self.view = rootView;
}

@end
