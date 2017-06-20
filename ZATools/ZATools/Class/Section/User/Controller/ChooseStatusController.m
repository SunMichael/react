//
//  ChooseStatusController.m
//  ZATools
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ChooseStatusController.h"

@interface ChooseStatusController ()

@end

@implementation ChooseStatusController

-(NSString *)title{
    return @"选择所处阶段";
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadStatusChooseViews];
}

- (void)loadStatusChooseViews{
    NSArray *imgs = @[GetImage(@"huaiyun") ,GetImage(@"ertong")];
    NSArray *titles = @[@"怀孕",@"育儿"];
    float offy = 80.0f;
    for (NSInteger i = 0 ; i < imgs.count; i++) {
        UIImage *icon = imgs[i];
        UIButton *ivName = [UIButton buttonWithType:UIButtonTypeCustom];
        ivName.frame = CGRectMake(kScreenWidth/2 - icon.size.width/2, offy, icon.size.width, icon.size.height);
        [ivName setImage:icon forState:UIControlStateNormal];
        [self.view addSubview:ivName];
        
        IvyLabel *label = [[IvyLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxX(ivName.frame) + 20.f, kScreenWidth, 21.f) text:titles[i] font:GetFont(21.f) textColor:kBlackColor textAlignment:NSTextAlignmentCenter numberLines:1];
        [self.view addSubview:label];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
