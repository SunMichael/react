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
    float offy = self.height/2 - (45.0f + 20.0f + 15.f)/2;
    
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2 - 45.f/2, offy, 45.f, 45.f)];
    [self addSubview:_iconView];
    
    _titleLab = [[IvyLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconView.frame) + 15.f, self.width, 20.f) text:nil font:GetFont(16.f) textColor:kBlackColor textAlignment:NSTextAlignmentCenter numberLines:1];
    [self addSubview:_titleLab];
    
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
    _editBtn.hidden = YES;
    [self addSubview:_editBtn];
}

- (void)edit{
    _editBlock(add , self.tag);
}

@end
