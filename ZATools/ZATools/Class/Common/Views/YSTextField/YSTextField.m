//
//  YSTextField.m
//  yizhenjia
//
//  Created by mac on 16/8/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YSTextField.h"

@implementation YSTextField

-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    CGRect inset = CGRectMake(bounds.origin.x+5, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    
    CGRect inset = CGRectMake(bounds.origin.x +5, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x +5, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}
@end
