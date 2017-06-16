//
//  FeedBackController.m
//  yizhenjia
//
//  Created by 汪宁 on 16/8/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FeedBackController.h"
#import "UIImage+ColorToImage.h"

@interface FeedBackController ()<UITextViewDelegate,UITextFieldDelegate>
{
    IvyLabel *tipLab;
    NSString *defaultText;
}
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, strong)UITextView *textView;
@property(nonatomic, strong)UITextField*contactField;
@property(nonatomic, strong)UIButton *submitButton;
@end
@implementation FeedBackController
-(void)viewDidLoad{
    [super viewDidLoad];
    defaultText = @"把您的宝贵意见告诉我们，我们会很快改进的";
    self.view.backgroundColor=[UIColor colorWithRed:0.94f green:0.94f blue:0.95f alpha:1.00f];
    
    [self createUI];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:tap];

    
}
-(NSString *)title{
    return @"意见反馈";
}

-(void)tapView
{
    [self.view endEditing:YES];
}

-(void)createUI{
    
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, navigationBarHeight+15, kScreenWidth, 200)];
    _bgView.backgroundColor=[UIColor colorWithRed:0.94f green:0.94f blue:0.95f alpha:1.00f];
    [self.view addSubview:_bgView];
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _textView.backgroundColor=[UIColor whiteColor];
    _textView.font=[UIFont systemFontOfSize:15];
    _textView.textColor=[UIColor colorWithRed:0.81f green:0.81f blue:0.83f alpha:1.00f];
     _textView.delegate=self;
    _textView.text = defaultText;
    [_bgView addSubview:_textView];
    
//    tipLab = [[IvyLabel alloc] initWithFrame:CGRectMake(5, 5, 200, 14) text:@"把您的宝贵意见告诉我们，我们会很快改进的" font:GetFont(14) textColor:kLightGrayColor textAlignment:NSTextAlignmentLeft numberLines:1];
//    [_textView addSubview:tipLab];
   
    _submitButton=[[UIButton alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(_bgView.frame)+20, kScreenWidth-80, 40)];
    _submitButton.layer.cornerRadius=20;
    _submitButton.layer.masksToBounds=YES;
    [self.view addSubview:_submitButton];
    [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    
    [_submitButton setBackgroundImage:[UIImage createImageWithColor:kPinkColor] forState:UIControlStateNormal];
    [_submitButton setBackgroundImage:[UIImage createImageWithColor:kLightGrayColor] forState:UIControlStateDisabled];
    _submitButton.enabled = NO;
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

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:defaultText]) {
        textView.text=@"";
    }
      textView.textColor=UIColorFromRGB(0x666666);
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSString *str=[textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([str isEqualToString:@""]) {
        textView.text=defaultText;
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
