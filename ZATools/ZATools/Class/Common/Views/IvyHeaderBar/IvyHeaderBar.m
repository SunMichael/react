//
//  IvyHeaderBar.m
//  Ivy
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "IvyHeaderBar.h"

@implementation IvyHeaderBar
{
    CALayer *_line;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/**
 *  初始化只有title的顶部横栏
 *
 *  @param titleStr         title文案
 *  @param backgroundColor  背景颜色（目前只有三种：KOrangeColor2_0，KRedColor2_0，KPurpleColor2_0）
 *
 */
- (id)initWithTitle:(NSString *)titleStr backgroundColor:(UIColor *)backgroundColor{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kHeaderBarHeight + (kBatterHeight))];
    if(self){
        self.backgroundColor = backgroundColor;
        //title
        self.titleLab = [self loadLabelWithFrame:CGRectMake(0.0f, kBatterHeight, 0.0f, 0.0f) titleStr:titleStr font:[UIFont boldSystemFontOfSize:18.0f]];
        self.titleLab.frame = CGRectMake(kScreenWidth/2 - self.titleLab.frame.size.width/2 , self.titleLab.frame.origin.y, self.titleLab.frame.size.width, kHeaderBarHeight);
        [self addSubview:self.titleLab];
    }
    return self;
}
/**
 *  显示文案
 *
 *  @param frame    文案大小
 *  @param titleStr 文案内容
 *  @param font     字体规格
 *
 */
-(UILabel *)loadLabelWithFrame:(CGRect)frame titleStr:(NSString *)titleStr font:(UIFont *)font{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = font;
    label.text = titleStr;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    return label;
}

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
- (id)initWithTitle:(NSString *)titleStr leftBtnTitle:(NSString *)leftBtnTitle leftBtnImg:(UIImage *)leftBtnImg leftBtnHighlightedImg:(UIImage *)leftBtnHighlightedImg rightBtnTitle:(NSString *)rightBtnTitle rightBtnImg:(UIImage *)rightBtnImg rightBtnHighlightedImg:(UIImage *)rightBtnHighlightedImg backgroundColor:(UIColor *)backgroundColor{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kHeaderBarHeight + (kBatterHeight))];
    if(self){
        self.backgroundColor = backgroundColor;
        //左侧按钮
//        if(leftBtnImg != nil){
            self.leftBtn = [self loadLeftButtonWithFrame:CGRectMake(0.0f, kBatterHeight, 73.0f, kHeaderBarHeight) titleStr:leftBtnTitle image:leftBtnImg highlightedImg:leftBtnHighlightedImg backgroundColor:backgroundColor];
            self.leftBtn.frame = CGRectMake(self.leftBtn.frame.origin.x, self.leftBtn.frame.origin.y, self.leftBtn.frame.size.width, kHeaderBarHeight);
            [self addSubview:self.leftBtn];
//        }
        
        //右侧按钮
        //        if(rightBtnImg != nil){
        self.rightBtn = [self loadRightButtonWithFrame:CGRectMake(kScreenWidth - 75.0f, kBatterHeight, 75.0f, kHeaderBarHeight) titleStr:rightBtnTitle image:rightBtnImg highlightedImg:rightBtnHighlightedImg backgroundColor:backgroundColor];
        [self addSubview:self.rightBtn];
        //        }
        
        //title
        self.titleLab = [self loadLabelWithFrame:CGRectMake(0.0f, kBatterHeight, 0.0f, 0.0f) titleStr:titleStr font:[UIFont boldSystemFontOfSize:18.0f]];
        self.titleLab.frame = CGRectMake(75.0f, self.titleLab.frame.origin.y, kScreenWidth -(75.0f *2), kHeaderBarHeight);
        [self addSubview:self.titleLab];
        
        _line = [CALayer layer];
        _line.frame = CGRectMake(0.0f, self.height - 1.0f, self.width, 1.0f);
        _line.backgroundColor = kLineColor.CGColor;
        [self.layer addSublayer:_line];
        
    }
    return self;
}
/**
 *  初始化左侧按钮
 *
 *  @param frame                按钮大小
 *  @param titleStr             按钮文案
 *  @param image                按钮图案
 *  @param backgroundColor      根据当前颜色判断按钮高亮的颜色
 *
 */
-(UIButton *)loadLeftButtonWithFrame:(CGRect)frame titleStr:(NSString *)titleStr image:(UIImage *)image highlightedImg:(UIImage *)highlightedImg backgroundColor:(UIColor *)backgroundColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    if(image != nil){
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:highlightedImg forState:UIControlStateHighlighted];
        button.imageEdgeInsets = UIEdgeInsetsMake(1.0f, -20.0f, 0.0f, 12.0f);
    }
    if(![titleStr isEqualToString:@""] && titleStr != nil ){
        [button setTitle:titleStr forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        button.titleEdgeInsets = UIEdgeInsetsMake(1.0f, 0.0f, 0.0f, 5.0f);
    }
    return button;
}

/**
 *  初始化右侧按钮
 *
 *  @param frame                按钮大小
 *  @param titleStr             按钮文案
 *  @param image                按钮图案
 *  @param backgroundColor      根据当前颜色判断按钮高亮的颜色
 *
 */
-(UIButton *)loadRightButtonWithFrame:(CGRect)frame titleStr:(NSString *)titleStr image:(UIImage *)image highlightedImg:(UIImage *)highlightedImg backgroundColor:(UIColor *)backgroundColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    if(image != nil){
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:highlightedImg forState:UIControlStateHighlighted];
        button.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    }
    if(![titleStr isEqualToString:@""] && titleStr != nil ){
        [button setTitle:titleStr forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 0.0f);
    }
    return button;
}


@end
