//
//  ViewController.m
//  yizhenjia
//
//  Created by mac on 16/8/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseController.h"
#import "MBProgressHUD.h"
#import "UIAlertView+NetAlert.h"
#import <UMMobClick/MobClick.h>
#import "Reachability.h"
#import "GiFHUD.h"

#define NoDataTag 10026
@interface BaseController () <MBProgressHUDDelegate,UIAlertViewDelegate>
{
    MBProgressHUD* _progressHUD;
    NSTimer* _overTimer; //超时
    NSInteger _downCount;
    UIView* animationView;
}
@end

@implementation BaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    self.view.backgroundColor = kBackViewColor;
    [self customNavigationBarLeftButton];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        [self setViewEdgeInset];
    }
}


- (void)customNavigationBarLeftButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60.0f, 40.f);
    [button setImage:[UIImage imageNamed:@"Icon_back"] forState:UIControlStateNormal];
    [button setTitle:self.backTitle forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17.f];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(customLeftItemPop) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -10.f;
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = @[space , leftBtn];
}

- (void)customLeftItemPop{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
    }
}

- (BOOL)isNoNet {
    Reachability *reach = [Reachability reachabilityForLocalWiFi];
    
    if ([reach currentReachabilityStatus] == NotReachable){
        return YES;
    }
    return NO;
    
}

- (void)setViewEdgeInset
{
    //如果tableview在视图最底层 默认会偏移电池栏的高度,针对ios7以后适配时注意一下
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
/**
 *  设置顶部状态栏风格
 *
 *  @return
 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)showIndicatorOnWindow
{
    if (_progressHUD == nil) {
        animationView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, kHeaderBarHeight, kScreenWidth, self.view.frame.size.height - kHeaderBarHeight * 2)];
        [self.view addSubview:animationView];
        
        _progressHUD = [[MBProgressHUD alloc] initWithView:animationView];
        [animationView addSubview:_progressHUD];
        
        _progressHUD.delegate = self;
        _progressHUD.label.text = @"加载中...";
        [_progressHUD showAnimated:YES];
        
        _downCount = 30;
        _overTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(overTimer:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_overTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)overTimer:(NSTimer*)timer
{
    _downCount--;
    if (_downCount == 0) {
        [self hideIndicatorOnWindow];
    }
}

- (void)showIndicatorOnWindowWithMessage:(NSString*)message
{
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_progressHUD];
    
    _progressHUD.delegate = self;
    _progressHUD.label.text = message;
    [_progressHUD showAnimated:YES];
}

- (void)showTextOnly:(NSString*)text
{
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _progressHUD.mode = MBProgressHUDModeText;
    _progressHUD.label.text = text;
    _progressHUD.margin = 10.f;
    _progressHUD.removeFromSuperViewOnHide = YES;
    
    [_progressHUD hideAnimated:YES afterDelay:2];
}

- (void)hideIndicatorOnWindow
{
    [_overTimer invalidate];
    _overTimer = nil;
    [animationView removeFromSuperview];
    [_progressHUD hideAnimated:YES];
}

#pragma mark - UTMini
// 统计某个页面的访问信息,如页面名称、页面的 refer、 页面停留时间、页面相关的业务参数等
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [GiFHUD dismiss];
    [MobClick endLogPageView:NSStringFromClass([self class])];

}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD*)hud
{
    // Remove HUD from screen when the HUD was hidded
    [_progressHUD removeFromSuperview];
    _progressHUD = nil;
}


-(void)addFailLoadView:(CGRect)frame
{
    
    UIView *view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=AllBgColor;
    view.tag=NoDataTag;
    CGFloat height=frame.size.height;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-60)/2, height*0.25, 60, 50)];
    imageView.image=[UIImage imageNamed:@"GIF3.png"];
    [view addSubview:imageView];
    
    
    
    UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,height*0.25+60 , kScreenWidth, 20)];
    textLabel.textColor=UIColorFromRGB(0xcccccc);
    textLabel.font=[UIFont systemFontOfSize:15];
    textLabel.textAlignment=NSTextAlignmentCenter;
    textLabel.text=@"网络加载失败啦";
    [view addSubview:textLabel];
    
    UIButton *  loadButton=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.3, height*0.25+95, kScreenWidth*0.4, 30)];
    [loadButton setTitleColor:UIColorFromRGB(0xcccccc) forState:UIControlStateNormal];
    loadButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [loadButton setTitle:@"点击重新加载" forState:UIControlStateNormal];
    loadButton.layer.borderWidth=0.5;
    loadButton.layer.borderColor=UIColorFromRGB(0xcccccc).CGColor;
    loadButton.layer.cornerRadius=5;
    
    //  self.superController
    [loadButton addTarget:self action:@selector(failAndReload) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:loadButton];
    
    view.tag=NoDataTag;
    [self.view addSubview:view];
    
    
}
-(void)removeNoDateView
{
    UIView *view=(UIView *)[self.view viewWithTag:NoDataTag];
    [view removeFromSuperview];
}

-(void)failAndReload
{
 [self removeNoDateView];
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
