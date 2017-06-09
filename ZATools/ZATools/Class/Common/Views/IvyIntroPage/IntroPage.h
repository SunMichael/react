//
//  IntroPage.h
//  Ivy
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface IntroPage : NSObject

@property(nonatomic, retain) UIImage *bgImage;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, assign) CGFloat titlePositionY;

+(IntroPage *) page;

@end
