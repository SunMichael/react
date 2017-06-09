//
//  CityModel.m
//  Ivy
//
//  Created by 李华光 on 15/6/1.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "CityModel.h"
#import "StreetModel.h"
@implementation CityModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [self yy_modelEncodeWithCoder:aCoder];
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    return [self yy_modelInitWithCoder:aDecoder];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [StreetModel class],
             };
}
@end
