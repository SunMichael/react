//
//  RequestApi.m
//  ApManagerRefactor
//
//  Created by lmf on 22/2/16.
//  Copyright © 2016 treebear. All rights reserved.
//


#import "NetworkServiceConfig.h"
#import "NetworkUrlUtils.h"
#import "RequestApi.h"
#import "RequestError.h"

void WTLog(NSString* format, ...)
{
#ifdef DEBUG
    va_list argptr;
    va_start(argptr, format);
    NSLogv(format, argptr);
    va_end(argptr);
#endif
}

@implementation RequestApi

static bool posted;

- (id)resultJSONObject
{
    id jsonObject = [self responseJSONObject];
    id result;
    if (jsonObject && [jsonObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary* dict = (NSDictionary*)jsonObject;
        result = [dict objectForKey:@"result"];
    }
    return result;
}

- (BOOL)isSuccess
{
    id jsonObject = [self responseJSONObject];
    //    BOOL isSucess = false;
    if (jsonObject && [jsonObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary* dict = (NSDictionary*)jsonObject;
        NSString *code = [dict objectForKey:@"code"];
        if (![NSString isEmply:code]) {
            
            if ([code intValue] == 401 && posted == false) {  //token失效
//                [[NSNotificationCenter defaultCenter] postNotificationName:kTOKENUSELESS object:nil];
                posted = true;
            }
            return [[dict objectForKey:@"code"] isEqualToString:@"0"]? YES : NO;
            
        }
    }
    
    return NO;
}

- (RequestError*)requestError
{
    id jsonObject = [self responseJSONObject];
    NSString* msg = nil;
    NSInteger code = 200;
    if (jsonObject && [jsonObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary* dict = (NSDictionary*)jsonObject;
        NSString *codeStr = [dict objectForKey:@"code"];
        if (![NSString isEmply:codeStr]) {
            code = [codeStr integerValue];
        }
        msg = [dict objectForKey:@"errorMsg"];
    }
    RequestError* error = [[RequestError alloc] initWithCode:code message:msg];
    return error;
}

//Override this method to return
- (NSString*)methodName
{
    return nil;
}

- (NSDictionary*)urlParamters
{
    return @{};
}

- (NSDictionary*)bodyParamters
{
    return @{};
}

- (BOOL)isHttpsRequest
{
    return false;
}

- (BOOL)isLogin
{
    return YES;
}
- (void)setHeaderContentType:(NSString *)type{
    
}
//修改请求 User-Agent
- (NSDictionary*)requestHeaderFieldValueDictionary
{
    NSMutableArray* agent = [NSMutableArray arrayWithCapacity:7];
    
    agent[0] = @"iOS";
    agent[1] = @"yizhenjia";
    agent[2] = [UIDevice currentDevice].systemVersion;
    agent[3] = [NSString stringWithFormat:@"%d*%d", (int)kScreenWidth, (int)kScreenHeight];
    
    NetworkServiceConfig* config = [NetworkServiceConfig shareInstance];
    
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:[self requestArgument]];
    mDic[@"app_key"] = config.appKey;
    mDic[@"app_secret"] = config.appSecret;
    NSString *signValue = [RequestApi doSignStringFromParameters:mDic appSecret:config.appSecret];
    
    NSString *token =@"";
    NSString *userid =@"";
    if ([[IvyUserDefaults shareUserDefaults] getToken]) {
        token = [[IvyUserDefaults shareUserDefaults] getToken];
        userid = [[IvyUserDefaults shareUserDefaults] getUserId];
    }
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *deviceUniq = [NSString doFileMD5:[[IvyUserDefaults shareUserDefaults] getDeviceUniq]];
    
    return @{ @"User-Agent" : [agent componentsJoinedByString:@";"] ,
              @"sign" : signValue ,
              @"os": @"2",
              @"uid": userid,
              @"token": token,
              @"ver":version,
              @"did":deviceUniq};
    
}

- (NSString*)requestUrl
{
    NetworkServiceConfig* config = [NetworkServiceConfig shareInstance];
    NSString* baseUrl = [config.domainUrl stringByAppendingString:_apiPath];
    if ([self isHttpsRequest] && config.isOnline) {
        baseUrl = [baseUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    }
    return baseUrl;
}

- (NSDictionary*)requestArgument
{
    NSMutableDictionary* resultParams = [NSMutableDictionary dictionary];
    [resultParams addEntriesFromDictionary:_bodyParamters];
    
    return resultParams;
}

// 签名
+ (NSString*)doSignStringFromParameters:(NSDictionary*)params appSecret:(NSString*)appSecret
{
    NSArray* keys = [NetworkUrlUtils sortedArrayUsingAsc:[params allKeys]];
    NSMutableString* buildStr = [[NSMutableString alloc] initWithString:@""];
    for (NSString* key in keys) {
        NSString* value = [params objectForKey:key];
        [buildStr appendFormat:@"%@=%@&", key, value];
    }
    buildStr = (NSMutableString *)[buildStr substringToIndex:buildStr.length-1];
    NSString* signStr = [NetworkUrlUtils doSHA1StringFromString:buildStr];
    
    return signStr;
}

- (void)startWithSuccess:(void (^)(RequestApi* api))success failure:(void (^)(RequestApi* api))failure
{
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest* request) {
        NSLog(@" response == %@ ",[request responseJSONObject]);
        if ([self isSuccess]) {
            success(self);
        }
        else {
            NSString* returnMsg = [[request responseJSONObject] objectForKey:@"errorMsg"];
            NSLog(@" ERROR : %@ ",returnMsg);
            failure(self);
        }
        
        [self performSelector:@selector(missLoading) withObject:nil afterDelay:0.5f];
    }
                                      failure:^(__kindof YTKBaseRequest* request) {
                                          
                                          failure(self);
                                          [self performSelector:@selector(missLoading) withObject:nil afterDelay:0.5f];
                                      }];
}
- (void)missLoading{
    [GiFHUD dismiss];
}
-(YTKRequestMethod)requestMethod{
    return _postMethod ?  YTKRequestMethodPOST : YTKRequestMethodGET;
}

//添加打印url信息
- (void)start
{
    [super start];
    //    WTLog(@"%@:%@", [self methodName], [self.requestOperation.request URL]);
}

@end
