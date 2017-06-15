//
//  AppDelegate.m
//  ZATools
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "YzjTabbarController.h"
#import "YzjNavigationController.h"
#import "WXApi.h"
//#import "RTRootNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)replaceRootViewController:(UIViewController*)newViewController animationOptions:(UIViewAnimationOptions)options
{
    UIViewController* formerViewController = self.window.rootViewController;
    if (formerViewController == newViewController) {
        return;
    }
    
    void (^completion)(BOOL) = ^(BOOL finished) {
        self.window.rootViewController = newViewController;
    };
    // options 为 0 表示木有动画
    if (options == 0) {
        completion(YES);
    }
    else {
        [UIView transitionFromView:formerViewController.view toView:newViewController.view duration:0.65 options:options completion:completion];
    }
    
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    YzjTabbarController *tabbar = [[YzjTabbarController alloc] initWithNibName:nil bundle:nil];
    YzjNavigationController *navigationVC = [[YzjNavigationController alloc] initWithRootViewController:tabbar];
    self.window.rootViewController = navigationVC;
    
    [self registerWeChat];
    
    return YES;
}


- (void)registerWeChat{
    //向微信注册
    [WXApi registerApp:@"wxd477edab60670232"];
    
    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
}




@end
