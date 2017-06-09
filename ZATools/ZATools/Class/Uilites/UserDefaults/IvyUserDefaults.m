//
//  IvyUserDefaults.m
//  Ivy
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "IvyUserDefaults.h"
#import "SSKeychain.h"
@implementation IvyUserDefaults {
    NSUserDefaults* userDefaults;
}
+ (id)shareUserDefaults
{
    static dispatch_once_t onceToken;
    static IvyUserDefaults* user;
    dispatch_once(&onceToken, ^{
        if (user == nil) {
            user = [[self alloc] init];
        }
    });
    return user;
}
- (instancetype)init
{
    userDefaults = [NSUserDefaults standardUserDefaults];
    return self;
}

// 是否是第一次启动
- (void)setIsFirstLaunch:(BOOL)isFirst
{
    [userDefaults setBool:isFirst forKey:@"IsFirstLaunch"];
    [userDefaults synchronize];
}
- (BOOL)getIsFirstLaunch
{
    return [userDefaults boolForKey:@"IsFirstLaunch"];
}
// 上一次版本号
- (void)setCurrentVersion:(NSString*)version
{
    [userDefaults setObject:version forKey:@"SaveCurrentVersion"];
    [userDefaults synchronize];
}
- (NSString*)getCurrentVersion
{
    return [userDefaults objectForKey:@"SaveCurrentVersion"];
}


