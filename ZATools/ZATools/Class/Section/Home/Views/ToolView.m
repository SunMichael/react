//
//  ToolView.m
//  ZATools
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ToolView.h"

@implementation ToolView
{
    BOOL add;
}
- (instancetype)initWithFrame:(CGRect)frame withEditStatus:(BOOL)useing
{
    self = [super initWithFrame:frame];
    if (self) {
        add = useing;
        [self loadSubView:useing];
        self.backgroundColor = kWhiteColor;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadContent];
    }
    return self;
}

- (void)loadContent{
    _titleLab = [[IvyLabel alloc] initWithFrame:CGRectMake(0, self.height - 20.f, self.width, 16.f) text:nil font:GetFont(16.f) textColor:kBlackColor textAlignment:NSTextAlignmentCenter numberLines:1];
    [self addSubview:_titleLab];
    
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2 - 45.f/2, self.height - 45.f - 35.f, 45.f, 45.f)];
    [self addSubview:_iconView];
    
    _button = [[IvyButton alloc] initWithFrame:_iconView.frame titleStr:nil titleColor:nil font:nil logoImg:nil backgroundImg:[UIImage createImageWithColor:kWhiteColor]];
    _button.showsTouchWhenHighlighted = YES;
    [_button setBackgroundImage:[UIImage createImageWithColor:kLightGrayColor] forState:UIControlStateHighlighted];
    
    [self insertSubview:_button belowSubview:_titleLab];

}

- (void)loadSubView:(BOOL)useing{
    
    [self loadContent];
    
    UIImage *icon = GetImage(@"jian");
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn setBackgroundImage:icon forState:UIControlStateNormal];
    [_editBtn setBackgroundImage:GetImage(@"jia") forState:UIControlStateSelected];
    _editBtn.frame = CGRectMake(self.width - 18.f - 3.f, 3.f, 18.f, 18.f);
    [_editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_editBtn];
}

- (void)edit{
    _editBlock(add , self.tag);
}

@end
