//
//  SNInfiniteScrollView.h
//  day7_tabableView_tg&wb
//
//  Created by stone on 16/3/9.
//  Copyright © 2016年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ScrollDirection) {
    ScrollDirectionVertical,
    ScrollDirectionHorizontal,
};

@interface SNInfiniteScrollView : UIView
@property(nonatomic, strong) NSArray<UIImage *> * images;
@property(nonatomic, weak) UIPageControl * pageControl;
@property(nonatomic, assign) ScrollDirection scrollDirection;
/** imageViewcontentMode */
@property(nonatomic, assign) UIViewContentMode imageViewcontentMode;
/** 简单调用 */
+ (instancetype)scrollViewWithFrame:(CGRect)frame superView:(UIView *)superView images:(NSArray<UIImage *> *)images scrollDirection:(ScrollDirection)scrollDirection pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor  imageViewcontentMode:(UIViewContentMode)imageViewcontentMode;

@end
