//
//  AdScrollView.m
//  yizhenjia
//
//  Created by mac on 2016/11/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AdScrollView.h"
#import "AdModel.h"
#import "BannerModel.h"
#import "UIImage+ColorToImage.h"
#import "WebViewController.h"


@implementation AdScrollView
{
    AdScrollPosition _copyPosition;
    NSArray *copyAry;
    NSInteger rollIndex;
    NSTimer *timer;
    NSInteger pageNumber;
}
-(instancetype)initWithFrame:(CGRect)frame andScrollPosition:(AdScrollPosition)position
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.pagingEnabled = YES;
        self.scrollEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.backgroundColor = kWhiteColor;
        _intervalTime = 4.0f;
        _copyPosition = position;
        rollIndex = 1;
        
    }
    
    return self;
}

- (void)updateAdScrollViewWithModelAry:(NSArray *)modelAry{
    pageNumber = modelAry.count;
    copyAry = modelAry;
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    switch (_copyPosition) {
            
        case AdScrollPositionHorizontal:        //水平方向 一般只有图片
        {
            if (modelAry.count == 0) {
                return;
            }
            for (UIView *view in self.subviews) {
                [view removeFromSuperview];
            }
            
            for (NSInteger i = 0; i < modelAry.count + 2; i++) {
                BannerModel *model;
                if (i == 0) {
                    model = [modelAry lastObject];
                }else if (i == modelAry.count + 1){
                    model = [modelAry objectAtIndex:0];
                }else{
                    model = modelAry[i - 1];
                }
                UIView *view = [self loadHorizontalViewsWithIndex:i andModel:model];
                view.userInteractionEnabled = YES;
                view.tag = i;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAdView:)];
                [view addGestureRecognizer:tap];
                [self addSubview:view];
            }
            [self setContentSize:CGSizeMake((modelAry.count +2) *self.width, self.height )];
            [self setContentOffset:CGPointMake(self.width, 0.0f)];
            if (!timer) {
                timer = [NSTimer scheduledTimerWithTimeInterval:_intervalTime target:self selector:@selector(rollingAdViews) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            }
        }
            break;
        case AdScrollPositionVertical:        //垂直方向
        {
            if (modelAry.count == 0) {
                return;
            }
            for (UIView *view in self.subviews) {
                [view removeFromSuperview];
            }
            
            for (NSInteger i = 0; i < modelAry.count + 2; i++) {
               
            }
            self.scrollEnabled = NO;
            [self setContentSize:CGSizeMake(self.width, (modelAry.count + 2) *self.height)];
            [self setContentOffset:CGPointMake(0.0f, self.height)];
            if (!timer) {
                timer = [NSTimer scheduledTimerWithTimeInterval:_intervalTime target:self selector:@selector(rollingAdViews) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            }
        }
            break;
            
        default:
            break;
    }
    
}
- (UIImageView *)loadHorizontalViewsWithIndex:(NSInteger)index andModel:(BannerModel *)model{
    UIImage *icon = GetImage(@"loadingchang");
    UIImageView *ivName = [[UIImageView alloc] initWithImage:icon];
    ivName.frame = CGRectMake(index *self.width, 0, self.width, self.height);
    __weak UIImageView *copyIv = ivName;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.img_url]];
    [ivName setImageWithURLRequest:request placeholderImage:icon success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        image = [UIImage imageWithCutImage:image moduleSize:CGSizeMake(ivName.width, ivName.height)];
        copyIv.image = image;
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
    
    return ivName;
}

- (void)rollingAdViews{
    rollIndex ++ ;
    if (rollIndex >= pageNumber + 2) {
        rollIndex = 1;
    }
    if (_copyPosition == AdScrollPositionVertical) {
        [self setContentOffset:CGPointMake(0.0f, self.height *rollIndex) animated:rollIndex == 1 ? NO :YES];
    }else{
        [self setContentOffset:CGPointMake(rollIndex *self.width, 0.0f) animated:rollIndex == 1 ? NO :YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //从n到n+1时设置偏移回第一张的时候，往左滑的时候设置回第n张
    if (_copyPosition == AdScrollPositionHorizontal) {
        if (scrollView.contentOffset.x == (pageNumber +1) * scrollView.frame.size.width ) {
            [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0.0f)];
        }else if (scrollView.contentOffset.x == 0.0f){
            [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * pageNumber, 0.0f)];
        }
        
    }else{
        //        if (scrollView.contentOffset.x == (pageNumber +1) * scrollView.frame.size.height ) {
        //            [scrollView setContentOffset:CGPointMake(0.0f, scrollView.height)];
        //        }else if (scrollView.contentOffset.x == 0.0f){
        //            [scrollView setContentOffset:CGPointMake(0.0f, scrollView.height * pageNumber) ];
        //        }
    }
}
@end
