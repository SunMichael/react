//
//  IntroPage.m
//  Ivy
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "IntroPageView.h"
#import "IntroPage.h"
#import "IvyButton.h"
@implementation IntroPageView
{
    NSMutableArray *_pageViews;
    IntroViewFinish _copyBlock;
    
}
- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray andFinished:(IntroViewFinish)finish{
    self = [super initWithFrame:frame];
    if (self) {
        self.pageControlY = 40.0f;
        _copyBlock = [finish copy];
        _pageViews = [NSMutableArray array];
        _pages = [pagesArray copy];
        [self buildScrollViewWithFrame:frame];
        [self buildFooterView];
    }
    
    return self;
}

- (void)buildScrollViewWithFrame:(CGRect)frame{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
//    _scrollView.bounces = NO;
    _scrollView.backgroundColor = GetColorBy(192.0f, 243.0f, 255.0f);
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    for (int i =0; i< _pages.count; i++) {
        [_pageViews addObject:[self viewForPage:_pages[i] andOffx:i*_scrollView.frame.size.width]];
        
        if (i == _pages.count -1) {
            
            /*
            IvyButton *btn = [[IvyButton alloc] initWithFrame:CGRectMake(60, kScreenHeight - 95, kScreenWidth - 120, 40) titleStr:@"立即开启" titleColor:GetColorBy(27, 157, 239) font:[UIFont systemFontOfSize:16.0f] logoImg:nil backgroundImg:nil];
            btn.layer.cornerRadius = btn.frame.size.height / 2;
            btn.layer.masksToBounds = YES;
            btn.layer.borderColor = GetColorBy(27, 157, 239).CGColor;
            btn.layer.borderWidth = 1.0;
             */
            IvyButton *btn = [[IvyButton alloc] initWithFrame:CGRectMake(20, kScreenHeight - 100, kScreenWidth - 40, 80) titleStr:nil titleColor:GetColorBy(27, 157, 239) font:[UIFont systemFontOfSize:16.0f] logoImg:nil backgroundImg:nil];
            
            UIView *view = _pageViews[_pages.count -1];
            [btn addTarget:self action:@selector(skipIntroPage) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
        }
        
        [_scrollView addSubview:_pageViews[i]];
    }
    
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width * _pages.count, self.frame.size.height)];
    [self addSubview:_scrollView];
    
}

- (UIView *)viewForPage:(IntroPage *)page andOffx:(CGFloat)offx{
    UIView *pageView = [[UIView alloc] initWithFrame:CGRectMake(offx, 0.0f, self.frame.size.width, self.frame.size.height)];
    pageView.backgroundColor = [UIColor orangeColor];
    if (page.bgImage) {
        UIImageView *bgImage = [[UIImageView alloc] initWithImage:page.bgImage];
        bgImage.frame = CGRectMake(0.0f, 0.0f, pageView.frame.size.width, pageView.frame.size.height);
        [pageView addSubview:bgImage];
    }
    
    return pageView;
}

- (void)buildFooterView{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - self.pageControlY, self.frame.size.width, 20)];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.pageControl addTarget:self action:@selector(showPanelAtPageControl) forControlEvents:UIControlEventValueChanged];
    self.pageControl.numberOfPages = _pages.count;
    [self addSubview:self.pageControl];

}
-(void) skipIntroPage{
    _copyBlock();
}
- (void)showPanelAtPageControl{
    _currentPage = _pageControl.currentPage;
    [_scrollView setContentOffset:CGPointMake(_currentPage * self.frame.size.width, 0.0f) animated:YES];
}

- (void)hideWithFadeOutDuration:(CGFloat)duration {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - UIScrollView delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _currentPage = scrollView.contentOffset.x / _scrollView.frame.size.width;
    
    if (_currentPage == _pageViews.count) {
        _copyBlock();
        [self hideWithFadeOutDuration:0.3];
    }
    _pageControl.currentPage = _currentPage;
}
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    float offset = scrollView.contentOffset.x;
    if (offset > (_pageViews.count -1) * scrollView.frame.size.width + 50.0f) {
        self.alpha = 0.0f;
        _copyBlock();
    }
}
@end
