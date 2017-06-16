//
//  UserHeaderView.m
//  yizhenjia
//
//  Created by mac on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UserHeaderView.h"
#import "UIImage+ColorToImage.h"
#import "DateController.h"

@implementation UserHeaderView
{
    UIImageView *headIv;
    IvyLabel *nameLab;
    IvyLabel *dateLab;
    NSMutableArray *allTipAry;
    UIImage *head;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        allTipAry = [NSMutableArray array];
        [self initBaseViews];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHeaderView:) name:RELOADUSERINFOR object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initBaseViews) name:RELOADUSERSTATUS object:nil];
    }
    return self;
}


- (void)initBaseViews{
    UIImage *icon = GetImage(@"headerbj");
    UIImageView *bgIv = [[UIImageView alloc] initWithImage:icon];
    bgIv.frame = CGRectMake(0.0f, 0.0f, self.width, 220.0f);
    [self addSubview:bgIv];
    
    UIImage *message = GetImage(@"xiaoxi");
    UIButton *msgIv = [UIButton buttonWithType:UIButtonTypeCustom];
    msgIv.frame = CGRectMake(self.width - message.size.width - 10.0f, 40.0f, 25.0f, 25.0f);
    [msgIv setImage:message forState:UIControlStateNormal];

//    [self addSubview:msgIv];
    msgIv.hidden = YES;       //V2.0 暂时没有消息
    
    head = GetImage(@"touxiang");
    headIv = [[UIImageView alloc] initWithImage:head];
    headIv.frame = CGRectMake(self.width/2 - 75.0f/2, 60.0f, 75.0f, 75.0f);
    headIv.layer.masksToBounds = YES;
    headIv.layer.cornerRadius = headIv.height/2;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, headIv.width, headIv.height);
    button.frame = headIv.frame;
//    [button addTarget:self action:@selector(editUserInfor) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:headIv];
//    [self addSubview:button];
    
    
    if ([[[IvyUserDefaults shareUserDefaults] getUserId] isEqualToString:kYOUKEID]) {
        float w =  100.f;
        IvyButton *loginBtn = [[IvyButton alloc] initWithFrame:CGRectMake(self.width/2 -w/2, headIv.y + headIv.height + 10.f, w, 35.0f) titleStr:@"点击登录" titleColor:kWhiteColor font:GetFont(15.0f) logoImg:nil backgroundImg:[UIImage createImageWithColor:kPinkColor]];
        [loginBtn addTarget:self action:@selector(clickedLogin) forControlEvents:UIControlEventTouchUpInside];
        loginBtn.layer.cornerRadius = loginBtn.height/2;
        loginBtn.layer.borderColor = kWhiteColor.CGColor;
        loginBtn.layer.masksToBounds = YES;
        loginBtn.layer.borderWidth = 1.0f;
        [self addSubview:loginBtn];
        
    }else{
        
       
    }
    
}

- (void)clickedLogin{
    DateController *date = [[DateController alloc]initWithType:DateSettingTypeCalculation];
    [RootNavController pushViewController:date animated:YES];
}

-(void)updateHeaderView:(NSNotification *)notic{
    NSDictionary *dic = notic.userInfo;
    if ([dic[@"type"] isEqualToString:@"1"]) {
        Account *account = [[IvyUserDefaults shareUserDefaults] getUserInfor];
        [self updateStatusText:account];
    }else{
        UIImage *image = [[IvyUserDefaults shareUserDefaults] getPhoto];
        if (image) {
           headIv.image = [UIImage imageWithCutImage:image moduleSize:CGSizeMake(headIv.width, headIv.height)];
        }
    }
    
}



@end
