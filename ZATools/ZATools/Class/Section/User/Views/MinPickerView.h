//
//  MinPickerView.h
//  yizhenjia
//
//  Created by mac on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinPickerView : UIPickerView

@property(nonatomic ,strong) NSArray *minAry;

@property(nonatomic ,assign) NSNumber *value;
@property(nonatomic ,strong) void (^block)(NSString *);
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
