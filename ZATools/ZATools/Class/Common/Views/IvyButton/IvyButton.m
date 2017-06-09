//
//  IvyButton.m
//  Ivy
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "IvyButton.h"

@implementation IvyButton

/**
 *  初始化自定义按钮
 *
 *  @param frame         大小
 *  @param titleStr      文案（正常状态）
 *  @param titleColor    文案颜色（正常状态）
 *  @param font          字体（正常状态）
 *  @param logoImg       图标（正常状态）
 *  @param backgroundImg 背景（正常状态）
 *
 */
- (id)initWithFrame:(CGRect)frame titleStr:(NSString*)titleStr titleColor:(UIColor*)titleColor font:(UIFont*)font logoImg:(UIImage*)logoImg backgroundImg:(UIImage*)backgroundImg
{
    self = (IvyButton *)[UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        self.frame = frame;
        [self setTitle:titleStr forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        self.titleLabel.font = font;
        [self setImage:logoImg forState:UIControlStateNormal];
        [self setBackgroundImage:backgroundImg forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithTitleStr:(NSString*)titleStr titleColor:(UIColor*)titleColor font:(UIFont*)font logoImg:(UIImage*)logoImg backgroundImg:(UIImage*)backgroundImg
{
    self = (IvyButton *)[UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        [self setTitle:titleStr forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        self.titleLabel.font = font;
        [self setImage:logoImg forState:UIControlStateNormal];
        [self setBackgroundImage:backgroundImg forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
