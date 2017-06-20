//
//  SelectTimeView.m
//  yizhenjia
//
//  Created by 汪宁 on 16/8/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SelectTimeView.h"
#import "WNTools.h"

@interface SelectTimeView()
{
    NSString *selectedDayString;
}
@property(nonatomic, strong)UIDatePicker *datePicker;
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, assign)DateType  type;
@property(nonatomic, copy)NSString *timeString;
@property(nonatomic, copy)NSString *selectDate;
@property(nonatomic, copy)NSString *title;

@end

@implementation SelectTimeView
-(id)initWithFrame:(CGRect)frame type:(DateType)dateType SelectDate:(NSString *)selectDate title:(NSString *)title
{
    if (self==[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.type=dateType;
        self.selectDate=selectDate;
        _title = title;
        [self createsubView];
        
    }
    return self;
}
-(void)createsubView{
    
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, kScreenWidth, 244)];
    _bgView.backgroundColor=[UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(miss)];
    [self addGestureRecognizer:tap];
    
    IvyLabel *titleLab = [[IvyLabel alloc] initWithFrame:CGRectMake(0, 0, _bgView.width, 40) text:_title font:GetFont(17) textColor:kBlackColor textAlignment:NSTextAlignmentCenter numberLines:1];
    [_bgView addSubview:titleLab];
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 60.0f -5.0f, 0.0f, 60, 40)];
    button.backgroundColor=[UIColor whiteColor];
    [button setTitleColor:kPinkColor forState:UIControlStateNormal];
    
    button.titleLabel.font=[UIFont systemFontOfSize:17];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:button];
    [self addSubview:_bgView];
    
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(5.0f, 0.0f, 60, 40)];
    cancelBtn.backgroundColor=[UIColor whiteColor];
    [cancelBtn setTitleColor:kPinkColor forState:UIControlStateNormal];
    
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:17];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(miss) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:cancelBtn];

    
    
    if (_type == BirthDate || _type == ExpectDate) {
        _datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 200)];
        _datePicker.datePickerMode=UIDatePickerModeDate;
        
        NSDateFormatter  * formatter = [[ NSDateFormatter   alloc ] init ];
        [formatter  setDateFormat : @"yyyy-MM-dd" ];
        if (self.type==ExpectDate) {
            _datePicker.minimumDate = [NSDate date];
            _datePicker.maximumDate = nil;
        }
        
        if (self.type==BirthDate) {
            _datePicker.maximumDate = [NSDate date];
            _datePicker.minimumDate = nil;
        }
        [ _datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
        [_bgView addSubview:_datePicker];
        
        _timeString=[formatter stringFromDate:[NSDate date]];
        if (![_selectDate isEqualToString:@"未填写"] && _selectDate.length>0) {
            NSDate *lastDay = [formatter dateFromString:_selectDate];
            [_datePicker setDate:lastDay];
            _timeString=[formatter stringFromDate:lastDay];
            
        }
    }else if(_type == DayDate){
        NSMutableArray *allAry = [NSMutableArray array];
        for (NSInteger i = 1; i <= 31; i++) {
            [allAry addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        _minView = [[MinPickerView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 200)];
        _minView.minAry = allAry;
        _minView.showsSelectionIndicator = YES;
//        __weak SelectTimeView *weakSelf = self;
        _minView.block = ^(NSString *string){
            selectedDayString = string;
        };
        [_bgView addSubview:_minView];
        [self performSelector:@selector(selected:) withObject:_minView afterDelay:0.01f];
    }else if (_type == SexType){
        _minView = [[MinPickerView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 200)];
        _minView.minAry = @[@"男宝宝",@"女宝宝"];
        _minView.showsSelectionIndicator = YES;
//        __weak SelectTimeView *weakSelf = self;
        _minView.block = ^(NSString *string){
            selectedDayString = string;
        };
        [_bgView addSubview:_minView];
        [self performSelector:@selector(selected:) withObject:_minView afterDelay:0.01f];
    }
}

- (void)selected:(MinPickerView *)picker{
    [picker pickerView:picker didSelectRow:0 inComponent:0];
}

-(void)dateChanged:(id)sender{
    
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* date = control.date;
    [self formatterDate:date];
    
}

- (void)formatterDate:(NSDate *)date{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _timeString= [formatter stringFromDate:date];
}

-(void)showTimeView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        _bgView.frame=CGRectMake(0, kScreenHeight-_bgView.bounds.size.height, kScreenWidth, _bgView.height);
        
    }completion:^(BOOL finished) {
        
    }];
    
}

-(void)cancel
{
    
    if (self.type==BirthDate) {
        if (self.delegate) {
            [self.delegate performSelector:@selector(getBirthResult:) withObject:_timeString];
        }
        
    }else if (self.type==ExpectDate)
    {
        if (self.delegate) {
            [self.delegate performSelector:@selector(getExpectDateResult:) withObject:_timeString];
        }
    }else{
        if ([_delegate respondsToSelector:@selector(getDayResult:)]) {
            [_delegate getDayResult:selectedDayString];
        }
    }
    [self miss];
}


- (void)miss{
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.frame=CGRectMake(0, self.bounds.size.height, kScreenWidth, _bgView.height);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        _bgView.frame=CGRectMake(0, self.bounds.size.height, kScreenWidth, _bgView.height);
//        
//    }completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
//    
//}


@end
