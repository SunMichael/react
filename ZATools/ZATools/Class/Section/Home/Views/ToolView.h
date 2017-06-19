//
//  ToolView.h
//  ZATools
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

 

@interface ToolView : UIView

@property(nonatomic ,strong) IvyLabel *titleLab;
@property(nonatomic ,strong) UIImageView *iconView;
@property(nonatomic ,strong) IvyButton *button;
@property(nonatomic ,strong) UIButton *editBtn;

@property(nonatomic ,copy) void(^editBlock)(BOOL add ,NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame withEditStatus:(BOOL)useing;

@end
