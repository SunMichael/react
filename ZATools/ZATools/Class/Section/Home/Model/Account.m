//
//  Account.m
//  yizhenjia
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Account.h"

@implementation Account

@synthesize expectedBirthDateString = _expectedBirthDateString;
@synthesize babyBirthDateString = _babyBirthDateString;
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"uid" : @"id",
             @"birth_type":@"birthType",
             @"districtName":@"area",
             @"cityName":@"city",
             @"proviceName":@"province",
             @"nursing_mode":@"feedType",
             @"is_cesarean":@"isCesarean",
             @"birth_type":@"birthType",
             @"babyBirthDate":@"realBirthDate",
             @"countDays":@"days"};
}
-(NSString *)expectedBirthDateString{
    if (_expectedBirthDateString) {
        return _expectedBirthDateString;
    }else if (![NSString isEmply:_expectedBirthDate]){
        NSTimeInterval time = [_expectedBirthDate doubleValue]/1000;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        return [formatter stringFromDate:date];
    }
    return @"";
    
}
- (void)setExpectedBirthDateString:(NSString *)expectedBirthDateString{
    _expectedBirthDateString = expectedBirthDateString;
}

- (void)setBabyBirthDateString:(NSString *)babyBirthDateString{
    _babyBirthDateString = babyBirthDateString;
}
-(NSString *)babyBirthDateString{
    if (_babyBirthDateString) {
        return _babyBirthDateString;
    }else if (![NSString isEmply:_babyBirthDate]){
        NSTimeInterval time = [_babyBirthDate doubleValue]/1000;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        return [formatter stringFromDate:date];
    }
    return @"";
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [self yy_modelEncodeWithCoder:aCoder];
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    return [self yy_modelInitWithCoder:aDecoder];
}

@end
