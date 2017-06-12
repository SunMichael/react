//
//  LoginController.m
//  yizhenjia
//
//  Created by 汪宁 on 16/8/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LoginController.h"
#import "LoadingViewController.h"
#import "AppDelegate.h"
#import "YzjTabbarController.h"
#import "YzjNavigationController.h"
#import "UIImage+ColorToImage.h"
#import "NetworkServiceConfig.h"
#import "AccountService.h"
#import "WXApi.h"
#import "WXApiManager.h"

@interface LoginController ()<UITextFieldDelegate ,UIAlertViewDelegate ,WXApiManagerDelegate>
{
    UIColor *redcolor;
    UIColor *graycolor;
    UIColor *btnGarycolor;
}
@property (nonatomic, strong)UIImageView*     logoImageView;
@property (nonatomic, strong)UILabel*         titleLabel;
@property (nonatomic, strong)UIView*          bgView;
@property (nonatomic, strong)UITextField*     numberTextField;
@property (nonatomic, strong)UITextField*     passwordTextField;
@property (nonatomic, strong)UIButton*        getCodeButton;
@property (nonatomic, strong)UIButton*        loginButton;
@property (nonatomic, strong)NSTimer*         timer;
@property (nonatomic, strong)AccountService   *accountService;
@property (nonatomic, copy)NSString   *code;
@property (nonatomic, strong)UIButton*        protocalButton;

@end

@implementation LoginController
static int second=60;

-(NSString *)backTitle{
    return @"我的";
}

- (NSString *)title{
    return @"登录";
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40.f)];
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLab.text = @"我的登录";

    self.navigationItem.titleView = titleLab;
    
    _accountService=[AccountService shareInstance];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor=[UIColor whiteColor];
    
    graycolor = [UIColor colorWithRed:0.77f green:0.78f blue:0.78f alpha:1.00f];
    redcolor = [UIColor colorWithRed:0.98f green:0.35f blue:0.38f alpha:1.00f];
    btnGarycolor = [UIColor colorWithRed:1.00f green:0.58f blue:0.60f alpha:1.00f];
    [self createUI];
    
    [WXApiManager sharedManager].delegate = self;
}

