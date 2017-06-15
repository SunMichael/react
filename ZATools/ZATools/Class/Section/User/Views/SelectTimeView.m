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
@property(nonatomic, strong)UIDatePicker *datePicker;
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, assign)DateType  type;
@property(nonatomic, copy)NSString *timeString;
@property(nonatomic, copy)NSString *selectDate;

@end

@implementation SelectTimeView
-(id)initWithFrame:(CGRect)frame type:(DateType)dateType SelectDate:(NSString *)selectDate
{
    if (self==[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.type=dateType;
        self.selectDate=selectDate;
        [self createsubView];
        
    }
    return self;
}
-(void)createsubView{
    
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, kScreenWidth, 244)];
    _bgView.backgroundColor=[UIColor whiteColor];
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 60.0f -5.0f, 5.0f, 60, 29)];
    button.backgroundColor=[UIColor whiteColor];
    [button setTitleColor:[UIColor colorWithRed:0.01f green:0.59f blue:0.83f alpha:1.00f] forState:UIControlStateNormal];
    
    button.titleLabel.font=[UIFont systemFontOfSize:17];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:button];
    [self addSubview:_bgView];
    
    _datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 200)];
    _datePicker.datePickerMode=UIDatePickerModeDate;
    
    NSDateFormatter  * formatter = [[ NSDateFormatter   alloc ] init ];
    [formatter  setDateFormat : @"yyyy-MM-dd" ];
    //[formatter dateFromString:_selectDate]
//    NSInteger year=[WNTools getCurrentYear];
//    NSInteger month=[WNTools getCurrentMonth];
    
    //    NSString  * mindateStr = [NSString stringWithFormat:@"%ld-%ld-01",year-3,month];// @"1900-01-01" ;
    
    //    NSString  * maxdateStr = [NSString stringWithFormat:@"%ld-%ld-01",year+1,month];
    
    //    NSDate  * mindate = [formatter  dateFromString :mindateStr];
    //    NSDate  * maxdate = [formatter  dateFromString :maxdateStr];
    //    _datePicker.minimumDate=mindate;
    if (self.type==ExpectDate) {
        _datePicker.minimumDate = [NSDate date];
        _datePicker.maximumDate = nil;
    }
    //    _datePicker.maximumDate=maxdate;
    
    if (self.type==BirthDate) {
        _datePicker.maximumDate = [NSDate date];
        _datePicker.minimumDate = nil;
    }
    
    
    
    
    [ _datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    [_bgView addSubview:_datePicker];
    
    _timeString=[formatter stringFromDate:[NSDate date]];
    if (![_selectDate isEqualToString:@"未填写"] && _selectDate.length>0) {
        // NSDate *lastDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[formatter dateFromString:_selectDate]];
        NSDate *lastDay = [formatter dateFromString:_selectDate];
        [_datePicker setDate:lastDay];
        _timeString=[formatter stringFromDate:lastDay];
        
    }
    
    
    
}
-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* date = control.date;
    [self formatterDate:date];
    
    /*添加你自己响应代码*/
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
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _bgView.frame=CGRectMake(0, self.bounds.size.height, kScreenWidth, _bgView.height);
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
        
        _bgView.frame=CGRectMake(0, self.bounds.size.height, kScreenWidth, _bgView.height);
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


@end
