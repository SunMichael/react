//
//  AccountService.h
//  yizhenjia
//
//  Created by mac on 16/8/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestError.h"
#import "LoginModel.h"


@interface AccountService : NSObject

+ (AccountService*)shareInstance;


/**
 *  账户注册
 *
 *  @param phone      手机号
 *  @param password   密码
 *  @param completion
 */
//- (void)registerWithPhone:(NSString*)phone password:(NSString*)password andCode:(NSString *)code completionBlock:(void (^)(Account* account, RequestError* error))completion;


/**
 *  快速登录接口
 *
 *  @param phone      手机号
 *  @param code       验证码

 */
- (void)fastLoginInWithPhone:(NSString *)phone andCode:(NSString *)code completionBlock:(void (^)(Account* account, RequestError* error))completion;

/**
 *  获取验证码
 *
 *  @param type     1 注册  2找回密码

 */
- (void)getCodeWithIndetfiyType:(NSString*)type phone:(NSString*)phone completionBlock:(void (^)(id responseObj))completion;


/*
 *  账户登录
 *  @param phone
 *  @param password
 
 
 */

-(void)loginWithUserName:(NSString *)userName password:(NSString *)password completionBlock:(void(^)(Account* account,RequestError *error))completion;

/*  校验验证码
 *  @param phone
 *  @param type   1 注册  2 忘记密码
 *  @param valicode
 */
- (void)checkCodeWithPhone:(NSString *)phone type:(NSString *)type valicode:(NSString *)valicode completion:(void(^)(BOOL isSuccess))completion;





@end
