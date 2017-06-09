//
//  YZJGifHeader.m
//  Refresh
//
//  Created by 汪宁 on 16/8/24.
//  Copyright © 2016年 ZHENAI. All rights reserved.
//

#import "YZJGifHeader.h"

@implementation YZJGifHeader
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i <= 9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%d", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *pullingImages = [NSMutableArray array];
    for (int i = 12; i <= 23; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%d",i]];
        [pullingImages addObject:image];
    }
    NSArray *ary = [[pullingImages reverseObjectEnumerator] allObjects];
    [pullingImages addObjectsFromArray:ary];
    [self setImages:pullingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:pullingImages forState:MJRefreshStateRefreshing];

}

@end
