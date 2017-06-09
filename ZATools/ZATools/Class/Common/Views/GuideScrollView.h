//
//  GuideScrollView.h
//  launch
//
//  Created by 汪宁 on 16/9/22.
//  Copyright © 2016年 ZHENAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideScrollView : UIScrollView


-(instancetype)initWithPageNum:(NSInteger)pageNum superView:(UIView *)view imageArray:(NSArray *)array;

@property(nonatomic, strong)void (^ exitBlock)();

@end
