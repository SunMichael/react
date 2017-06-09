//
//  ReadModel.h
//  yizhenjia
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"
@interface ReadModel : NSObject

@property (nonatomic, copy)NSString *r_id;// 共用
@property (nonatomic, copy)NSString *infoDetailsUrl;
@property (nonatomic, copy)NSArray *tagList;
@property (nonatomic, copy)NSString *thumbPath;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *viewCount;
@property (nonatomic, copy)NSString *collectionCount;

@property(nonatomic ,copy) NSString *summary;

@end
