//
//  IvyUserDefaults.h
//  Ivy
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Account;
@class YueSaoModel;
@class UIImage;
@class UserLocation;
@class BabyInfoModel;

/**
*  userDefaults单例
*/
@interface IvyUserDefaults : NSUserDefaults
/**
*  生成单例对象
*
*  @return userDefaults
*/
+ (id)shareUserDefaults;

// 是否是第一次启动
- (void)setIsFirstLaunch:(BOOL)isFirst;
- (BOOL)getIsFirstLaunch;

// 上一次版本号
- (void)setCurrentVersion:(NSString*)version;
- (NSString*)getCurrentVersion;


/**
 *  保存 获取账号
 *
 *  @param account
 */
- (void)setUserInfor:(Account *)account;
- (Account *)getUserInfor;

/**
 *  保存 获取宝宝档案
 *
 *  @param account
 */
- (void)setBabyInfor:(BabyInfoModel *)babyInfoModel;
- (BabyInfoModel *)getBabyInfor;


//获取头像
-(void)setPhoto:(NSData *)imageData;

-(UIImage *)getPhoto;

//获取宝宝头像
-(void)setBabyPhoto:(NSData *)imageData;

-(UIImage *)getBabyPhoto;



-(void)setLocateCity:(NSString *)str;
-(NSString *)getLocateCity;

/**
 *  获取定位城市编码
 *
 *  @param code
 */
- (void)setLocationCode:(NSString *)code;
- (NSString *)getLocationCode;

/**
 *  保存  获取token
 *
 *  @param token
 */
- (void)setToken:(NSString *)token;
- (NSString *)getToken;

- (void)setUserId:(NSString *)userid;
- (NSString *)getUserId;

/**
 *  保存获取月嫂信息
 *
 *  @param ysModel 
 */
- (void)setYueSaoInfor:(YueSaoModel *)ysModel;
- (YueSaoModel *)getYueSaoInfor;

- (void)setAllProvinceData:(NSMutableArray*)allProvince;
- (NSMutableArray*)getAllProvince;

- (void)setAllStreetData:(NSMutableArray*)allStreet;
- (NSMutableArray*)getAllStreetData;

- (void)setAllCityData:(NSMutableArray*)allCity;
- (NSMutableArray*)getAllCityData;
 // 本地存储 门店城市信息

- (void)setAllCity:(NSArray *)array;
- (NSArray *)getAllCity;

- (void)setUserLocation:(UserLocation *)userLocation;
- (UserLocation *)getUserLocation;

/**
 *  获取设备唯一标示
 *
 *  @return 
 */
- (NSString *)getDeviceUniq;


//v2.0 new storeinfor

- (void)setNeedMissKeyboard:(BOOL)need;
- (BOOL)getNeedMissKeyboard;


- (void)setServiceCityAry:(NSArray *)ary;      //服务城市列表
- (NSArray *)getServiceCityAry;

- (void)setShareUrl:(NSString *)url;
- (NSString *)getShareUrl;


/**
 提示关闭时间

 @param time 
 */
- (void)setTipCloseDate:(NSTimeInterval)time;
- (NSTimeInterval)getTipCloseDate;

//获取之前喂食统计时间
- (void)setFeedDay:(NSInteger)feedDay;
- (NSInteger)getFeedDay;
//获取之前睡眠统计时间
- (void)setSleepDay:(NSInteger)sleepDay;
- (NSInteger)getSleepDay;
/**
 上次检查更新时间

 @param time
 */
- (void)setLastCheckVersionTime:(NSTimeInterval) time;
- (NSTimeInterval)getLastCheckVersionTIme;



/**
 宝宝成长记录提示弹窗

 @param show
 */
- (void)setRecordNoticeDidShow:(BOOL)show;
- (BOOL)getRecordNoticeDidShow;

- (void)setAllNoticeIdAry:(NSMutableArray *)mAry;
- (NSMutableArray *)getAllNoticeIdAry;

@end
