//
//  BannerModel.h
//  yizhenjia
//
//  Created by 汪宁 on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject


@property(nonatomic, copy)NSString *h5_url;
@property(nonatomic, copy)NSString * img_url;
@property(nonatomic, copy)NSString * Id;

@property(nonatomic, copy)NSString * name;

@property(nonatomic ,strong) NSDictionary *param;
@property(nonatomic ,copy) NSString *type;

@end
