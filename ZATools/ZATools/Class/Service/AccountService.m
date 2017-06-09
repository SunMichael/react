//
//  AccountService.m
//  yizhenjia
//
//  Created by mac on 16/8/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AccountService.h"
#import "RequestApi.h"
#import "NSString+BK.h"
#import "Account.h"
#import "NSObject+YYModel.h"
#import "IvyUserDefaults.h"

#import "NetworkServiceConfig.h"
#import "UMessage.h"


@implementation AccountService


+ (AccountService*)shareInstance
{
    static AccountService* service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[AccountService alloc] init];
    });
    return service;
}


-(void)fastLoginInWithPhone:(NSString *)phone andCode:(NSString *)code completionBlock:(void (^)(Account *, RequestError *))completion{
    RequestApi *api = [[RequestApi alloc] init];
    api.apiPath = @"user/login";
    api.postMethod = YES;
    api.bodyParamters = [NSMutableDictionary dictionaryWithDictionary:@{@"phone":phone ,@"code":code}];
    [api startWithSuccess:^(RequestApi *api) {
        
        id obj = [api resultJSONObject];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = obj;
            NSString *token = dic[@"token"];
            Account *account = [Account yy_modelWithDictionary:dic[@"user"]];
            [[IvyUserDefaults shareUserDefaults] setUserInfor:account];
            [[IvyUserDefaults shareUserDefaults] setToken:token];
            [[IvyUserDefaults shareUserDefaults] setUserId:account.uid];
            if ([NSString isEmply:account.birth_type]) {
                account.birth_type = @"0";
            }
            completion(account ,nil);
            
            //绑定用户推送信息
            NSString *online = @"test";
            if ([[NetworkServiceConfig shareInstance] isOnline]) {
                online = @"online";
            }
            NSString *alia = [NSString stringWithFormat:@"%@_%@",online,account.uid];
            [UMessage setAlias:alia type:@"alias_uid" response:^(id responseObject, NSError *error) {
                NSLog(@" c %@ \n  失败： %@ ",responseObject,error);
            }];
            
        }
        completion(nil ,nil);
    } failure:^(RequestApi *api) {
        completion(nil,api.requestError);
    }];
    
}


- (void)getCodeWithIndetfiyType:(NSString *)type phone:(NSString *)phone completionBlock:(void (^)(id ))completion{
    RequestApi *api = [[RequestApi alloc] init];
    api.apiPath = @"user/getCode";
    api.bodyParamters = [NSMutableDictionary dictionaryWithDictionary:@{@"phone":phone ,@"type": type}];
    api.postMethod = YES;
    [api startWithSuccess:^(RequestApi *api) {
        id Obj=[api resultJSONObject];
        completion(Obj);
    } failure:^(RequestApi *api) {
        completion(api.requestError);
    }];
}

-(void)loginWithUserName:(NSString *)userName password:(NSString *)password completionBlock:(void(^)(Account* account,RequestError *error))completion
{
    RequestApi *api = [[RequestApi alloc] init];
    api.apiPath = @"user/login";
    api.postMethod = YES;
    api.bodyParamters = [NSMutableDictionary dictionaryWithDictionary:@{@"phone":userName ,@"code": password}];
    [api startWithSuccess:^(RequestApi *api) {
        Account *account = [Account yy_modelWithDictionary:[api resultJSONObject]];
        completion(account ,nil);
    } failure:^(RequestApi *api) {
        completion(nil,api.requestError);
    }];
    
    
    
}
- (void)checkCodeWithPhone:(NSString *)phone type:(NSString *)type valicode:(NSString *)valicode completion:(void(^)(BOOL isSuccess))completion
{
    
    
}


@end
