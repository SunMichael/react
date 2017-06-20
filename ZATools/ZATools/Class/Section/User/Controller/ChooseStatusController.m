//
//  ChooseStatusController.m
//  ZATools
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ChooseStatusController.h"

@interface ChooseStatusController ()
{
    UIScrollView *scroll;
}
@end

@implementation ChooseStatusController

-(NSString *)title{
    return @"选择所处阶段";
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kWhiteColor;
    [self.view addSubview:[self backScrollView]];
    [self loadStatusChooseViews];
}
- (UIScrollView *)backScrollView{
    if (!scroll) {
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, navigationBarHeight, kScreenWidth, kScreenHeight - navigationBarHeight)];
        scroll.showsVerticalScrollIndicator = NO;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.backgroundColor = [UIColor colorWithRed:1.00f green:0.96f blue:0.98f alpha:1.00f];
        scroll.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        scroll.userInteractionEnabled = YES;
        [scroll setContentSize:CGSizeMake(kScreenWidth, scroll.height + 1.0f)];
        [self.view addSubview:scroll];
    }
    return scroll;
}

- (void)loadStatusChooseViews{
    NSArray *imgs = @[GetImage(@"huaiyun") ,GetImage(@"ertong")];
    NSArray *titles = @[@"怀孕",@"育儿"];
    float offy = scroll.height/2 - (138.0f * 2 + 41.0f * 2 + 50.f)/2;
    for (NSInteger i = 0 ; i < imgs.count; i++) {
        UIImage *icon = imgs[i];
        UIButton *ivName = [UIButton buttonWithType:UIButtonTypeCustom];
        ivName.frame = CGRectMake(kScreenWidth/2 - icon.size.width/2, offy, icon.size.width, icon.size.height);
        [ivName setImage:icon forState:UIControlStateNormal];
        [scroll addSubview:ivName];
        
        IvyLabel *label = [[IvyLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(ivName.frame) + 20.f, kScreenWidth, 21.f) text:titles[i] font:GetFont(21.f) textColor:kBlackColor textAlignment:NSTextAlignmentCenter numberLines:1];
        [scroll addSubview:label];
        
        offy = CGRectGetMaxY(label.frame) + 50.f;
    }
    
    if (offy > scroll.height) {
        [scroll setContentSize:CGSizeMake(kScreenWidth, offy )];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
