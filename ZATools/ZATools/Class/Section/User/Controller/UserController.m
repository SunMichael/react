//
//  UserController.m
//  ZATools
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UserController.h"
#import "LoginController.h"
#import "UserTableView.h"
#import <React/RCTRootView.h>

@interface UserController ()

@end

@implementation UserController



- (void)viewDidLoad {
  
    [super viewDidLoad];
    UserTableView * userTable = [[UserTableView alloc] initWithFrame:CGRectMake(0.0f, -20.0f, kScreenWidth, kScreenHeight - kFooterTabbarHeight + 20.f) style:UITableViewStylePlain];
    [self.view addSubview:userTable];
    
}
- (void)addReactView{
    NSURL *jsCodeLocation;
#ifdef DEBUG
    jsCodeLocation = [NSURL
                      URLWithString:@"http://localhost:8081/userLogin.bundle?platform=ios"];
    //    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"ios" withExtension:@"jsbundle"];
#else
    //发布前要对js文件进行打包 更改路径
    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"ios" withExtension:@"jsbundle"];
#endif
    
    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                         moduleName        : @"ZATools"
                         initialProperties :
     @{
       @"name": @"hello"
       }
                          launchOptions    : nil];
    self.view = rootView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
