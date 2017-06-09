//
//  NetworkServiceConfig.m
//  NetworkingDemo
//
//  Created by 李华光 on 15/9/7.
//  Copyright (c) 2015年 李华光. All rights reserved.
//

#import "NetworkServiceConfig.h"

@interface NetworkServiceConfig ()
@property (nonatomic, strong, readwrite) NSString* baseUrl;
@property (nonatomic, strong, readwrite) NSString* apiPath;
@property (nonatomic, strong, readwrite) NSString* appKey;
@property (nonatomic, strong, readwrite) NSString* appSecret;
@property (nonatomic, strong, readwrite) NSString* apiVersion;
@end

@implementation NetworkServiceConfig

+ (NetworkServiceConfig*)shareInstance
{
    static dispatch_once_t onceToken;
    static NetworkServiceConfig* serviceConfig;
    dispatch_once(&onceToken, ^{
        serviceConfig = [[NetworkServiceConfig alloc] init];
        serviceConfig.isOnline = YES;
        serviceConfig.openDebug = YES;
        serviceConfig.testNumber = 3;
    });
    return serviceConfig;
}

#pragma mark - getters and setters

- (NSString*)domainUrl
{
    if (self.isOnline) {
        return @"http://appapi.yizhenjia.com/";
    }
    else {
        return @"http://mobile.api-test.yizhenjia.com/";
//        return @"https://test.yizhenjia.com/";
    }
}

- (NSString*)apiPath
{
    if (self.isOnline) {
        return @"/router";
    }
    else {
        return @"/router";
    }
}

- (NSString*)apiVersion
{
    if (self.isOnline) {
        return @"1.0";
    }
    else {
        return @"1.0";
    }
}

-(NSString *)appKey{
    return _isOnline ? @"app_online" : @"test123";
}

-(NSString *)appSecret{
    return _isOnline ? @"72hk4hh4k5h2j423k26" : @"25257758";
}

@end
