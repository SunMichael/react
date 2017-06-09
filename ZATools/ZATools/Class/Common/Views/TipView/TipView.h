//
//  TipView.h
//  yizhenjia
//
//  Created by mac on 16/8/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    TipViewTypeClose,        //有按钮和关闭
    TipViewTypeIcon,         //有图片 没按钮  自动消失
    TipViewTypeSingle,        // 无图  有按钮
} TipViewType;



@interface TipView : UIView

//@property(nonatomic, copy) ;

/**
 *  提示视图
 *
 *  @param type     类型
 *  @param title    主要提示文案
 *  @param confirm  确定按钮文案
 *  @param icon     icon
 *  @param tipStr   针对icon类型的红色tip文案
 *  @param subTitle 说明文案
 *
 *  @return
 */
- (instancetype)initWithType:(TipViewType)type andTitle:(NSString *)title subTitle:(NSString *)subTitle withConfirmTitle:(NSString *)confirm icon:(UIImage *)icon tipString:(NSString *)tipStr andSubContent:(NSString *)subcont;


- (void)showTipViewWithConfirmBlock:(void(^)(void))confirm ;

@end
