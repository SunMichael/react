//
//  Account.h
//  yizhenjia
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"
@interface Account : NSObject <NSCoding>

@property(nonatomic ,copy)NSString *uid;
@property(nonatomic ,copy)NSString *logo;
@property(nonatomic ,copy)NSString *nickName;
@property(nonatomic ,copy)NSString *realName;
@property(nonatomic ,copy)NSString *phone;
//@property(nonatomic ,copy)NSString *token;


@property(nonatomic ,copy) NSString *product;    //是否已生产
@property(nonatomic ,copy) NSString *address;

@property(nonatomic, copy) NSString *babyBirthDate;
@property(nonatomic, copy) NSString *expectedBirthDate;


@property(nonatomic, copy) NSString *babyBirthDateString;
@property(nonatomic, copy) NSString *expectedBirthDateString;


// babyBirthDate  //createdTime

@property(nonatomic, copy) NSString *pouFu;
@property(nonatomic, copy) NSString *nurseWay;

@property(nonatomic, copy)NSString *is_cesarean;// 0顺产  1剖腹
@property(nonatomic, copy)NSString *baby_sex; //0男 1女
@property(nonatomic, copy)NSString *nursing_mode;//0-母乳喂养 1-奶粉喂养 2-混合喂养
@property(nonatomic, copy) NSString *birth_type;// 0-待产 1-产后

@property(nonatomic ,copy) NSString *proviceCode;
@property(nonatomic, copy) NSString *proviceName;
@property(nonatomic, copy) NSString *districtCode;
@property(nonatomic, copy) NSString *districtName;
@property(nonatomic, copy) NSString *cityCode;
@property(nonatomic, copy) NSString *cityName;

@property(nonatomic, copy) NSString *countDays;

//v2.0 new
@property(nonatomic ,copy) NSString *numberLevel;    //会员等级

@end
