//
//  ZAEvent.m
//  ZATools
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ZAEvent.h"
#import <AVKit/AVPlayerViewController.h>

@implementation ZAEvent
@synthesize bridge = _bridge;


RCT_EXPORT_MODULE()

/**
 支持事件的名

 @return array<string>
 */
-(NSArray<NSString *> *)supportedEvents{
    return @[@"sendCallback",@"sendMessage"];
}

- (void)receivedCallback:(NSString *)code result:(NSString *)result{
    [self sendEventWithName:@"sendCallback" body:@{@"code" : code,
                                                   @"result" : result}];
}

- (void)sendMessage:(NSString *)msg{

    [self sendEventWithName:@"sendMessage" body:@{@"msg" : msg}];
}

/*
 这样写直接用的话 会报 bridge = nil 错误，需要react提前调用native建立bridge？？?
*/


@end
