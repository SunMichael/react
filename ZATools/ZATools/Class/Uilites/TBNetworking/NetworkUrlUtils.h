//
//  NetworkUrlEncode.h
//  NetworkingDemo
//
//  Created by 李华光 on 15/9/29.
//  Copyright © 2015年 李华光. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkUrlUtils : NSObject

+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString
                          appendParameters:(NSDictionary *)parameters;

+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters;

+ (NSArray *)sortedArrayUsingAsc:(NSArray *)array;

+ (NSString *)doMD5StringFromString:(NSString *)string;

+ (NSString *)doSHA1StringFromString:(NSString *)string;

+ (NSString *)doSHA256StringFromString:(NSString *)string;

@end
