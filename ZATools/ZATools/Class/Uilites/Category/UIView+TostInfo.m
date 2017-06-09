//
//  UIView+TostInfo.m
//  yizhenjia
//
//  Created by 汪宁 on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIView+TostInfo.h"
#import "LoadingViewController.h"
#define NoDataTag 10026

@implementation UIView (TostInfo)
UITapGestureRecognizer *tap;
UINavigationController *nc;
 UIView *view ;

- (void)showInfo:(NSString *)info autoHidden:(BOOL)autoHide
{
 
    if ([NSString isEmply:info]) {
        return;
    }
    nc = RootNavController;
    NSLog(@"  ---- %d ",[nc isKindOfClass:[UINavigationController class]]);
    
    if (![nc isKindOfClass:[UINavigationController class]]) {
        view = self;
    }else{
        nc = RootNavController;
        view = nc.topViewController.view;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.tag=1288;
    [view addSubview:hud];
    [hud showAnimated:YES];
    
    
    if (autoHide) {
        //[hud hide:YES afterDelay:(seconds > 0 ? seconds : 1.5)];
        [self performSelector:@selector(removeHUD) withObject:nil afterDelay:1.5];
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabel.font = hud.label.font;
    hud.detailsLabel.text = info;
    hud.detailsLabel.textColor = kWhiteColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    self.userInteractionEnabled=YES;
    tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeHUD)];
    [hud addGestureRecognizer:tap];
    
}
- (void)showInfo:(NSString *)info autoHidden:(BOOL)autoHide interval:(NSUInteger)seconds
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.removeFromSuperViewOnHide = YES;
    hud.tag=1288;
    [self addSubview:hud];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabel.font = hud.label.font;
    hud.detailsLabel.text = info;
    [hud showAnimated:YES];
    if (autoHide) {
        //[hud hide:YES afterDelay:(seconds > 0 ? seconds : 1.5)];
        [self performSelector:@selector(removeHUD) withObject:nil afterDelay:(seconds > 0 ? seconds : 1.5)];
    }
    
    self.userInteractionEnabled=YES;
    tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeHUD)];
    [self addGestureRecognizer:tap];
  
}
-(void)removeHUD
{
    
    MBProgressHUD *hud = (MBProgressHUD*) [view viewWithTag:1288];
    if (hud) {
        [hud removeFromSuperview];
        NSLog(@"remove HUD");
        [self removeGestureRecognizer:tap];
    }
    
}

-(void)bringHUDToFront {
    MBProgressHUD *hud = (MBProgressHUD*) [view viewWithTag:1288];
    if (hud) {
        [self bringSubviewToFront:hud];
    }
}

-(void)addNoDataView:(NSString *)text image:(UIImage *)image
{
    [self addNoDataViewFrame:CGRectMake(0, kScreenHeight*0.28, kScreenWidth, 100) text:text image:image];
}

-(void)addNoDataViewFrame:(CGRect)frame text:(NSString *)text image:(UIImage *)image
{
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.tag = NoDataTag;

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-image.size.width)/2, 0.0f, image.size.width, image.size.height)];
    imageView.image = image == nil ? [UIImage imageNamed:@"GIF3.png"] :image;
    [view addSubview:imageView];
    
    UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake( 10.0f , 25.0f +imageView.y + imageView.height, kScreenWidth - 20.0f, 20)];
    textLabel.textColor = UIColorFromRGB(0x8f8f8f);
    textLabel.font = [UIFont systemFontOfSize:15.0f];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = text;
    [view addSubview:textLabel];
    
    [self addSubview:view];
    
    
}

-(BOOL)noDataViewIsNil{
    return [self viewWithTag:NoDataTag] == nil ? YES : NO;
}

//  如果如果loadView的页面是在一个自己建立的View里面的话

-(void)addFailLoadView:(CGRect)frame
{
    
    UIView *view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=AllBgColor;
     view.tag=NoDataTag;
    CGFloat height=frame.size.height;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-60)/2, height*0.25, 60, 50)];
    imageView.image=[UIImage imageNamed:@"GIF3.png"];
    [view addSubview:imageView];
    
    
    
    UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,height*0.25+60 , kScreenWidth, 20)];
    textLabel.textColor=UIColorFromRGB(0xcccccc);
    textLabel.font=[UIFont systemFontOfSize:15];
    textLabel.textAlignment=NSTextAlignmentCenter;
    textLabel.text=@"网络加载失败啦";
    [view addSubview:textLabel];
    
   UIButton *  loadButton=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.3, height*0.25+95, kScreenWidth*0.4, 30)];
    [loadButton setTitleColor:UIColorFromRGB(0xcccccc) forState:UIControlStateNormal];
    loadButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [loadButton setTitle:@"点击重新加载" forState:UIControlStateNormal];
    loadButton.layer.borderWidth=0.5;
    loadButton.layer.borderColor=UIColorFromRGB(0xcccccc).CGColor;
    loadButton.layer.cornerRadius=5;
    
   //  self.superController
    [loadButton addTarget:self action:@selector(failAndReload) forControlEvents:UIControlEventTouchUpInside];
   
    [view addSubview:loadButton];

    view.tag=NoDataTag;
    [self addSubview:view];
    
    
}
-(void)removeNoDataView
{
    UIView *view=(UIView *)[self viewWithTag:NoDataTag];
    [view removeFromSuperview];
}

-(void)failAndReload
{
    
    [self removeNoDataView];
    
    
}




@end
