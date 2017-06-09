//
//  IvyHeaderBar.h
//  Ivy
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

/**
 *
 *   界面控制器上方的header 显示title 左右两边的按钮
 */
#import <UIKit/UIKit.h>

@interface IvyHeaderBar : UIView

@property (nonatomic, strong) UIButton *leftBtn;                    //左侧按钮
@property (nonatomic, strong) UIButton *rightBtn;                   //右侧按钮
@property (nonatomic, strong) UILabel *titleLab;                    //显示标题
@property (nonatomic ,strong) CALayer *line;
/**
 *  初始化只有title的顶部横栏
 *
 *  @param titleStr         title文案
 *  @param backgroundColor  背景颜色
 *
 */
- (id)initWithTitle:(NSString *)titleStr backgroundColor:(UIColor *)backgroundColor;



/**
 *  初始化左右有按钮的顶部横栏
 *
 *  @param titleStr                         横栏的title
 *  @param leftBtnTitle                     左边按钮的title文案
 *  @param leftBtnImg                       左边按钮的图标
 *  @param leftBtnHighlightedImg            左边按钮的高亮图标
 *  @param rightBtnTitle                    右边按钮的title文案
 *  @param rightBtnImg                      右边按钮的图标
 *  @param rightBtnHighlightedImg           右边按钮的高亮图标
 *  @param backgroundColor                  背景颜色（目前只有三种：KOrangeColor2_0，KRedColor2_0，KPurpleColor2_0）
 *
 */
- (id)initWithTitle:(NSString *)titleStr leftBtnTitle:(NSString *)leftBtnTitle leftBtnImg:(UIImage *)leftBtnImg leftBtnHighlightedImg:(UIImage *)leftBtnHighlightedImg rightBtnTitle:(NSString *)rightBtnTitle rightBtnImg:(UIImage *)rightBtnImg rightBtnHighlightedImg:(UIImage *)rightBtnHighlightedImg backgroundColor:(UIColor *)backgroundColor;



@end
