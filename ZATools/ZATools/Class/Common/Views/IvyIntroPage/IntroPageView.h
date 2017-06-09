//
//  IntroPage.h
//  Ivy
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IntroViewFinish)();

@interface IntroPageView : UIView <UIScrollViewDelegate>

@property(nonatomic, retain) UIScrollView *scrollView;
@property(nonatomic, retain) NSArray *pages;
@property(nonatomic, retain) UIPageControl *pageControl;
@property(nonatomic, assign) CGFloat pageControlY;
@property(nonatomic, assign) NSInteger currentPage;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray andFinished:(IntroViewFinish)finish;

@end
