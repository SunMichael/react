//
//  WNTools.m
//  yizhenjia
//
//  Created by 汪宁 on 16/8/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WNTools.h"

@implementation WNTools


+(void)writeToCache:(id)obj fileName:( NSString * _Nonnull )name
{
    NSString *home = NSHomeDirectory();
    NSString *cachePath=[home stringByAppendingPathComponent:@"Library"];
    
    cachePath= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    cachePath=[NSString stringWithFormat:@"%@/%@.data",cachePath,name];
    NSData *data=[[NSData alloc]init];
    
    if ([obj isKindOfClass:[NSString class]]) {
        data=[obj dataUsingEncoding:NSUTF8StringEncoding];
        [data writeToFile:cachePath atomically:YES];
    }else if ([obj isKindOfClass:[NSArray class]])
    {
        [NSKeyedArchiver archiveRootObject:obj toFile:cachePath];
        
    }else if ([obj isKindOfClass:[NSDictionary class]])
    {
        [NSKeyedArchiver archiveRootObject:obj toFile:cachePath];
    }else if ([obj isKindOfClass:[NSData class]])
    {
        [obj writeToFile:cachePath atomically:YES];
    }
    
    
    
    
}

+(nullable id)getFromeCache:(NSString * _Nonnull)fileName
{
    
    NSString *home = NSHomeDirectory();
    
    NSString *cachePath=[home stringByAppendingPathComponent:@"Library"];
    
    cachePath= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    cachePath=[NSString stringWithFormat:@"%@/%@.data",cachePath,fileName];
    
    NSData *data=[NSData dataWithContentsOfFile:cachePath];
    NSString *result=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    id obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (obj!=nil) {
        return  obj;
    }
    
    return result;
}
+(void)removeCache
{
    NSString *home = NSHomeDirectory();
    
    NSString *cachePath=[home stringByAppendingPathComponent:@"Library"];
    
    cachePath= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager removeItemAtPath:cachePath error:nil];
    
}
#pragma mark TIME

+(NSString*)weekday:(NSDate*)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    
    comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger week = [comps weekday];
    
    NSString*  weekDay=nil;
    switch (week) {
        case 1:
            weekDay= @"周日";
            break;
        case 2:
            weekDay= @"周一";
            break;
        case 3:
            weekDay= @"周二";
            break;
        case 4:
            weekDay= @"周三";
            break;
        case 5:
            weekDay= @"周四";
            break;
        case 6:
            weekDay= @"周五";
            break;
        case 7:
            weekDay= @"周六";
            break;
            
        default:
            break;
    }
    
    return weekDay;
    
}

+(NSDate*)convertDateFromString:(NSString*)dateString formatter:(NSString*)formatter
{
    NSDateFormatter* dataFormatter = [[NSDateFormatter alloc] init] ;
    [dataFormatter setDateFormat:formatter];
    NSDate* date=[dataFormatter dateFromString:dateString];
    return date;
}

+(NSString*)stringFromDate:(NSDate *)date formatter:(NSString*)formatter{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

+ (NSString *)getCommentTimeWith:(NSString *) createTime
{
    NSString *timeString=@"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy年M月d日 HH:mm"];
    
    //创建时间
    NSDate *createDate = [formatter dateFromString:createTime];
    //当前系统时间
    NSDate *currentDate = [NSDate date];
    
    NSString *createDateString = [dateFormatter1 stringFromDate:createDate];
    NSString *currentDateString = [dateFormatter1 stringFromDate:currentDate];
    
    NSString *createYear = [[createDateString componentsSeparatedByString:@"年"] firstObject];
    NSString *currentYear = [[currentDateString componentsSeparatedByString:@"年"] firstObject];
    if (![createYear isEqualToString:currentYear]) {
        //不同年
        timeString = createDateString;
    }else{
        //同年
        NSString *createDay = [[[[createDateString componentsSeparatedByString:@"年"] lastObject] componentsSeparatedByString:@" "] firstObject];
        NSString *currentDay = [[[[currentDateString componentsSeparatedByString:@"年"] lastObject] componentsSeparatedByString:@" "] firstObject];;
        if ([createDay isEqualToString:currentDay]) {
            //同一天
            NSTimeInterval dd = [currentDate timeIntervalSinceDate:createDate];
            
            NSInteger time = dd;
            if (time/3600 < 1){
                //1小时之内
                timeString = [NSString stringWithFormat:@"%ld", time/60];
                if ([timeString isEqualToString:@"0"]) {
                    timeString = @"刚刚";
                }else{
                    timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                }
                
            }else if (time/86400 < 1){
                //1天之内
                timeString = [[createDateString componentsSeparatedByString:@" "] lastObject];
            }else {
                
                timeString = [[createDateString componentsSeparatedByString:@"年"] lastObject];
            }
            
            
        }else{
            //不是同一天
            timeString = [[createDateString componentsSeparatedByString:@"年"] lastObject];
        }
    }
    
    return timeString;
}



+(NSInteger)getCurrentYear
{
    NSDateComponents *DateComponents=[[self class] getCurrentDateComponents:[NSDate date]];
    
    return DateComponents.year;
}
+(NSInteger)getCurrentMonth
{
    NSDateComponents *DateComponents=[[self class] getCurrentDateComponents:[NSDate date]];
    return DateComponents.month;
}
+(NSInteger)getCurrentDay
{
    NSDateComponents *DateComponents=[[self class] getCurrentDateComponents:[NSDate date]];
    return DateComponents.day;
}
+(NSInteger)getCurrentHour
{
    NSDateComponents *DateComponents=[[self class] getCurrentDateComponents:[NSDate date]];
    return DateComponents.hour;
}
+(NSInteger)getCurrentMinute
{
    NSDateComponents *DateComponents=[[self class] getCurrentDateComponents:[NSDate date]];
    return DateComponents.minute;
}
+(NSInteger)getCurrentSecond
{
    NSDateComponents *DateComponents=[[self class] getCurrentDateComponents:[NSDate date]];
    return DateComponents.second;
}
+(NSDateComponents *)getCurrentDateComponents:(NSDate *)date
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    return dateComponent;
    
}
+(NSString *)transDateToString:(NSDate *)date
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger year=dateComponent.year;
    NSInteger month=dateComponent.month;
    NSInteger day=dateComponent.day;
    NSString * timeStr;
    
    timeStr=[NSString stringWithFormat:@"%ld年%ld月%ld日",(long)year,month,day];
    return timeStr;
    
    
}
+ (NSString *)changeTimeFormatterWith:(NSString *)sendTime andFormatter:(NSString *)format{
    NSTimeInterval time = [sendTime doubleValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}
@end
