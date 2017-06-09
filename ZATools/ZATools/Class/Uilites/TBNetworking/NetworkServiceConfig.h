//
//  NetworkServiceConfig.h
//  NetworkingDemo
//
//  Created by 李华光 on 15/9/7.
//  Copyright (c) 2015年 李华光. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkServiceConfig : NSObject

@property (nonatomic) BOOL isOnline;   // 设置线上线下环境（YES - 正式环境，NO - 开发环境）
@property (nonatomic) NSInteger testNumber; //开发环境编号
@property (nonatomic) BOOL openDebug;  // 是否打开调试模式，打开调试模式，会打印 url、request、response

@property (nonatomic, strong, readonly) NSString *domainUrl;
@property (nonatomic, strong, readonly) NSString *apiPath;
@property (nonatomic, strong, readonly) NSString *appKey;
@property (nonatomic, strong, readonly) NSString *appSecret;
@property (nonatomic, strong, readonly) NSString *apiVersion;

+ (NetworkServiceConfig *)shareInstance;

@end
