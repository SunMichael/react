//
//  YZJRefreshHeader.h
//  Refresh
//
//  Created by 汪宁 on 16/8/24.
//  Copyright © 2016年 ZHENAI. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface YZJRefreshHeader : MJRefreshHeader



/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state;

@end
