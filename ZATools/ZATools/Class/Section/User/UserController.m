//
//  UserController.m
//  ZATools
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UserController.h"
#import "LoginController.h"
#import "ZAEvent.h"
#import <React/RCTRootView.h>

@interface UserController ()

@end

@implementation UserController



- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 60.0f, 40.f);
    [button setBackgroundColor:[UIColor yellowColor]];
    [button addTarget:self action:@selector(loginAccount) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
   
    [self addReactView];
    
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



- (void)senderMsgToReact{
    ZAEvent *event = [[ZAEvent alloc] init];
    [event sendMessage:@"oc to react"];
}

- (void)loginAccount{

    LoginController *loginVc = [LoginController new];

    [RootNavController pushViewController:loginVc animated:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
