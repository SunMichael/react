//
//  MinPickerView.m
//  yizhenjia
//
//  Created by mac on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MinPickerView.h"

@interface MinPickerView () <UIPickerViewDelegate , UIPickerViewDataSource>
{
    NSInteger index;
    IvyLabel *lastLab;
}

@end
@implementation MinPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.showsSelectionIndicator = YES;
    }
    return self;
}

-(void)setMinAry:(NSArray *)minAry{
    _minAry = minAry;
}
#pragma delegate && dataSource

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40.f;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _minAry.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _minAry[row];
}

//-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    for(UIView *singleLine in pickerView.subviews)
//    {
//        if (singleLine.frame.size.height < 1)
//        {
//            singleLine.backgroundColor = kBlackColor;
//        }
//    }
//    IvyLabel *label = (IvyLabel *)view;
//    if (!label) {
//        label = [[IvyLabel alloc] initWithFrame:view.frame text:_minAry[row] font:GetFont(19.f) textColor:kBlackColor textAlignment:NSTextAlignmentCenter numberLines:1];
//        label.backgroundColor = [UIColor clearColor];
//    }
//    return label;
//}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    IvyLabel *label = (IvyLabel *) [pickerView viewForRow:row forComponent:0];
//    if (![label isEqual:lastLab]) {
//        
//        label.font = GetFont(36.f);
//        label.textColor = kRedColor;
//        
//        lastLab.font = GetFont(19.f);
//        lastLab.textColor = kBlackColor;
//        lastLab = label;
//    }
    index = row;
//    _value = _minAry[row];
    _block(_minAry[row]);
}

@end
