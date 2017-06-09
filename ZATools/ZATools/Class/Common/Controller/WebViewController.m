//
//  WebViewController.m
//  yizhenjia
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "UIImage+ColorToImage.h"
#import "ShareView.h"

//#import "LoginController.h"

@interface WebViewController () <UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>
{
    UIWebView* _webView;
    int failCount;
    WKWebView* wkWebView;
    BOOL available;
    BOOL loadSuccess;
    UIView *bottomView;
    IvyButton *collectBtn;
    NSInteger collected;
    ShareView *shareView;
    float lastOffy;
    IvyHeaderBar* headerBar;
    IvyLabel *countLab;
    NSInteger oldCount;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadWebViewContent];
}


- (void)loadWebViewContent{
    UIImage *share = _normalWeb ? GetImage(@"sharelogo") : nil;
    headerBar = [[IvyHeaderBar alloc] initWithTitle:_webTitle ? _webTitle : @"相关阅读" leftBtnTitle:nil leftBtnImg:GetImage(@"Icon_back") leftBtnHighlightedImg:nil rightBtnTitle: nil rightBtnImg:share rightBtnHighlightedImg:nil backgroundColor:[UIColor whiteColor]];
    
    [headerBar.leftBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headerBar.rightBtn addTarget:self action:@selector(clickedShareButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:headerBar];
    
    
    float h = headerBar.frame.origin.y + headerBar.frame.size.height;
    float bottomH = 0.0f;
    if (_isWiki) {
        h = navigationBarHeight;
        bottomH = 70.0f;
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - bottomH, self.view.width, bottomH)];
        bottomView.backgroundColor = [UIColor clearColor];
        
        [self loadBottomViews];

    }
    
    if (_webView) {
        _webView = nil;
        [_webView removeFromSuperview];
    }
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, h, kScreenWidth, kScreenHeight - h )];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    _webView.backgroundColor = kWhiteColor;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    [(UIScrollView*)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    [self.view addSubview:bottomView];
    [self loadAddress];
}

/**
 加载底部分享收藏视图
 */
