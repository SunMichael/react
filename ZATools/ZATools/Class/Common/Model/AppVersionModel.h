//
//  AppVersionModel.h
//  yizhenjia
//
//  Created by mac on 2017/2/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppVersionModel : NSObject

@property(nonatomic ,copy) NSString *downloadUrl;
@property(nonatomic ,copy) NSString *isDeleted;
@property(nonatomic ,copy) NSString *updateContent;
@property(nonatomic ,copy) NSString *version;
@property(nonatomic ,copy) NSNumber *mustUpdate;

@end
