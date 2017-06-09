//
//  ViewController.m
//  ZATools
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeController.h"
#import <React/RCTRootView.h>

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addReactView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)addReactView{
    NSURL *jsCodeLocation = [NSURL
                             URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                         moduleName        : @"ZATools"
                         initialProperties :
     @{
       @"scores" : @[
               @{
                   @"name" : @"Alex",
                   @"value": @"42"
                   },
               @{
                   @"name" : @"Joel",
                   @"value": @"10"
                   }
               ]
       }
                          launchOptions    : nil];
    self.view = rootView;
}

@end
