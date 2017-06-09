//
//  ShareView.h
//  yizhenjia
//
//  Created by 汪宁 on 16/8/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"
typedef enum :NSInteger
{
    shareFound,
    shareApp
}ShareType;

@protocol ShareResponseDelegate <NSObject>

- (void)shareSuccess:(BOOL)success;

@end

@interface ShareView : UIView
-(id)initWithFrame:(CGRect)frame shareType:(ShareType)shareType;
-(void)showShareView;

@property(nonatomic, strong)UIViewController *vc;

@property(nonatomic ,strong) ReadModel *model;


@property(nonatomic ,copy) NSString *inforUrl;
@property(nonatomic ,copy) NSString *title;
@property(nonatomic ,copy) NSString *thumUrl;      //缩略图
@property(nonatomic ,copy) NSString *subTitle;

@property(nonatomic ,weak) id <ShareResponseDelegate> shareDelegate;

@end
