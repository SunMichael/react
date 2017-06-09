//
//  UIAlertView+NetAlert.m
//  Ivy
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "UIAlertView+NetAlert.h"

@implementation UIAlertView (NetAlert)
static id alertView = nil ;
+(id) showNoNetworkAlertView{

    if (alertView == nil) {
        alertView = [[self alloc] initWithTitle:@"温馨提示" message:@"网络连接不可用\n 请连接到移动数据网络或WiFi" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    }

    return alertView;
}

+ (id)showRequestErrorAlertView:(NSString *)message
{
    if (alertView == nil) {
        alertView = [[self alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    }
    
    return alertView;
}

//判断弹窗是否已经实例化
+(BOOL)isNetAlertInit{
    if(alertView == nil)
        return NO;
    return YES;
}

//重置网络弹窗为空
+(void)resetNetAlertNil{
    if(alertView != nil)
        alertView = nil;
}

@end
