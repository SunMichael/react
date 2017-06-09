//
//  NetworkUrlEncode.m
//  NetworkingDemo
//
//  Created by 李华光 on 15/9/29.
//  Copyright © 2015年 李华光. All rights reserved.
//

#import "NetworkUrlUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NetworkUrlUtils

#pragma mark - public
+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters
{
    NSString *filteredUrl = originUrlString;
    NSString *paraUrlString = [self urlParametersStringFromParameters:parameters];
    
    if (paraUrlString && paraUrlString.length > 0) {
        if ([originUrlString rangeOfString:@"?"].location != NSNotFound) {
            filteredUrl = [filteredUrl stringByAppendingString:paraUrlString];
        } else {
            filteredUrl = [filteredUrl stringByAppendingFormat:@"?%@", [paraUrlString substringFromIndex:0]];
        }
        return filteredUrl;
    }
    else {
        return originUrlString;
    }
}

+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters
{
    NSMutableString *buildStr = nil;
    for (NSString *key in [parameters allKeys]) {
        NSString *value = [self urlEncode:parameters[key]];
        if (buildStr == nil) {
            buildStr = [[NSMutableString alloc] initWithFormat:@"%@=%@", key, value];
        }
        else {
            [buildStr appendFormat:@"&%@=%@", key, value];
        }
    }
    return buildStr;
}

+ (NSArray *)sortedArrayUsingAsc:(NSArray *)array
{
    return [array sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
}

+ (NSString *)doMD5StringFromString:(NSString *)string
{
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    const char *cStr = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), outputBuffer);
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [output appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return output;
}

+ (NSString *)doSHA1StringFromString:(NSString *)string
{
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    //用此方法中文字符串转data时会造成数据丢失
    //const char *cstr = [signStr UTF8String];
    //NSData *data = [NSData dataWithBytes:cstr length:signStr.length];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

+ (NSString *)doSHA256StringFromString:(NSString *)string
{
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

#pragma mark - private
+ (NSString *)urlEncode:(NSString *)str
{
    NSString *resultUrl = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)str, CFSTR("."), CFSTR(":/?#[]@!$&'()*+,;="), kCFStringEncodingUTF8);
    return resultUrl;
}


@end
