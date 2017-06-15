//
//  LogoutView.m
//  yizhenjia
//
//  Created by 汪宁 on 16/9/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LogoutView.h"
@interface LogoutView ()
@property(nonatomic, strong)UIView *bgView;


@property(nonatomic,assign)CGFloat popViewHeight;
@end

@implementation LogoutView

-(id)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
       
        _popViewHeight=45*2+60+10;
        [self createsubView];
        
    }
    return self;
}
-(void)createsubView{
    
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, kScreenWidth, _popViewHeight)];
    _bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_bgView];
    NSArray *titleArray;
    titleArray=@[@"退出登录",@"取消"];
    
    UILabel *desLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth *0.1, 10, kScreenWidth*0.8, 40)];
    desLabel.backgroundColor=[UIColor whiteColor];
    desLabel.numberOfLines=2;
    desLabel.text=@"退出后不会删除任何历史记录，下次登录依然可以使用本账号";
    desLabel.textAlignment=NSTextAlignmentCenter;
    desLabel.font=[UIFont systemFontOfSize:13];
    desLabel.textColor=UIColorFromRGB(0x999999);
    [_bgView addSubview:desLabel];
    
    
    for (int i=0; i<2; ++i) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 60+55*i, kScreenWidth, 45)];
        button.backgroundColor=[UIColor whiteColor];
        [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        button.tag=1004+i;
        button.titleLabel.font=[UIFont systemFontOfSize:17];
        [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:button];
        
        if (i==0) {
            [button setTitleColor:UIColorFromRGB(0xff8787) forState:UIControlStateNormal];
        }
    }
    
    UIImageView *wideImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 60+45, kScreenWidth, 10)];
    wideImageView.backgroundColor=AllBgColor;
    [_bgView addSubview:wideImageView];
    
    UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 60-0.5, kScreenWidth, 0.5)];
    lineImageView.backgroundColor=[UIColor colorWithRed:0.93f green:0.93f blue:0.94f alpha:1.00f];
    [_bgView addSubview:lineImageView];
  
    
}


-(void)showLogoutView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        _bgView.frame=CGRectMake(0, kScreenHeight-_bgView.bounds.size.height, kScreenWidth, _popViewHeight);
        
    }completion:^(BOOL finished) {
        
    }];
    
}
-(void)select:(UIButton *)button{
    
    if (button.tag==1005) {

    }else
    {
       
            self.logOut();
      
 
    }
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _bgView.frame=CGRectMake(0, self.bounds.size.height, kScreenWidth, _popViewHeight);
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
        
        _bgView.frame=CGRectMake(0, self.bounds.size.height, kScreenWidth, _popViewHeight);
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


@end
