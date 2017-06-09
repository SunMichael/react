//
//  AdScrollView.h
//  yizhenjia
//
//  Created by mac on 2016/11/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AdScrollPositionHorizontal,
    AdScrollPositionVertical,
} AdScrollPosition;
/**
 广告轮播视图
 */
@interface AdScrollView : UIScrollView <UIScrollViewDelegate>

@property(nonatomic ,assign) float intervalTime ;       //间隔时间

- (instancetype)initWithFrame:(CGRect)frame andScrollPosition:(AdScrollPosition)position;

- (void)updateAdScrollViewWithModelAry:(NSArray *)modelAry;
@end
