//
//  RCTBridge.m
//  ZATools
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ZAAlertView.h"
//#define RCT_EXPORT_MODULE(@"jsName")

//RCT_EXTERN void RCTRegisterModule(Class);


@implementation ZAAlertView

//+(NSString *)moduleName{
//    return @"jsName";
//}
//
//+(void)load{
//    RCTRegisterModule(self);
//}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(show:(NSString *)msg callback:(RCTResponseSenderBlock)callback){
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"js调用oc方法" message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    callback(@[[NSNull null] , @{@"event": @"callbackmsg"}]);  //数组里有几个元素，对应js block参数个数
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@" clicked alertview ");
}


/*  常用三种数据互传block
 RCTResponseSenderBlock     
 RCTPromiseResolveBlock
 RCTPromiseRejectBlock
 */

@end
