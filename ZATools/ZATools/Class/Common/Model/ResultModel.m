//
//  BaseModel.m
//  Ivy
//
//  Created by 李华光 on 15/5/28.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "ResultModel.h"

@implementation ResultModel

-(id)initResultModel:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        NSString *subErrorMsg = PASS_NULL_TO_NIL([dictionary objectForKey:@"subErrorMsg"]);
        if (subErrorMsg == nil)
        {
            self.returnMsg = PASS_NULL_TO_NIL([dictionary objectForKey:@"msg"]);
        }
        else
        {
            self.returnMsg = subErrorMsg;
        }
        self.returnCode = [PASS_NULL_TO_NIL([dictionary objectForKey:@"code"]) integerValue];
        self.returnData = PASS_NULL_TO_NIL([dictionary objectForKey:@"result"]);
    }
    return self;
}

@end
