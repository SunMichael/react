//
//  SelectTimeView.h
//  yizhenjia
//
//  Created by 汪宁 on 16/8/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger
{
    BirthDate,
    ExpectDate,
    
    
}DateType;


@protocol SelectTimeDelegate <NSObject>
@optional
-(void)getBirthResult:(NSString *)str;
-(void)getExpectDateResult:(NSString *)str;

@end
@interface SelectTimeView : UIView
@property(nonatomic, weak)id<SelectTimeDelegate>delegate;
-(id)initWithFrame:(CGRect)frame type:(DateType)dateType SelectDate:(NSString *)selectDate;
-(void)showTimeView;
@end