- (void)loadBottomViews{
    
    float size = 50.0f;
    IvyButton *backBtn = [[IvyButton alloc] initWithFrame:CGRectMake(10.0f, 10.0f, size, size) titleStr:nil titleColor:nil font:nil logoImg:GetImage(@"back_white") backgroundImg:[UIImage createImageWithColor:[UIColor blackColor]]];
    backBtn.layer.cornerRadius = size/2;
    backBtn.layer.masksToBounds = YES;
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:backBtn];
    
    float w = 110 ;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(bottomView.width - 10.0f - w, 10.0f, w, size)];
    view.backgroundColor = [UIColor blackColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = size/2;
    [bottomView addSubview:view];
    
    NSArray *icons = @[GetImage(@"webfavnormal"),GetImage(@"web_share")];
    
    NSArray *hightIcons = @[GetImage(@"webfavselected")];
    
    for (NSInteger i = 0; i < icons.count; i++) {
        IvyButton *button = [[IvyButton alloc] initWithFrame:CGRectMake(size *i, 0.0f, size, size) titleStr:nil titleColor:nil font:nil logoImg:icons[i] backgroundImg:nil];
        if (i == 0) {
            [button setImage:hightIcons[i] forState:UIControlStateHighlighted];
            collectBtn = button;
           
        }
        button.tag = i;
        [button addTarget:self action:@selector(clickedShare:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    
    float w2 = 25.0f;
    NSInteger number = oldCount;
    countLab = [[IvyLabel alloc] initWithFrame:CGRectMake(view.width/2 - w2/2 - 10.0f, 5.0f, w2, 15.0f) text:[NSString stringWithFormat:@"%ld",number] font:GetFont(14.0f) textColor:kRedColor textAlignment:NSTextAlignmentLeft numberLines:1];
    [view addSubview:countLab];
    float knumber = 0.0f;
    if (number > 1000) {
        knumber = number*1.0f/1000.0f;
        countLab.text = [NSString stringWithFormat:@"%.1fk",knumber];
    }
    
}
- (void)changeNumberText:(NSInteger)number{
    countLab.text = [NSString stringWithFormat:@"%ld",number];
    float knumber = 0.0f;
    if (number >= 1000) {
        knumber = number*1.0f/1000.0f;
        countLab.text = [NSString stringWithFormat:@"%.1fk",knumber];
    }
}
- (void)clickedShare:(IvyButton *)button{
    if (button.tag == 0){
//        if ([[[IvyUserDefaults shareUserDefaults] getUserId] isEqualToString:kYOUKEID]) {
//            LoginController *vc = [[LoginController alloc] init];
//            [RootNavController pushViewController:vc animated:YES];
//            return;
//        }
////        [GiFHUD show];
//        [[InfomationService shareInstance] collectFoundWithId:_readModel.r_id type:@"INFO" status:collected Complete:^(BOOL success, RequestError *error) {
//            [GiFHUD dismiss];
//            if (error.message) {
//                [self.view showInfo:error.message autoHidden:YES];
//            }else{
//                
//                if (collected) {
//                    [self.view showInfo:@"收藏成功" autoHidden:YES];
//                    oldCount = oldCount + 1;
//                    [self changeNumberText:oldCount];
//                    [collectBtn setHighlighted:YES];
//                }else {
//                    [self.view showInfo:@"取消收藏" autoHidden:YES];
//                    oldCount = oldCount - 1;
//                    [self changeNumberText:oldCount];
//                    [collectBtn setHighlighted:NO];
//                }
//                collected = !collected;
//                if (_tableIndex >= 0) {
//                  [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"wiki%@",_tableIndex] object:nil];
//                }
//            }
//        }];
    }else{      //分享
        [self clickedShareButton];
    }
}

/**
 点击分享
 */
- (void)clickedShareButton{
    if (!shareView) {
        shareView = [[ShareView alloc] initWithFrame:[UIScreen mainScreen].bounds shareType:shareFound];
        NSString *title=[_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        NSString *infoUrl=[_webView.request.URL absoluteString];
        NSString *imageStr=[_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('share_img')[0].content"];
        NSString *description=[_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('description')[0].content"];
        shareView.inforUrl = infoUrl;
        shareView.title = title;
        shareView.thumUrl = imageStr;
        shareView.subTitle=description;
        [[UIApplication sharedApplication].keyWindow addSubview:shareView];
    }
    [shareView showShareView];
}



- (void)loadAddress
{
    NSString* url;
    
    if (_webURL) {
        url = _webURL;
    }
    else {
        url = @"";
        
    }
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    [GiFHUD show];
    if (available) {
        [wkWebView loadRequest:request];
    }
    else {
        [_webView loadRequest:request];
    }
    
}

#pragma UIWebView delegate
- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    [GiFHUD dismiss];
    if ([NSString isEmply:_webTitle]) {
        NSString *title=[_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        headerBar.titleLab.text = title;
    }
}
- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error
{
    if (failCount < 3) {
        [self loadAddress];
        failCount++;
    }
    [GiFHUD dismiss];
}

#pragma WkWebView delegate
- (void)webView:(WKWebView*)webView didFinishNavigation:(null_unspecified WKNavigation*)navigation
{
    loadSuccess = YES;
    [GiFHUD dismiss];
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@" start == %@",webView.URL);
}
- (void)webView:(WKWebView*)webView didFailNavigation:(null_unspecified WKNavigation*)navigation withError:(NSError*)error
{
    if (failCount < 3) {
        [self loadAddress];
        failCount++;
    }
    [GiFHUD dismiss];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@" XXX === %@ ",navigationAction.request.URL.absoluteString.lowercaseString);
    decisionHandler(WKNavigationActionPolicyAllow);
    
}
#pragma mark - **************** UIdelegate
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offy = scrollView.contentOffset.y;
    if (offy - lastOffy > 5.0f) {
        bottomView.hidden = YES;
    }else if (lastOffy -  offy > 5.0f ){
        bottomView.hidden = NO;
    }
    lastOffy = offy;
}


- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        if (self.isViewLoaded && !self.view.window) // 是否是正在使用的视图
        {
            self.view = nil; // 目的是再次进入时能够重新加载调用viewDidLoad函数。
            loadSuccess = NO;
        }
    }
    
}



@end
