//
//  RequestApi.h
//  ApManagerRefactor
//
//  Created by lmf on 22/2/16.
//  Copyright © 2016 treebear. All rights reserved.
//

#import "YTKRequest.h"
@class RequestError;

@interface RequestApi : YTKRequest

@property(nonatomic ,strong)NSMutableDictionary *bodyParamters;
@property(nonatomic ,strong)NSMutableDictionary *urlParamters;
@property(nonatomic ,copy) NSString *apiPath;
@property(nonatomic ,assign) BOOL postMethod;

- (BOOL)isSuccess;
- (BOOL)isHttpsRequest;
- (BOOL)isLogin;
- (RequestError*)requestError;
- (NSString*)methodName;

- (id)resultJSONObject;
- (void)startWithSuccess:(void (^)(RequestApi* api))success failure:(void (^)(RequestApi* api))failure;



@end