- (void)goBack{
    if (_isOut) {
        YzjTabbarController *tabbarVC = [[YzjTabbarController alloc] init];
        YzjNavigationController *nc = [[YzjNavigationController alloc] initWithRootViewController:tabbarVC];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.window.rootViewController= nc;
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)createUI
{
    
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, kHeaderBarHeight, kScreenWidth, kScreenHeight*0.65)];
    _bgView.backgroundColor=[UIColor whiteColor];
    _bgView.userInteractionEnabled=YES;
    
    [self.view addSubview:_bgView];

    
    _numberTextField=[[UITextField alloc]initWithFrame:CGRectMake(74, kScreenHeight*0.2-40, kScreenWidth-84, 50)];
    _numberTextField.textColor=UIColorFromRGB(0x666666);
    _numberTextField.keyboardType=UIKeyboardTypeNumberPad;
    _numberTextField.delegate=self;
    _numberTextField.placeholder=@"请输入手机号码";
    [_bgView addSubview:_numberTextField];
    
    UIImage *icon = GetImage(@"phonered");
    UIImageView *phoneIV = [[UIImageView alloc] initWithImage:icon];
    phoneIV.frame = CGRectMake(_numberTextField.x - icon.size.width - 10.0f, _numberTextField.y + _numberTextField.height/2 - icon.size.height/2, icon.size.width, icon.size.height);
    [_bgView addSubview:phoneIV];
    
    _passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(74, kScreenHeight*0.30-40, kScreenWidth-84-120, 50)];
    _passwordTextField.textColor=UIColorFromRGB(0x666666);
    _passwordTextField.placeholder=@"请输入验证码";
    _passwordTextField.textColor=UIColorFromRGB(0x666666);
    _passwordTextField.delegate=self;
    _passwordTextField.keyboardType=UIKeyboardTypeNumberPad;
    _numberTextField.font = _passwordTextField.font = GetFont(15.0f);
    [_bgView addSubview:_passwordTextField];
    
    UIImage *icon2 = GetImage(@"usermsg");
    UIImageView *phoneIV2 = [[UIImageView alloc] initWithImage:icon2];
    phoneIV2.frame = CGRectMake(_passwordTextField.x - icon.size.width - 10.0f, _passwordTextField.y +  _passwordTextField.height/2 - icon2.size.height/2 , icon2.size.width, icon2.size.height);
    [_bgView addSubview:phoneIV2];
    
    float w = 300.0f;
    float w2 = 90.0f;
    float offx = kScreenWidth/2 - w/2;
    UIColor *lineColor = [UIColor colorWithRed:0.90f green:0.91f blue:0.91f alpha:1.00f];
    
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(offx, kScreenHeight*0.2, w, 0.5)];
    imageView1.backgroundColor=[UIColor colorWithRed:0.90f green:0.91f blue:0.91f alpha:1.00f];
    [_bgView addSubview:imageView1];
    
    
    UIImageView *imageView3=[[UIImageView alloc]initWithFrame:CGRectMake(offx, kScreenHeight*0.30, w, 0.5)];
    imageView3.backgroundColor=[UIColor colorWithRed:0.90f green:0.91f blue:0.91f alpha:1.00f];
    [_bgView addSubview:imageView3];
    
    
    
    
    self.getCodeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.getCodeButton.frame=CGRectMake(imageView1.x + imageView1.width - w2, _numberTextField.y + 3.0f, w2, 40);
    [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getCodeButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [_getCodeButton setTitleColor:graycolor forState:UIControlStateNormal];
    
    [_getCodeButton addTarget:self action:@selector(getIndenCode) forControlEvents:UIControlEventTouchUpInside];
    _getCodeButton.enabled=NO;
    [_bgView addSubview:_getCodeButton];
    
    CALayer *line = [CALayer layer];
    line.backgroundColor = lineColor.CGColor;
    line.frame = CGRectMake(_getCodeButton.x - 5.0f, imageView1.y - 25.0f, 0.5f, 20.f);
    [_bgView.layer addSublayer:line];
    
    
    
    _loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame=CGRectMake(kScreenWidth/2 -w/2, kScreenHeight*0.55-45, w, 45);
    _loginButton.userInteractionEnabled = NO;
    [_loginButton setBackgroundImage:[UIImage createImageWithColor:btnGarycolor] forState:UIControlStateNormal];
    
    
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.layer.masksToBounds=YES;
    _loginButton.layer.cornerRadius=22.5;
    [_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginWithWechat) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_loginButton];
    
    _protocalButton=[[UIButton alloc]init];
    UIImage *img = [UIImage imageNamed:@"Check2.png"];
    [_protocalButton setImage:img forState:UIControlStateNormal];
    [_protocalButton setImage:[UIImage imageNamed:@"Check1.png"] forState:UIControlStateSelected];
    _protocalButton.selected = YES;
    [_bgView addSubview:_protocalButton];
    [_protocalButton addTarget:self action:@selector(agreeProtocal:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat textWidth=[NSString getStringWidth:@"同意《亦蓁家用户协议》" font:[UIFont systemFontOfSize:14.0f] limitHeight:30];

    _protocalButton.frame=CGRectMake(phoneIV2.x +2.0f, CGRectGetMaxY(_passwordTextField.frame) + 10.0f, img.size.width, img.size.height);
    
    UIButton * textButton=[[UIButton alloc]initWithFrame:CGRectMake(_protocalButton.x + _protocalButton.width + 15.0f,  _protocalButton.y - (20.0f - img.size.height/2), textWidth, 40.0f)];
    textButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [textButton setTitleColor:kGrayColor forState:UIControlStateNormal];
    
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:@"同意《亦蓁用户协议》"];
    [str addAttribute:NSForegroundColorAttributeName value:redcolor range:NSMakeRange(2, 8)];
    [textButton setAttributedTitle:str forState:UIControlStateNormal];
    [_bgView addSubview:textButton];
    [textButton addTarget:self action:@selector(toRead) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)toRead{
    
}
-(void)agreeProtocal:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected && _passwordTextField.text.length >= 4 && _numberTextField.text.length == 11) {
        _loginButton.userInteractionEnabled = YES;
        [_loginButton setBackgroundImage:[UIImage createImageWithColor:redcolor] forState:UIControlStateNormal];
    }else
    {
        _loginButton.userInteractionEnabled = NO;
        [_loginButton setBackgroundImage:[UIImage createImageWithColor:btnGarycolor] forState:UIControlStateNormal];
    }
    
}


