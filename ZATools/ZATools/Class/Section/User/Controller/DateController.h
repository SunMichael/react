//
//  DateController.h
//  ZATools
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseController.h"

typedef enum : NSUInteger {
    DateSettingTypeExpect,
    DateSettingTypeCalculation,
    DateSettingTypeBaby,
} DateSettingType;

// 设置 计算预产期
@interface DateController : BaseController


-(instancetype)initWithType:(DateSettingType)type;

@end
