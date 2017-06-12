//
//  ZAEvent.h
//  ZATools
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <React/RCTEventDispatcher.h>
#import <React/RCTBridgeModule.h>
@interface ZAEvent : RCTEventDispatcher <RCTBridgeModule>

- (void)receivedCallback:(NSString *)code result:(NSString *)result;
- (void)sendMessage:(NSString *)msg;

@end
