//
//  WebViewController.h
//  yizhenjia
//
//  Created by mac on 16/8/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseController.h"


/**
 *  H5页面  (服务详情)
 */
@interface WebViewController : BaseController

@property(nonatomic ,copy) NSString *webTitle;
@property(nonatomic ,copy) NSString *webURL;


@property (nonatomic ,assign) BOOL isWiki;

@property (nonatomic ,assign) BOOL normalWeb;
@property(nonatomic ,copy) NSString *tableIndex;

@end
