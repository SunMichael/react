//
//  BaseModel.h
//  Ivy
//
//  Created by 李华光 on 15/5/28.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultModel : NSObject

@property (nonatomic, assign) NSInteger returnCode;
@property (nonatomic, copy) NSString *returnMsg;        //失败时的错误信息
@property (nonatomic, copy) id returnData;   //成功时的返回数据

-(id)initResultModel:(NSDictionary *)dictionary;

@end
