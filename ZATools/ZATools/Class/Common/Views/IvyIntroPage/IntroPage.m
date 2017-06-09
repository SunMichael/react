//
//  IntroPage.m
//  Ivy
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "IntroPage.h"

@implementation IntroPage

+(IntroPage *) page{
    IntroPage *newPage = [[IntroPage alloc] init];
    newPage.titlePositionY = 50.0f;
    newPage.title = @"";
    newPage.titleColor = [UIColor whiteColor];
    newPage.titleFont = [UIFont systemFontOfSize:16.0f];
    
    return newPage;
}


@end
