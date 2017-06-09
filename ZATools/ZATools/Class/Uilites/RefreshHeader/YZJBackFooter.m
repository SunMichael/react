//
//  YZJBackFooter.m
//  WNRefreshTest
//
//  Created by 汪宁 on 16/8/24.
//  Copyright © 2016年 ZHENAI. All rights reserved.
//

#import "YZJBackFooter.h"

@interface YZJBackFooter ()
@property (weak, nonatomic) UILabel *label;
@property(weak,nonatomic)UIView *view;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end

@implementation YZJBackFooter

- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 100;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:0.81f green:0.81f blue:0.81f alpha:1.00f];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
     self.label = label;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
     CGFloat width=[UIScreen mainScreen].bounds.size.width;

    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 120)];
      self.view=view;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((width-80)/2, 20, 80, 60 )];
    imageView.image=[UIImage imageNamed:@"加载GIF_1.JPG"];
    imageView.backgroundColor=[UIColor clearColor];
    UILabel *subLabel=[[UILabel alloc]initWithFrame:CGRectMake((width-100)/2, 85, 100, 15)];
    subLabel.textAlignment=NSTextAlignmentCenter;
    //subLabel.textColor=UIColorFromRGB(0xd2d2d2);
    subLabel.font=[UIFont systemFontOfSize:11];
    subLabel.text=@"已经没有了";
    [self.view addSubview:imageView];
    [self.view addSubview:subLabel];
     [self addSubview:_view];
    _view.hidden=YES;

    
    
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    self.label.frame = CGRectMake(width*0.375, 10, width*0.25, 20);
    self.loading.center = CGPointMake(width*0.4-20, 20);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
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
            [self.loading stopAnimating];
          
            self.label.text = @"上拉加载";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
           
            self.label.text = @"释放加载";
            break;
        case MJRefreshStateRefreshing:
            [self.loading startAnimating];
           
            self.label.text = @"正在加载";
            break;
        case MJRefreshStateNoMoreData:
            [self.loading stopAnimating];
            [self.label removeFromSuperview];
            _view.hidden=NO;
            
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    
}



@end
