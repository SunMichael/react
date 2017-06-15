//
//  LogoutView.h
//  yizhenjia
//
//  Created by 汪宁 on 16/9/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogoutView : UIView

@property(nonatomic, strong)void (^logOut)();
-(id)initWithFrame:(CGRect)frame;
-(void)showLogoutView;
@end
