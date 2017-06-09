//
//  AreaModel.h
//  ApManager
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"
/**
*  市下面的区县
*/
@interface ProvinceModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSArray *list;
@property (nonatomic, copy) NSString *name;     





@end
