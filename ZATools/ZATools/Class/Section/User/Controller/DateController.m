//
//  DateController.m
//  ZATools
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DateController.h"
#import "UIImage+ColorToImage.h"
#import "SelectTimeView.h"
@interface DateController () <UITextFieldDelegate , SelectTimeDelegate>
{
    DateSettingType _copyType;
    NSString *tipString;
    UIScrollView *scroll;
    NSArray *titlesAry;
    NSArray *imgAry;
    NSArray *placeAry;
    NSString *linkString;
}
@end

@implementation DateController

-(instancetype)initWithType:(DateSettingType)type{
    self = [super init];
    if (self) {
        _copyType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[self backScrollView]];
    [self loadChooseDateViews];

}
- (UIScrollView *)backScrollView{
    if (!scroll) {
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, navigationBarHeight, kScreenWidth, kScreenHeight - navigationBarHeight)];
        scroll.showsVerticalScrollIndicator = NO;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.backgroundColor = kBackViewColor;
        scroll.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [scroll setContentSize:CGSizeMake(kScreenWidth, scroll.height + 1.0f)];
        [self.view addSubview:scroll];
    }
    return scroll;
}

- (NSString *)title{
    switch (_copyType) {
        case DateSettingTypeBaby:
        {
            tipString = @"";
            titlesAry = @[@"宝宝生日", @"宝宝性别"];
            placeAry = @[@"请输入宝宝生日", @"请输入宝宝性别"];
            linkString = @"我知道预产期";
            return @"设置宝宝信息";
        }
            break;
        case DateSettingTypeCalculation:
        {
            tipString = @"请填写下面的月经详情，将为您自动计算预产期";
            titlesAry = @[@"末次月经日期",@"月经周期（天数）"];
            placeAry = @[@"请输入月经日期",@"请输入月经天数"];
            linkString = @"我知道预产期";
            return @"计算预产期";
        }
            break;
        case DateSettingTypeExpect:
        {
            tipString = @"输入产检时医生告知的预产期，如尚未产检可以使用\"计算预产期\"";
            titlesAry = @[@"输入预产期"];
            placeAry = @[@"请设置预产期"];
            linkString = @"不知道预产期，计算预产期";
            return @"设置预产期";
        }
            break;
        default:
            break;
    }
}

- (void)loadChooseDateViews{

    float offx = 30.0f;
    IvyLabel *tipLab = [[IvyLabel alloc] initWithFrame:CGRectMake(offx, offx, kScreenWidth - 2*offx, MAXFLOAT) text:tipString font:GetFont(15.f) textColor:kGrayColor textAlignment:NSTextAlignmentCenter numberLines:0];
    [tipLab sizeToFit];
    
    [scroll addSubview:tipLab];
    
    float offy = CGRectGetMaxY(tipLab.frame) + 20.f;
    for (NSInteger i = 0; i < titlesAry.count; i++) {
        IvyLabel *titleLab = [[IvyLabel alloc] initWithFrame:CGRectMake(offx, offy, 200, 15.f) text:titlesAry[i] font:GetFont(15) textColor:kBlackColor textAlignment:NSTextAlignmentLeft numberLines:1];
        [scroll addSubview:titleLab];
        
        UIView *view = [self loadInputViewWithFrame:CGRectMake(offx, CGRectGetMaxY(titleLab.frame) + 10.0f, tipLab.width, 30.0f) andPlace:placeAry[i] icon:nil tag:i];
        [scroll addSubview:view];
        offy = CGRectGetMaxY(view.frame) + 25.f;
        
        if (i == titlesAry.count - 1) {
            IvyLabel *linkLab = [[IvyLabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0) text:nil font:GetFont(14) textColor:kPinkColor textAlignment:NSTextAlignmentLeft numberLines:1];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:linkString];
            [attStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, linkString.length)];
        
            linkLab.attributedText = attStr;
            [linkLab sizeToFit];
            linkLab.frame = CGRectMake(kScreenWidth - offx - linkLab.width, offy, linkLab.width, linkLab.height);
            [scroll addSubview:linkLab];
            
            offy = CGRectGetMaxY(linkLab.frame) + 50.f;
        }
    }
    
    float btnw = 200.f;
    IvyButton *button = [[IvyButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 - btnw/2, offy, btnw, 45.f) titleStr:@"保存" titleColor:kWhiteColor font:GetFont(15.f) logoImg:nil backgroundImg:[UIImage createImageWithColor:kPinkColor]];
    [button addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:button];
    
    if (CGRectGetMaxY(button.frame) > scroll.height) {
        [scroll setContentSize:CGSizeMake(scroll.width, CGRectGetMaxY(button.frame) + 30.f)];
    }
}


- (UIView *)loadInputViewWithFrame:(CGRect)frame andPlace:(NSString *)place icon:(UIImage *)icon tag:(NSInteger)tag{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = view.height/2;
    view.layer.borderColor = kPinkColor.CGColor;
    view.layer.borderWidth = 1.f;
    
    UIImageView *ivName = [[UIImageView alloc] initWithImage:icon];
    ivName.frame = CGRectMake(frame.size.height + 5.f, frame.size.height/2 - icon.size.height/2, icon.size.width, icon.size.height);
    [view addSubview:ivName];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ivName.frame), 0, frame.size.width - CGRectGetMaxX(ivName.frame) - 5.f - 10.f, frame.size.height)];
    tf.placeholder = place;
    tf.textColor = kBlackColor;
    tf.font = GetFont(13.f);
    tf.delegate = self;
    tf.tag = tag;
    [view addSubview:tf];

    return view;
}

/**
 保存用户信息
 */
- (void)save{
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 0) {
        [self showDatePicker];
    }
    return NO;
}

- (void)showDatePicker{
    SelectTimeView *timeView=[[SelectTimeView alloc]initWithFrame:[UIScreen mainScreen].bounds type:BirthDate SelectDate:nil];
    timeView.delegate=self;
    UIWindow *window=  [UIApplication sharedApplication].keyWindow ;
    [window addSubview:timeView];
    [timeView showTimeView];
}

- (void)getBirthResult:(NSString *)str{
    
}

- (void)getExpectDateResult:(NSString *)str{
    
}














@end
