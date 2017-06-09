//
//  TipView.m
//  yizhenjia
//
//  Created by mac on 16/8/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TipView.h"
#import "UIImage+ColorToImage.h"

@implementation TipView
{
    NSTimer *timer;
    void(^confirmBlock)();      //点击确定  或者 dismiss 触发
    NSInteger copyType;

}
- (instancetype)initWithType:(TipViewType)type andTitle:(NSString *)title subTitle:(NSString *)subTitle withConfirmTitle:(NSString *)confirm icon:(UIImage *)icon tipString:(NSString *)tipStr andSubContent:(NSString *)subcont{
    self = [super initWithFrame:CGRectMake(0.f, 0.0f, kScreenWidth, kScreenHeight)];
    if (self) {
        
        copyType = type;
        
        UIView *avatorView = [[UIView alloc] initWithFrame:self.bounds];
        avatorView.backgroundColor = [UIColor blackColor];
        avatorView.alpha = 0.3f;
        [self addSubview:avatorView];
        
        float w = 290.0f;
        float y = self.height/2- 100.0f;
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - w/2, y, w, 200.0f)];
        whiteView.layer.cornerRadius = 5.0f;
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        
        float offx = 30.0f;
        float offy = 35.0f;
        float bw = 170.0f;
        IvyLabel *titleLab = [[IvyLabel alloc] initWithFrame:CGRectMake(offx,  offy, whiteView.width - 2* offx, 16.0f) text:title font:GetFont(16.0f) textColor:kGrayColor textAlignment:NSTextAlignmentCenter numberLines:0];
        
        IvyLabel *subTitleLab = [[IvyLabel alloc] initWithFrame:CGRectMake(offx,  titleLab.y + titleLab.height + 20.0f,titleLab.width, 16.0f) text:subTitle font:GetFont(16.0f) textColor:kGrayColor textAlignment:NSTextAlignmentCenter numberLines:0];
        
        switch (type) {
            case TipViewTypeClose:
            {
                UIImage *close = GetImage(@"ic_exit");
                UIImageView *closerIv = [[UIImageView alloc] initWithImage:close];
                closerIv.frame = CGRectMake(whiteView.width/2 - close.size.width/2, whiteView.y + whiteView.height + close.size.height/2, close.size.width, close.size.height);
                
                IvyButton *closeBtn = [[IvyButton alloc] initWithFrame:CGRectMake(whiteView.width/2 - close.size.width/2 + whiteView.x, whiteView.y + whiteView.height - close.size.height/2, close.size.width, close.size.height) titleStr:@"" titleColor:[UIColor whiteColor] font:GetFont(14.0f) logoImg:nil backgroundImg:close];
                [closeBtn addTarget:self action:@selector(clickedClose) forControlEvents:UIControlEventTouchUpInside];
                closeBtn.clipsToBounds = YES;
                closeBtn.layer.cornerRadius = closeBtn.height/2;
                [self addSubview:closeBtn];
                
                [titleLab sizeToFit];
                titleLab.frame = CGRectMake(offx,  offy, whiteView.width - 2* offx, titleLab.height);
                subTitleLab.frame = CGRectMake(offx,  titleLab.y + titleLab.height + 20.0f,titleLab.width, 16.0f);
                
                [whiteView addSubview:titleLab];
                [whiteView addSubview:subTitleLab];
                
                IvyButton *button = [[IvyButton alloc] initWithFrame:CGRectMake(whiteView.width/2 - bw/2, subTitleLab.height + subTitleLab.y + 20.0f, bw, 40.0f) titleStr:confirm titleColor:[UIColor whiteColor] font:GetFont(14.0f) logoImg:nil backgroundImg:[UIImage createImageWithColor:kPinkColor]];
                [button addTarget:self action:@selector(clickedConfirm) forControlEvents:UIControlEventTouchUpInside];
                button.clipsToBounds = YES;
                button.layer.cornerRadius = button.height/2;
                [whiteView addSubview:button];

            }
                break;
            case TipViewTypeIcon:
            {

                UIImageView *headerIv = [[UIImageView alloc] initWithImage:icon];
                headerIv.frame = CGRectMake(whiteView.width/2 - icon.size.width/2, 30.0f, icon.size.width, icon.size.height);
                [whiteView addSubview:headerIv];
                
                IvyLabel *tipLab = [[IvyLabel alloc] initWithFrame:CGRectMake(offx,  headerIv.y + headerIv.height + 20.0f, whiteView.width - 2* offx, 16.0f) text:tipStr font:GetFont(16.0f) textColor:kGrayColor textAlignment:NSTextAlignmentCenter numberLines:0];
                [whiteView addSubview:tipLab];
                
                IvyLabel *contentLab = [[IvyLabel alloc] initWithFrame:CGRectMake(offx,  tipLab.y + tipLab.height + 20.0f, tipLab.width, 16.0f) text:subcont font:GetFont(16.0f) textColor:kGrayColor textAlignment:NSTextAlignmentCenter numberLines:0];
                [whiteView addSubview:contentLab];

                
            }
                break;
            case TipViewTypeSingle:
            {
                [whiteView addSubview:titleLab];
                [whiteView addSubview:subTitleLab];
                
                IvyButton *button = [[IvyButton alloc] initWithFrame:CGRectMake(whiteView.width/2 - bw/2, subTitleLab.height + subTitleLab.y + 20.0f, bw, 40.0f) titleStr:confirm titleColor:[UIColor whiteColor] font:GetFont(14.0f) logoImg:nil backgroundImg:[UIImage createImageWithColor:kPinkColor]];
                [button addTarget:self action:@selector(clickedConfirm) forControlEvents:UIControlEventTouchUpInside];
                button.clipsToBounds = YES;
                button.layer.cornerRadius = button.height/2;
                [whiteView addSubview:button];
                
            }
                break;
            default:
                break;
        }
        
        self.alpha = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}
/**
 *  点击确定
 *
 *  @param confirm
 */
-(void)showTipViewWithConfirmBlock:(void (^)(void))confirm{
    
    confirmBlock = [confirm copy];
    if (copyType == TipViewTypeIcon) {
        [self addTimer];
    }
    [self doAnimationView];
}
- (void)addTimer{
    //自动消失
    timer = [NSTimer timerWithTimeInterval:1.5f target:self selector:@selector(timerDismiss) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timerDismiss{
    timer = nil;
    [timer invalidate];
    confirmBlock();
    [self doAnimationView];
}
/**
 *  关闭按钮
 */
- (void)clickedClose{
    [self doAnimationView];
}
/**
 *  确认按钮
 */
- (void)clickedConfirm{
    confirmBlock();
    [self doAnimationView];
}

- (void)doAnimationView{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 1.0f - self.alpha;
        
    } completion:^(BOOL finished) {
        if (self.alpha == 0.0f) {
            [self removeFromSuperview];
        }else{
            if (!self.superview) {
             [[UIApplication sharedApplication].keyWindow addSubview:self];
            }
        }
    }];
}

@end
