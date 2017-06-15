//
//  UserHeaderView.h
//  yizhenjia
//
//  Created by mac on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserHeaderView : UIView


/**
 更新各种订单状态
 */
- (void)updateAllOrderStatus:(NSArray *)numberAry;

- (void)updateStatusText:(Account *)account;


@end
