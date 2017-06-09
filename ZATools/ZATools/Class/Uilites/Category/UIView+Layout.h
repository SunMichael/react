//
//  UIView+Layout.h
//  ApManager
//
//  Created by zjjllj on 15/12/7.
//  Copyright © 2015年 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  方便的访问和设置View的属性
 */
@interface UIView (Layout)

@property (assign, nonatomic) CGFloat	top;
@property (assign, nonatomic) CGFloat	bottom;
@property (assign, nonatomic) CGFloat	left;
@property (assign, nonatomic) CGFloat	right;

@property (assign, nonatomic) CGFloat	x;
@property (assign, nonatomic) CGFloat	y;
@property (assign, nonatomic) CGPoint	origin;

@property (assign, nonatomic) CGFloat	centerX;
@property (assign, nonatomic) CGFloat	centerY;

@property (assign, nonatomic) CGFloat	width;
@property (assign, nonatomic) CGFloat	height;
@property (assign, nonatomic) CGSize	size;

@property (assign, nonatomic) CGFloat   dx;     //右下角x坐标
@property (assign, nonatomic) CGFloat   dy;     //右下角y坐标



- (void)setViewAllCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor andBorderWidth:(CGFloat)width;

/**
 view 添加虚线

 @param lineView
 @param lineLength
 @param lineSpacing
 @param lineColor   
 */
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
@end
