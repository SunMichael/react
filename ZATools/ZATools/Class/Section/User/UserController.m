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

@interface UserController ()

@end

@implementation UserController



- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 60.0f, 40.f);
    [button setBackgroundColor:[UIColor yellowColor]];
    [button addTarget:self action:@selector(senderMsgToReact) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)senderMsgToReact{
    ZAEvent *event = [[ZAEvent alloc] init];
    [event sendMessage:@"oc to react"];
}

- (void)loginAccount{

    LoginController *loginVc = [LoginController new];

    [RootNavController pushViewController:loginVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
