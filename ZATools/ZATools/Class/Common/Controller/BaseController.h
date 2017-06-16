//
//  ViewController.h
//  yizhenjia
//
//  Created by mac on 16/8/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseController : UIViewController

@property (nonatomic, copy) NSString *backTitle;
@property (nonatomic, assign) BOOL needBack;
- (void)showIndicatorOnWindow;

- (void)showIndicatorOnWindowWithMessage:(NSString *)message;

- (void)showTextOnly:(NSString *)text;

- (void)hideIndicatorOnWindow;

-(void)addFailLoadView:(CGRect)frame;//当父类 ｀｀｀｀｀｀
-(void)removeNoDateView;

- (void)back;
@end

