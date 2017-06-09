//
//  IvyLabel.h
//  Ivy
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IvyLabel : UILabel

/**
 *  自定义初始化UILabel
 *
 *  @param frame         大小
 *  @param text          文案
 *  @param font          字体
 *  @param textColor     文案颜色
 *  @param textAlignment 文案偏移位置
 *  @param numberLines   显示的行数
 *
 */
- (id)initWithFrame:(CGRect)frame text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines;

/**
 *  自定义初始化UILabel, 大小由Masonry控制
 *
 *  @param text          文案
 *  @param font          字体
 *  @param textColor     文案颜色
 *  @param textAlignment 文案偏移位置
 *  @param numberLines   显示的行数
 *
 */
- (id)initWithText:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines;


/**
 *  自定义初始化UILabel, 大小由Masonry控制
 *
 *  @param font          字体
 *  @param textColor     文案颜色
 *  @param textAlignment 文案偏移位置
 *  @param numberLines   显示的行数
 *
 */
- (instancetype)initWithFont:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines;
@end
