//
//  RCTBridge.h
//  ZATools
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"
#import <React/RCTEventEmitter.h>

@interface ZAAlertView : RCTEventEmitter <RCTBridgeModule ,UIAlertViewDelegate>



@end
