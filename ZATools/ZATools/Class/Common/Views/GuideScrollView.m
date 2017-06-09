//
//  GuideScrollView.m
//  launch
//
//  Created by 汪宁 on 16/9/22.
//  Copyright © 2016年 ZHENAI. All rights reserved.
//

#import "GuideScrollView.h"
#import "UIImage+ColorToImage.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface GuideScrollView ()<UIScrollViewDelegate>

@property(nonatomic,assign)NSInteger          pageNum;
@property(nonatomic,strong)UIPageControl     *pageControl;
@property(nonatomic,strong)IvyButton *button;
@end
@implementation GuideScrollView

-(instancetype)initWithPageNum:(NSInteger)pageNum superView:(UIView *)view imageArray:(NSArray *)array
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight)];
    if (self) {
        self.contentSize=CGSizeMake(kScreenWidth*pageNum, kScreenHeight);
        self.showsHorizontalScrollIndicator=NO;
        self.pagingEnabled=YES;
        self.bounces=NO;
        _pageNum=pageNum;
        self.delegate=self;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor whiteColor];
        for (int i=0; i<_pageNum; ++i) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
            if (array.count>i) {
                UIImage *image=[UIImage imageNamed:[array objectAtIndex:i]];
                imageView.image=image;
            }
            
            [self addSubview:imageView];
        }
        
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((kScreenWidth-20*pageNum)/2, kScreenHeight - 40.0f, 20*pageNum, 20)];
        _pageControl.backgroundColor=[UIColor clearColor];
        _pageControl.numberOfPages=pageNum;
        _pageControl.currentPage=0;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.99f green:0.67f blue:0.61f alpha:1.00f];
        _pageControl.currentPageIndicatorTintColor = kRedColor;
        [view addSubview:self];
        [view addSubview:_pageControl];
        
        _button = [[IvyButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 170.0f/2 + (pageNum -1)*kScreenWidth , kScreenHeight - 45.0f - 80.0f, 170.0f, 45.0f) titleStr:@"立即体验" titleColor:kWhiteColor font:GetFont(18.0f) logoImg:nil backgroundImg:[UIImage createImageWithColor:kRedColor]];
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = 5.0f;

        [_button addTarget:self action:@selector(exitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];

    }
    return self;
}

-(UIImageView *)gifShow
{
    
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-200)/2, kScreenHeight*0.9-60,200, 53)];
    NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"1"],
                         [UIImage imageNamed:@"2"],
                         [UIImage imageNamed:@"3"],
                         [UIImage imageNamed:@"4"],
                         [UIImage imageNamed:@"5"],
                         [UIImage imageNamed:@"6"],
                         [UIImage imageNamed:@"7"],
                         [UIImage imageNamed:@"8"],
                         [UIImage imageNamed:@"9"],
                         [UIImage imageNamed:@"10"],
                         [UIImage imageNamed:@"11"],
                         [UIImage imageNamed:@"12"],
                         [UIImage imageNamed:@"13"],
                         [UIImage imageNamed:@"14"],
                         nil];
    gifImageView.animationImages = gifArray; //动画图片数组
    gifImageView.animationDuration = 2; //执行一次完整动画所需的时长
    gifImageView.animationRepeatCount = 0;  //动画重复次数
    [gifImageView startAnimating];
    return gifImageView;
}

- (void)exitButtonClicked{
    [self goEnter];
}
-(void)goEnter{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.exitBlock();
        self.alpha = 0.0f;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_pageControl removeFromSuperview];
    }];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //CGFloat xOffset=scrollView.contentOffset.x;
    
    NSInteger currentPage=(NSInteger)scrollView.contentOffset.x/kScreenWidth;
    
    _pageControl.currentPage=currentPage;
    
}




@end