- (void)setUserInfor:(Account *)account{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:account];
    [userDefaults setObject:data forKey:@"Account"];
}
- (Account *)getUserInfor{
    NSData* data = [userDefaults objectForKey:@"Account"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

-(void)setPhoto:(NSData *)imageData
{
    [userDefaults setObject:imageData forKey:@"IMAGE"];
}
-(UIImage *)getPhoto
{
  NSData *imageData=[userDefaults objectForKey:@"IMAGE"];
    UIImage *image=[UIImage imageWithData:imageData];
    return image;
}

-(void)setLocateCity:(NSString *)str
{
  [userDefaults setObject:str forKey:@"CurrentCity"];
    
}
-(NSString *)getLocateCity
{
   NSString *city=[userDefaults objectForKey:@"CurrentCity"];
    return city;
    
}

- (void)setToken:(NSString *)token{
    [userDefaults setObject:token forKey:@"token"];
}
- (NSString *)getToken{
    if ([userDefaults objectForKey:@"token"]) {
        NSString *token = [userDefaults objectForKey:@"token"];
        if ([token isEqualToString:@"123456"]) {     //游客
            return @"123456";
        }else{
            return [userDefaults objectForKey:@"token"];
        }
    }else{
        return @"123456";
    }
    return [userDefaults objectForKey:@"token"];
}


- (void)setUserId:(NSString *)userid{
    [userDefaults setObject:userid forKey:@"userid"];
}
- (NSString *)getUserId{
    if ([userDefaults objectForKey:@"userid"]) {
        NSString *token = [userDefaults objectForKey:@"userid"];
        if ([token isEqualToString:@"-1000"]) {     //游客
            return @"-1000";
        }else{
            return [userDefaults objectForKey:@"userid"];
        }
    }else{
        return @"-1000";
    }

    return [userDefaults objectForKey:@"userid"];
}


- (void)setYueSaoInfor:(YueSaoModel *)ysModel{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:ysModel];
    [userDefaults setObject:data forKey:@"Yuesao"];
}
- (YueSaoModel *)getYueSaoInfor{
    NSData* data = [userDefaults objectForKey:@"Yuesao"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)setAllProvinceData:(NSMutableArray*)allProvince
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:allProvince];
    [userDefaults setObject:data forKey:@"allProvince"];
    [userDefaults synchronize];
}
- (NSMutableArray*)getAllProvince
{
    NSData* data = [userDefaults objectForKey:@"allProvince"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
- (void)setAllStreetData:(NSMutableArray*)allStreet{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:allStreet];
    [userDefaults setObject:data forKey:@"allStreet"];
    [userDefaults synchronize];
}
- (NSMutableArray*)getAllStreetData{
    NSData* data = [userDefaults objectForKey:@"allStreet"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)setAllCityData:(NSMutableArray*)allCity{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:allCity];
    [userDefaults setObject:data forKey:@"allCity"];
    [userDefaults synchronize];
}
- (NSMutableArray*)getAllCityData{
    NSData* data = [userDefaults objectForKey:@"allCity"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)setLocationCode:(NSString *)code{
    [userDefaults setObject:code forKey:@"citycode"];
}
- (NSString *)getLocationCode{
    return [userDefaults objectForKey:@"citycode"];
}


- (void)setAllCity:(NSArray *)array
{
     NSData* data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [userDefaults setObject:data forKey:@"AllCity"];
}
- (NSArray *)getAllCity
{
    NSData* data = [userDefaults objectForKey:@"AllCity"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)setUserLocation:(UserLocation *)userLocation
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:userLocation];
    [userDefaults setObject:data forKey:@"UserLocationInfo"];
}
- (UserLocation *)getUserLocation
{
    NSData* data = [userDefaults objectForKey:@"UserLocationInfo"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

-(NSString *)getDeviceUniq{
    NSString *uniq = [SSKeychain passwordForService:@"yizhenjia" account:@"deviceuniq"];
    if ([NSString isEmply:uniq]) {
        NSDate* nowDate=[NSDate date];
        NSTimeZone* zone=[NSTimeZone systemTimeZone];
        NSInteger interval=[zone secondsFromGMTForDate:nowDate];
        NSDate* locationDate=[nowDate dateByAddingTimeInterval:interval];
        int rand =arc4random()%10000000;
        NSString * deviceId=[NSString stringWithFormat:@"%@%d",locationDate,rand];
        [SSKeychain setPassword:deviceId forService:@"yizhenjia" account:@"deviceuniq"];
        return deviceId;
    }
    return uniq;
}



- (void)setNeedMissKeyboard:(BOOL)need{
    [userDefaults setBool:need forKey:@"misskeyboard"];
}
- (BOOL)getNeedMissKeyboard{
    return [userDefaults boolForKey:@"misskeyboard"];
}

- (void)setServiceCityAry:(NSArray *)ary{
    [userDefaults setObject:ary forKey:@"servicecity"];
}

- (NSArray *)getServiceCityAry{
    return [userDefaults objectForKey:@"servicecity"];
}

- (void)setShareUrl:(NSString *)url{
    [userDefaults setObject:url forKey:@"shareurl"];
}
- (NSString *)getShareUrl{
    return [userDefaults objectForKey:@"shareurl"];
}


- (void)setTipCloseDate:(NSTimeInterval)time{
    [userDefaults setDouble:time forKey:@"closeTime"];
}

- (NSTimeInterval)getTipCloseDate{
    return [userDefaults doubleForKey:@"closeTime"];
}


- (void)setLastCheckVersionTime:(NSTimeInterval) time{
    [userDefaults setDouble:time forKey:@"checkVersionTime"];
}
- (NSTimeInterval)getLastCheckVersionTIme{
    return [userDefaults doubleForKey:@"checkVersionTime"];
}


- (void)setBabyInfor:(BabyInfoModel *)babyInfoModel{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:babyInfoModel];
    [userDefaults setObject:data forKey:@"babyInfoModel"];
}
- (BabyInfoModel *)getBabyInfor{
    NSData* data = [userDefaults objectForKey:@"babyInfoModel"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

-(void)setBabyPhoto:(NSData *)imageData{
    [userDefaults setObject:imageData forKey:@"BABYIMAGE"];
}

-(UIImage *)getBabyPhoto{
    NSData *imageData=[userDefaults objectForKey:@"BABYIMAGE"];
    UIImage *image=[UIImage imageWithData:imageData];
    return image;
}

//获取之前喂食统计时间
- (void)setFeedDay:(NSInteger )feedDay{
    [userDefaults setInteger:feedDay forKey:@"feedDay"];
}
- (NSInteger)getFeedDay{
    return [userDefaults integerForKey:@"feedDay"];
}
//获取之前睡眠统计时间
- (void)setSleepDay:(NSInteger)sleepDay{
    [userDefaults setInteger:sleepDay forKey:@"sleepDay"];
}
- (NSInteger)getSleepDay{
    return [userDefaults integerForKey:@"sleepDay"];
}
- (void)setRecordNoticeDidShow:(BOOL)show{
    [userDefaults setBool:show forKey:@"recordNotice"];
}
- (BOOL)getRecordNoticeDidShow{
    return [userDefaults boolForKey:@"recordNotice"];
}


- (void)setAllNoticeIdAry:(NSMutableArray *)mAry{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:mAry];
    [userDefaults setObject:data forKey:@"allNoticeAry"];
    [userDefaults synchronize];
}
- (NSMutableArray *)getAllNoticeIdAry{
    id obj = [userDefaults objectForKey:@"allNoticeAry"];
    if ([obj isKindOfClass:[NSData class]]) {
        NSData* data = obj;
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }else if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSMutableArray class]]){
        return [userDefaults objectForKey:@"allNoticeAry"];
    }
    return nil;
}

@end
