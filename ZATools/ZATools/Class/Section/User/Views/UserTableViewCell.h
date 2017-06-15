//
//  UserTableViewCell.h
//  yizhenjia
//
//  Created by mac on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kUserCellH   45.0f
@interface UserTableViewCell : UITableViewCell

@property (nonatomic ,strong) IvyLabel *titleLab;
@property (nonatomic ,strong) UIImageView *iconIv;
@property (nonatomic ,strong) UIImageView *arrowIv;
@property (nonatomic ,strong) IvyLabel *tipLab;

- (void)updateCellWithImage:(UIImage *)image andTitle:(NSString *)title needBottomLine:(BOOL)need;

@end
