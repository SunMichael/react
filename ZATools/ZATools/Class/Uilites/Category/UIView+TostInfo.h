//
//  UIView+TostInfo.h
//  yizhenjia
//
//  Created by 汪宁 on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface UIView (TostInfo)



- (void)showInfo:(NSString *)info autoHidden:(BOOL)autoHide;
- (void)showInfo:(NSString *)info autoHidden:(BOOL)autoHide interval:(NSUInteger)seconds;

-(void)addNoDataView:(NSString *)text image:(UIImage *)image;
-(void)addNoDataViewFrame:(CGRect)frame text:(NSString *)text image:(UIImage *)image;
-(void)addFailLoadView:(CGRect)frame;
-(void)removeNoDataView;

-(BOOL)noDataViewIsNil;

@end
