//
//  LocationInforModel.m
//  ApManager
//
//  Created by mac on 15/12/9.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "LocationInforModel.h"

@implementation LocationInforModel

+(LocationInforModel *)shareLocationInfor{
    static dispatch_once_t onceToken;
    static LocationInforModel *model;
    dispatch_once(&onceToken, ^{
        model = [[LocationInforModel alloc] init];
    });
    return model;
}

@end
