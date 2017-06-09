//
//  CityModel.h
//  Ivy
//
//  Created by 李华光 on 15/6/1.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"
@interface CityModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *list;       //区县


@end
