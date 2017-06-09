//
//  WNTools.h
//  yizhenjia
//
//  Created by 汪宁 on 16/8/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNTools : NSObject


+(void)writeToCache:(_Nullable id)obj fileName:( NSString * _Nonnull )name;

+(nullable id)getFromeCache:(NSString * _Nonnull)fileName;

+(void)removeCache;

+(nullable NSString*)weekday:(nullable NSDate*)date;
+(nullable NSDate*)convertDateFromString:(nullable NSString*)dateString formatter:(nullable NSString*)formatter;
+(nullable NSString*)stringFromDate:(nullable NSDate *)date formatter:(nullable NSString*)formatter;
+(nullable NSString *)getCommentTimeWith:(nullable NSString *) createTime;

+(nullable NSString*)transDateToString:(nullable NSDate *)date;
+(NSInteger)getCurrentYear;
+(NSInteger)getCurrentMonth;
+(NSInteger)getCurrentDay;
+(NSInteger)getCurrentHour;
+(NSInteger)getCurrentMinute;
+(NSInteger)getCurrentSecond;

/**
 时间戳转字符

 @param sendTime
 @param format

 @return 
 */
+ (nullable NSString *)changeTimeFormatterWith:(nullable NSString *)sendTime andFormatter:(nullable NSString *)format;
@end
