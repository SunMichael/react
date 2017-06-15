//
//  IvyTabbarController.m
//  Ivy
//
//  Created by mac on 15/5/27.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "YzjTabbarController.h"
#import "IvyButton.h"
#import "IvyLabel.h"
#import "UIColor+BK.h"
#import <UMMobClick/MobClick.h>
#import "LoginController.h"
#import "BaseController.h"
#import "YzjNavigationController.h"


#import "HomeController.h"
#import "UserController.h"
#import "DiscoverController.h"

@interface YzjTabbarController () {
    HomeController* homeCtr; //首页
    DiscoverController* discoverCtr; //发现

    UserController* userCtr; //我的
    

    
    NSMutableArray* allLab;
    NSMutableArray* allImage;
    
    NSMutableArray* allUnreadIcon;
    UIView* tabbarView;
}
@end

@implementation YzjTabbarController

- (instancetype)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self loadTabbarControllers];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
}

#pragma mark - private method
/**
 *  添加tabbar子视图控制器
 */
- (void)loadTabbarControllers
{
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kLightGrayColor, NSFontAttributeName : [UIFont systemFontOfSize:13.f]} forState:UIControlStateNormal];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
//    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    UINavigationController* storeNC;
    if (homeCtr == nil) {
        homeCtr = [[HomeController alloc] init];
        storeNC = [[UINavigationController alloc] initWithRootViewController:homeCtr];
//        storeNC.navigationBar.hidden = YES;
        UIImage *nomal = GetImage(@"home_nor");
        nomal = [nomal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        homeCtr.tabBarItem.image = nomal;
        homeCtr.tabBarItem.title = @"首页";
//        homeCtr.title = @"首页";
        UIImage *selected = GetImage(@"home_sel");
        selected = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        homeCtr.tabBarItem.selectedImage = selected;
        
    }
    else {
        homeCtr = [self.viewControllers objectAtIndex:0];
    }
    

    if (discoverCtr == nil) {
        discoverCtr = [[DiscoverController alloc] init];
        UIImage *nomal = GetImage(@"me_nor");
        nomal = [nomal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        discoverCtr.tabBarItem.image = nomal;
        discoverCtr.tabBarItem.title = @"发现";
        discoverCtr.tabBarItem.tag = 1;
        UIImage *selected = GetImage(@"me_sel");
        selected = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        discoverCtr.tabBarItem.selectedImage = selected;
    }
    else {
        userCtr = [self.viewControllers objectAtIndex:1];
    }
    
    
    UINavigationController* userNC;
    if (userCtr == nil) {
        userCtr = [[UserController alloc] init];
        userNC = [[UINavigationController alloc] initWithRootViewController:userCtr];
//        userNC.navigationBar.hidden = YES;
        UIImage *nomal = GetImage(@"me_nor");
        nomal = [nomal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        userCtr.tabBarItem.image = nomal;
        userCtr.tabBarItem.title = @"我的";
        userCtr.tabBarItem.tag = 2;
        userCtr.title = @"我的";
        UIImage *selected = GetImage(@"me_sel");
        selected = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        userCtr.tabBarItem.selectedImage = selected;
    }
    else {
        userCtr = [self.viewControllers objectAtIndex:2];
    }
    self.viewControllers = @[homeCtr ,discoverCtr,userCtr];
    
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    self.navigationItem.title = item.title;

//    self.navigationController.navigationBarHidden = item.tag == 1 ? YES : NO;

}



@end
