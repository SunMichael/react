//
//  StreetModel.m
//  ApManager
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "StreetModel.h"

@implementation StreetModel


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [self yy_modelEncodeWithCoder:aCoder];
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    return [self yy_modelInitWithCoder:aDecoder];
}

@end
