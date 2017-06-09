//
//  YZJRefreshHeader.m
//  Refresh
//
//  Created by 汪宁 on 16/8/24.
//  Copyright © 2016年 ZHENAI. All rights reserved.
//

#import "YZJRefreshHeader.h"


@interface YZJRefreshHeader()

@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic, readonly) UIImageView *gifView;
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;
@end
@implementation YZJRefreshHeader

- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 69.0f;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorFromRGB(0xd2d2d2);
    label.font = [UIFont boldSystemFontOfSize:11];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    
    UIImageView *gifView = [[UIImageView alloc] init];
    gifView.contentMode=UIViewContentModeScaleToFill;
//    CGFloat width=[UIScreen mainScreen].bounds.size.width;
//    gifView.frame=CGRectMake((width- 55.0f)/2, 10.0f, 55.0, 55.0f);
//    gifView.image = GetImage(@"loading9");
    [self addSubview:_gifView = gifView];
    
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    
    
}


- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    // UIImage *image = [images firstObject];
    //        if (image.size.height > self.mj_h) {
    //            self.mj_h = image.size.height;
    //        }
}

- (void)setImages:(NSArray *)images forState:(MJRefreshState)state
{
    [self setImages:images duration:images.count * 0.05 forState:state];
}


#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
//    self.label.frame = CGRectMake(0, 75, width, 15);

    self.gifView.frame=CGRectMake((width- 55.0f)/2, 10.0f, 55.0, 55.0f);
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{

//    CGPoint point = [change[@"new"] CGPointValue];
//    if (point.y > 10.0f) {
//        NSArray *images = self.stateImages[@(MJRefreshStateIdle)];
//        NSInteger index = point.y/10;
//        self.gifView.image = images[index > images.count ? images.count-1 : index-1];
//        [self.gifView stopAnimating];
//    }
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{

    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            
            self.label.text = @"下拉刷新";
            break;
        case MJRefreshStatePulling:
            
            self.label.text = @"释放刷新";
            break;
        case MJRefreshStateRefreshing:
            
            self.label.text = @"正在加载";
            
            break;
        default:
            break;
    }
    
    
    if ( state == MJRefreshStateRefreshing) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
    } else if (state == MJRefreshStateIdle) {
        
        [self.gifView stopAnimating];
        self.gifView.image = nil;
    }
    
}


#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    NSArray *images = self.stateImages[@(MJRefreshStateIdle)];
    if (self.state != MJRefreshStateIdle || images.count == 0) return;
    // 停止动画
    [self.gifView stopAnimating];
    // 设置当前需要显示的图片
    int index =  images.count * pullingPercent -3;

    if (index < 0) {
        return;
    }
    if (index >= images.count) index = (int)images.count-1;
    
    self.gifView.image = images[index];
}

@end
