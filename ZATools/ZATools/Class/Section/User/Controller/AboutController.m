//
//  AboutController.m
//  yizhenjia
//
//  Created by 汪宁 on 16/8/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AboutController.h"
@interface AboutController ()<UIWebViewDelegate>
@property(nonatomic, strong)UIWebView *webView;

@end
@implementation AboutController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.94f green:0.94f blue:0.95f alpha:1.00f];
    [self loadBaseViewContent];
    [self createWebView];
    
    
}
-(void)loadBaseViewContent{
    
    IvyHeaderBar *header = [[IvyHeaderBar alloc] initWithTitle:@"关于我们" leftBtnTitle:nil leftBtnImg:[UIImage imageNamed:@"Icon_back"] leftBtnHighlightedImg:nil rightBtnTitle:nil rightBtnImg:nil rightBtnHighlightedImg:nil backgroundColor:[UIColor whiteColor]];
    [header.leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:header];
    
}
-(void)back{
    
    [RootNavController popViewControllerAnimated:YES];
    
}

-(void)createWebView
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/3, kScreenHeight*0.32, kScreenWidth/3, kScreenWidth/3)];
    imageView.image=[UIImage imageNamed:@"180.png"];
    imageView.layer.masksToBounds=YES;
    imageView.layer.cornerRadius=5;
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+15, kScreenWidth, 15)];
    label.text=@"亦蓁家";
    label.textColor=UIColorFromRGB(0x666666);
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    
     NSString* currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    UILabel *versionLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+5, kScreenWidth, 15)];
    versionLabel.text=currentVersion;
    versionLabel.textColor=UIColorFromRGB(0x666666);
    versionLabel.textAlignment=NSTextAlignmentCenter;
    versionLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:versionLabel];
    
    [self.view addSubview:imageView];
    
    
    
    UILabel *cTextlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 20)];
    cTextlabel.text=@"上海亦蓁网络科技有限公司";
    cTextlabel.textColor=UIColorFromRGB(0x666666);
    cTextlabel.textAlignment=NSTextAlignmentCenter;
    cTextlabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:cTextlabel];
    

    
    UILabel *eTextlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-30, kScreenWidth, 20)];
    eTextlabel.text=@"Copyright © 2017 Zhenai. All Rights Reserved";
    eTextlabel.textColor=UIColorFromRGB(0x999999);
    eTextlabel.textAlignment=NSTextAlignmentCenter;
    eTextlabel.font=[UIFont systemFontOfSize:11];
    [self.view addSubview:eTextlabel];

}







@end
