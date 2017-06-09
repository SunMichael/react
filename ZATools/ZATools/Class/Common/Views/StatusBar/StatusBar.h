//
//  StatusBar.h
//  TJiphone
//
//  Created by keyrun on 13-10-23.
//  Copyright (c) 2013年 keyrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface StatusBar : UIView

/**
*  底部提示
*
*  @param message 提示信息
*/
+(void)showTipMessageWithStatus:(NSString* )message;

+(void)showTipMessageWithStatus:(NSString* )message andImage:(UIImage* )image andTipIsBottom:(BOOL)isBottom;



@end
