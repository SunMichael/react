//
//  ToolController.m
//  ZATools
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ToolController.h"
#import <React/RCTRootView.h>
@interface ToolController ()

@end

@implementation ToolController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self addReactView];
}

- (void)addReactView{
    NSURL *jsCodeLocation;
#ifdef DEBUG
    jsCodeLocation = [NSURL
                      URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
#else
    //发布前要对js文件进行打包 更改路径
    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"ios" withExtension:@"jsbundle"];
#endif
    
    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                         moduleName        : @"ZATools"
                         initialProperties : nil
                         launchOptions    : nil];
    self.view = rootView;
}

@end