- (void)getIndenCode
{
    NSString *phoneNum=[_numberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![NSString isValidatePhoneNumber:phoneNum]) {
        [self.view showInfo:@"手机号码不正确" autoHidden:YES];
        
    }else{
        [self requestCode];//获取验证码
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantPast]];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        _getCodeButton.enabled=NO;
        
        [_getCodeButton setTitleColor:UIColorFromRGB(0xdedede) forState:UIControlStateNormal];
        self.getCodeButton.layer.borderColor=UIColorFromRGB(0xdedede).CGColor;
    }
}
// 获取验证码
-(void)requestCode{
    
    
    NSString *phoneNum=[_numberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [_accountService getCodeWithIndetfiyType:@"LOGIN" phone:phoneNum completionBlock:^(id responseObj) {
        NSLog(@"%@",responseObj);
    }];
    
}

- (void)countDown
{
    if (second<0) {
        [_timer invalidate];
        [_getCodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        
        if ([[UIDevice currentDevice].systemVersion doubleValue]<8) {
            
            _getCodeButton.titleLabel.text=@"重新获取";
            _getCodeButton.titleLabel.font=[UIFont systemFontOfSize:8];
            _getCodeButton.titleLabel.textAlignment=NSTextAlignmentCenter;
            
        }
        _timer=nil;
        if (_numberTextField.text.length==11) {
            [_getCodeButton setTitleColor:redcolor forState:UIControlStateNormal];
            _getCodeButton.enabled=YES;
        }else
        {
            [_getCodeButton setTitleColor:graycolor forState:UIControlStateNormal];
            _getCodeButton.enabled=NO;
        }
        
        second=60;
    }else{
        
        
        [_getCodeButton setTitle:[NSString stringWithFormat:@"%ds重发",second] forState:UIControlStateNormal];
        if ([[UIDevice currentDevice].systemVersion doubleValue]<8) {
            
            _getCodeButton.titleLabel.text=[NSString stringWithFormat:@"%ds重发",second];
            _getCodeButton.titleLabel.textAlignment=NSTextAlignmentCenter;
            
        }
        [_getCodeButton setTitleColor:graycolor forState:UIControlStateNormal];
        second--;
    }
    
}

-(void)loginAction
{
    [GiFHUD show];
    NSString *phoneNum=[_numberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [_accountService fastLoginInWithPhone:phoneNum andCode:_passwordTextField.text completionBlock:^(Account *account, RequestError *error) {
        
        if (error == nil && account) {
             if (self.isDetail) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:RELOADUSERSTATUS object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RELOADDETAIL" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                YzjTabbarController *tabbarVC = [[YzjTabbarController alloc] init];
                YzjNavigationController *nc = [[YzjNavigationController alloc] initWithRootViewController:tabbarVC];
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                delegate.window.rootViewController= nc;
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            [_timer invalidate];
            _timer = nil;
        }else if(error)
        {
            [self.view showInfo:@"登录失败" autoHidden:YES];
        }
    }];
    
}

- (void)tapView
{
    [self.view endEditing:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *passworldInputStr;
    NSString *phoneStr;
    
    passworldInputStr=_passwordTextField.text;
    phoneStr=_numberTextField.text;
    
    if (textField==_passwordTextField) {
        if (string.length>0) {
            passworldInputStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
        
            //切换测试和正式环境
            if ([passworldInputStr isEqualToString:@"250250250"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"切换环境？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
            }
            
        }else if(textField.text.length>=1)
        {
            passworldInputStr = [textField.text substringWithRange:NSMakeRange(0, [textField.text length]-1)];
        }
    }
    
    if (textField==_numberTextField) {
        if (string.length>0) {
            phoneStr=[NSString stringWithFormat:@"%@%@",textField.text,string];
            
        }else if(textField.text.length>=1)
        {
            phoneStr=[textField.text substringWithRange:NSMakeRange(0, [textField.text length]-1)];
            
        }
        
    }
    
    if (phoneStr.length==11  &&passworldInputStr.length>=4) {
        _loginButton.userInteractionEnabled = YES;
        [_loginButton setBackgroundImage:[UIImage createImageWithColor:redcolor] forState:UIControlStateNormal];

    }else {
        _loginButton.userInteractionEnabled = NO;
        [_loginButton setBackgroundImage:[UIImage createImageWithColor:btnGarycolor] forState:UIControlStateNormal];
    }
    
    if (phoneStr.length>=11 && _timer==nil) {
        _getCodeButton.enabled=YES;
        [self.getCodeButton setTitleColor:redcolor forState:UIControlStateNormal];

    }else
    {
        _getCodeButton.enabled=NO;
        [_getCodeButton setTitleColor:graycolor forState:UIControlStateNormal];

    }
    
    if (textField.text.length>=11 && textField==_numberTextField &&  string.length>0) {
        return NO;
    }
    return YES;
}

#pragma delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        BOOL online = [[NetworkServiceConfig shareInstance] isOnline];
        [[NetworkServiceConfig shareInstance] setIsOnline: !online];
        _passwordTextField.text = nil;
    }
}



#pragma wechat login 
static NSString *kAuthScope = @"snsapi_userinfo";
static NSString *kAuthOpenID = @"wxd477edab60670232";
static NSString *kAuthState = @"xxx";


- (void)loginWithWechat{
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = kAuthScope;
    req.state = kAuthState;
    req.openID = kAuthOpenID;
    [WXApi sendAuthReq:req
        viewController:self
              delegate:[WXApiManager sharedManager]];
}

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response{
    
}


@end
