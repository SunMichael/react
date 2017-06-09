//
//  StreetModel.h
//  ApManager
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"

@interface StreetModel : NSObject<NSCoding>

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *code;
@property(nonatomic,strong) NSArray *list;


@end
