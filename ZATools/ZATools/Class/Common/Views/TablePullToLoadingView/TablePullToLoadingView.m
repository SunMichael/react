//
//  TablePullToLoadingView.m
//  91TaoJin
//
//  Created by keyrun on 14-5-26.
//  Copyright (c) 2014年 guomob. All rights reserved.
//

#import "TablePullToLoadingView.h"

@implementation TablePullToLoadingView

- (id)init{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, 30.0f)];
    if (self) {
        UIImageView *_animation = [[UIImageView alloc] init];
        CGSize imgSize = [UIImage imageNamed:@"loadingView1.png"].size;
        _animation.frame = CGRectMake(kScreenWidth/2 - imgSize.width/4, self.frame.size.height/2 - imgSize.height/4, imgSize.width/2, imgSize.height/2);
        NSMutableArray *arrayImage = [[NSMutableArray alloc] init];
        for (int i = 1; i < 9; i ++) {
            UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"loadingView%d.png",i]];
            [arrayImage addObject:image];
        }
        _animation.animationImages = arrayImage;
        _animation.animationDuration = 0.8;
        [self addSubview:_animation];
        [_animation startAnimating];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *_animation = [[UIImageView alloc] init];
        CGSize imgSize = [UIImage imageNamed:@"loadingView1.png"].size;
        _animation.frame = CGRectMake(kScreenWidth/2 - imgSize.width/4, frame.size.height/2 - imgSize.height/4, imgSize.width/2, imgSize.height/2);
        NSMutableArray *arrayImage = [[NSMutableArray alloc] init];
        for (int i = 1; i < 9; i ++) {
            UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"loadingView%d.png",i]];
            [arrayImage addObject:image];
        }
        _animation.animationImages = arrayImage;
        _animation.animationDuration = 0.8;
        [self addSubview:_animation];
        [_animation startAnimating];
    }
    return self;
}

@end
