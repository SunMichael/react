//
//  NetworkStatus.h
//  yizhenjia
//
//  Created by mac on 16/8/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NetworkStatusType) {
    NetworkStatusTypeUnknown,
    NetworkStatusTypeNotReachable,
    NetworkStatusTypeReachableViaWWAN,
    NetworkStatusTypeReachableViaWiFi
};

typedef void(^NetworkStatusBlock)(NetworkStatusType status);

typedef void (^UploadProgress)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);
typedef void (^UploadCallback)(int code, NSDictionary *responseResult);

@interface NetworkStatus : NSObject

+ (BOOL)currentNetworkStatus;

+ (void)addNetworkStatusNotification:(NetworkStatusBlock)statusBlock;

+ (void)doUploadWithUrl:(NSString *)url fileData:(NSData *)data progress:(UploadProgress)progress callback:(UploadCallback)callback;


@end
