//
//  FeedBackController.m
//  yizhenjia
//
//  Created by 汪宁 on 16/8/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FeedBackController.h"
@interface FeedBackController ()<UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, strong)UITextView *textView;
@property(nonatomic, strong)UITextField*contactField;
@property(nonatomic, strong)UIButton *submitButton;
@end
@implementation FeedBackController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.94f green:0.94f blue:0.95f alpha:1.00f];
    
    [self createUI];
    [self loadBaseViewContent];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:tap];

    
}
-(void)tapView
{
    [self.view endEditing:YES];
}
-(void)loadBaseViewContent{
    
    IvyHeaderBar *header = [[IvyHeaderBar alloc] initWithTitle:@"吐槽一下" leftBtnTitle:nil leftBtnImg:[UIImage imageNamed:@"Icon_back"] leftBtnHighlightedImg:nil rightBtnTitle:nil rightBtnImg:nil rightBtnHighlightedImg:nil backgroundColor:[UIColor whiteColor]];
    [header.leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:header];
    
}
-(void)back{
    
    [RootNavController popViewControllerAnimated:YES];
    
}

-(void)createUI{
    
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, navigationBarHeight+15, kScreenWidth, 270)];
    _bgView.backgroundColor=[UIColor colorWithRed:0.94f green:0.94f blue:0.95f alpha:1.00f];
    [self.view addSubview:_bgView];
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _textView.backgroundColor=[UIColor whiteColor];
    _textView.text=@"请描述你的问题和建议";
    _textView.font=[UIFont systemFontOfSize:15];
    _textView.textColor=[UIColor colorWithRed:0.81f green:0.81f blue:0.83f alpha:1.00f];
     _textView.delegate=self;
    
    [_bgView addSubview:_textView];
    
    _contactField=[[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_textView.frame)+15, kScreenWidth, 50)];
    _contactField.backgroundColor=[UIColor whiteColor];
    _contactField.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 50)];
    _contactField.leftViewMode=UITextFieldViewModeAlways;
    _contactField.font=[UIFont systemFontOfSize:15];
    _contactField.placeholder=@"请留下您的联系方式（选填）";
    _contactField.delegate=self;
    [_bgView addSubview:_contactField];
   
    _submitButton=[[UIButton alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(_bgView.frame)+20, kScreenWidth-80, 40)];
    _submitButton.layer.cornerRadius=20;
    _submitButton.layer.masksToBounds=YES;
    [self.view addSubview:_submitButton];
    [_submitButton setTitle:@"提交建议" forState:UIControlStateNormal];
    _submitButton.backgroundColor=[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
    _submitButton.enabled=NO;
    [_submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)submit{
    [GiFHUD show];
//    InfomationService *service=[InfomationService shareInstance];
//    [service postFeedBackWithContent:_textView.text contactWay:_contactField.text Complete:^(RequestError *error) {
//        [GiFHUD dismiss];
//        if (error==nil) {
//            [self.view showInfo:@"反馈成功" autoHidden:YES];
//            sleep(0.5f);
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            [self.view showInfo:error.message autoHidden:YES];
//        }
//        
//    }];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        _bgView.frame=CGRectMake(0, -20, kScreenWidth, 270);
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        _bgView.frame=CGRectMake(0, navigationBarHeight+15, kScreenWidth, 270);
    }];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请描述你的问题和建议"]) {
        textView.text=@"";
    }
      textView.textColor=UIColorFromRGB(0x666666);
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSString *str=[textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([str isEqualToString:@""]) {
        textView.text=@"请描述你的问题和建议";
        textView.textColor=[UIColor colorWithRed:0.81f green:0.81f blue:0.83f alpha:1.00f];
      
    }
    
    
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSString *string=[NSString stringWithFormat:@"%@%@",text,textView.text];
    string=[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (string.length>0) {
        _submitButton.enabled=YES;
        _submitButton.backgroundColor=UIColorFromRGB(0xff8787);

        
    }else
    {
        _submitButton.enabled=NO;
        _submitButton.backgroundColor=[UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f];
    }
    
    NSString *lang = [textView.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (textView.text.length > 120) {
                textView.text = [textView.text substringToIndex:120];
            }
           
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (textView.text.length > 120) {
            textView.text = [textView.text substringToIndex:120];
        }
        
    }
    

    
    return YES;
}

@end
