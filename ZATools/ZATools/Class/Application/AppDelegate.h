//
//  AppDelegate.h
//  ZATools
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


- (void)replaceRootViewController:(UIViewController*)newViewController animationOptions:(UIViewAnimationOptions)options;

@end

