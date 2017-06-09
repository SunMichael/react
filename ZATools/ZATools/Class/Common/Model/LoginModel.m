//
//  LoginModel.m
//  yizhenjia
//
//  Created by mac on 16/9/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LoginModel.h"
#import "NSObject+YYModel.h"

@implementation LoginModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"uid" : @"id"};
}
@end
