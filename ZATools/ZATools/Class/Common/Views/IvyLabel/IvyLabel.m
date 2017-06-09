//
//  IvyLabel.m
//  Ivy
//
//  Created by mac on 15/5/28.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "IvyLabel.h"

@implementation IvyLabel

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
- (id)initWithFrame:(CGRect)frame text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.text = text == nil ? @"" : text;
        self.textColor = textColor == nil ? [UIColor blackColor] : textColor;
        self.font = font;
        self.textAlignment = textAlignment;
        self.numberOfLines = numberLines < 0 ? 0 : numberLines;
        if (self.numberOfLines > 0) {
            self.lineBreakMode = NSLineBreakByTruncatingTail;
        }
        else {
            self.lineBreakMode = NSLineBreakByWordWrapping;
        }
    }
    return self;
}

- (id)initWithText:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.text = text == nil ? @"" : text;
        self.textColor = textColor == nil ? [UIColor blackColor] : textColor;
        self.font = font;
        self.textAlignment = textAlignment;
        self.numberOfLines = numberLines < 0 ? 0 : numberLines;
        if (self.numberOfLines > 0) {
            self.lineBreakMode = NSLineBreakByTruncatingTail;
        }
        else {
            self.lineBreakMode = NSLineBreakByWordWrapping;
        }
    }
    return self;
}


- (instancetype)initWithFont:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textColor = textColor == nil ? [UIColor blackColor] : textColor;
        self.font = font;
        self.textAlignment = textAlignment;
        self.numberOfLines = numberLines < 0 ? 0 : numberLines;
        if (self.numberOfLines > 0) {
            self.lineBreakMode = NSLineBreakByTruncatingTail;
        }
        else {
            self.lineBreakMode = NSLineBreakByWordWrapping;
        }
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
