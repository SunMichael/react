//
//  UIAlertView+NetAlert.h
//  Ivy
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (NetAlert)

+(id) showNoNetworkAlertView;

+ (id)showRequestErrorAlertView:(NSString *)message;

//判断弹窗是否已经实例化
+(BOOL)isNetAlertInit;

//重置网络弹窗为空
+(void)resetNetAlertNil;
@end
