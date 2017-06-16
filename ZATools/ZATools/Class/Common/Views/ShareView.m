//
//  ShareView.m
//  yizhenjia
//
//  Created by 汪宁 on 16/8/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShareView.h"

#import <UMSocialCore/UMSocialCore.h>


@interface ShareView ()

@property(nonatomic, strong)UIView *subShareView;
@property(nonatomic, assign)ShareType shareType;
@end

@implementation ShareView
-(id)initWithFrame:(CGRect)frame shareType:(ShareType)shareType;
{
    if (self==[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.shareType=shareType;
        [self createsubView];
        
    }
    return self;
}
-(void)createsubView{
    
    _subShareView=[[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, kScreenWidth, 200)];
    _subShareView.backgroundColor= kWhiteColor;
    
    IvyLabel *tipLab = [[IvyLabel alloc] initWithFrame:CGRectMake(0, 20.f, self.width, 16) text:@"分享到" font:GetFont(16.f) textColor:kBlackColor textAlignment:NSTextAlignmentCenter numberLines:1];
    [_subShareView addSubview:tipLab];
    
    NSArray *imageArray=@[@"wechat",@"friend"];
    NSArray *titleArray=@[@"微信好友",@"微信朋友圈"];
    for (int i=0; i<2; ++i) {
        
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-120)/3+((kScreenWidth-120)/3+60)*i, 55, 60, 60)];
        button.tag=1013+i;
        [button addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [_subShareView addSubview:button];
        
        [button setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]] forState:UIControlStateNormal];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-120)/3+((kScreenWidth-120)/3+60)*i-20, CGRectGetMaxY(button.frame) + 10.f, 100, 15)];
        label.font=[UIFont systemFontOfSize:13];
        label.textColor=UIColorFromRGB(0x999999);
        label.textAlignment=NSTextAlignmentCenter;
        label.text=[titleArray objectAtIndex:i];
        [_subShareView addSubview:label];
        
    }
    CALayer *line = [CALayer layer];
    line.backgroundColor = kBackViewColor.CGColor;
    line.frame = CGRectMake(0.0f, 155.f, kScreenWidth, 0.5f);
    [_subShareView.layer addSublayer:line];

    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 156, kScreenWidth , 45)];
    button.backgroundColor= kWhiteColor;
    [button setTitleColor:kBlackColor forState:UIControlStateNormal];
    
    button.titleLabel.font=[UIFont systemFontOfSize:17];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_subShareView addSubview:button];
    
    [self addSubview:_subShareView];
    
}

-(void)showShareView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    float h = _subShareView.y == self.bounds.size.height ? kScreenHeight-_subShareView.bounds.size.height : self.bounds.size.height;
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        
        _subShareView.frame=CGRectMake(0, h, kScreenWidth, 200);
        
    }completion:^(BOOL finished) {
        
    }];
    
}
-(void)share:(UIButton *)button
{
    if (self.shareType==shareFound) {
        [self shareFound:button.tag];
    }else if (self.shareType==shareApp)
    {

    }
    
}

-(void)shareFound:(NSInteger)tag
{
    
   /*
    [UMSocialData defaultData].extConfig.title = @"亦蓁家";
    NSString*str= _model ?  _model.title :@"最新资讯";
    NSString *url = _model ? _model.infoDetailsUrl : @"";
    
    str = [NSString isEmply:_title] ? @"亦蓁家" : _title;
    url = [NSString isEmply:_inforUrl] ? @"" : _inforUrl;
    
    */
    
    NSString*str= self.title ?  self.title :@"亦蓁家";
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString *urlString = _thumUrl;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
    UIImage *image = [UIImage imageWithData:data];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:str descr:_subTitle thumImage:image];
    //设置网页地址
    shareObject.webpageUrl = _inforUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    
    if (tag==1013) {
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            [self cancel];
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    [_shareDelegate shareSuccess:YES];
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }

        }];

        
        
    }else
    { 
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            [self cancel];
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    [_shareDelegate shareSuccess:YES];
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            
        }];
        
        
    }
    
    
}

-(void)cancel
{
    [UIView animateWithDuration:0.5 animations:^{
        
        _subShareView.frame=CGRectMake(0, kScreenHeight, kScreenWidth, 200);
        
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.5 animations:^{
        
        _subShareView.frame=CGRectMake(0, self.bounds.size.height, kScreenWidth, 200);
        
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}
@end
