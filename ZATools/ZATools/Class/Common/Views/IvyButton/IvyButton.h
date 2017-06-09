//
//  IvyButton.h
//  Ivy
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IvyButton : UIButton

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
- (id)initWithFrame:(CGRect)frame titleStr:(NSString*)titleStr titleColor:(UIColor*)titleColor font:(UIFont*)font logoImg:(UIImage*)logoImg backgroundImg:(UIImage*)backgroundImg;

/**
 *  初始化自定义按钮
 *
 *  @param titleStr      文案（正常状态）
 *  @param titleColor    文案颜色（正常状态）
 *  @param font          字体（正常状态）
 *  @param logoImg       图标（正常状态）
 *  @param backgroundImg 背景（正常状态）
 *
 */
- (id)initWithTitleStr:(NSString*)titleStr titleColor:(UIColor*)titleColor font:(UIFont*)font logoImg:(UIImage*)logoImg backgroundImg:(UIImage*)backgroundImg;

@end
