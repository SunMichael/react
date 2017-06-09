//
//  LocationInforModel.h
//  ApManager
//
//  Created by mac on 15/12/9.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationInforModel : NSObject

@property(nonatomic ,copy) NSString *proName;     //省
@property(nonatomic ,copy) NSString *cityName;    //市
@property(nonatomic ,copy) NSString *areaName;    //区
@property(nonatomic ,assign) BOOL isAdministrativeArea;    //是否是直辖市
@property(nonatomic ,assign) CGFloat latitude;
@property(nonatomic ,assign) CGFloat longitude;

@property(nonatomic ,copy) NSString *streetAdress;       //街道


+(LocationInforModel *)shareLocationInfor;
@end
