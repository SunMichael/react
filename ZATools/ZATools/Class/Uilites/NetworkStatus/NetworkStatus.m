//
//  NetworkStatus.m
//  yizhenjia
//
//  Created by mac on 16/8/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NetworkStatus.h"
#import "AFNetworking.h"
#import "IvyUserDefaults.h"

@implementation NetworkStatus

+(BOOL)currentNetworkStatus{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (void)addNetworkStatusNotification:(NetworkStatusBlock)statusBlock{
    AFNetworkReachabilityManager *reachablityManager = [AFNetworkReachabilityManager sharedManager];
    [reachablityManager startMonitoring];
    [reachablityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        
        if (status == AFNetworkReachabilityStatusUnknown)
        {
            statusBlock(NetworkStatusTypeUnknown);
        }
        else if (status == AFNetworkReachabilityStatusNotReachable)
        {
            statusBlock(NetworkStatusTypeNotReachable);
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWWAN)
        {
            statusBlock(NetworkStatusTypeReachableViaWWAN);
        }
        else
        {
            statusBlock(NetworkStatusTypeReachableViaWiFi);
        }
    }];
    
}

+ (void)doUploadWithUrl:(NSString *)url fileData:(NSData *)data progress:(UploadProgress)progress callback:(UploadCallback)callback
{
}



@end
