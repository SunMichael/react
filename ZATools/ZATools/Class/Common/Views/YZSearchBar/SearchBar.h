//
//  SearchBar.h
//  yizhenjia
//
//  Created by mac on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SearchBarDelgate <NSObject>

@optional
- (void)searchForText:(NSString *)text;
- (void)searchDidEndEdit;

@end

@interface SearchBar : UIView <UITextFieldDelegate>

@property (nonatomic ,strong) UIButton *leftBtn;
@property (nonatomic ,strong) UIButton *rightBtn;
@property (nonatomic ,strong) IvyLabel *leftLab;
@property (nonatomic ,strong) UITextField *tfield;
@property (nonatomic ,strong) UIView *searchView;
@property(nonatomic ,assign) void(^searchBlock)(NSString *text) ;

@property(nonatomic ,assign) id <SearchBarDelgate> searchDelegate;

-(instancetype)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle andPlaceHolder:(NSString *)holder;


/**
 初始化search header

 @param leftTitle
 @param rightTitle
 @param holder

 @return
 */
-(instancetype)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle leftImage:(UIImage *)leftImage andRightTitle:(NSString *)rightTitle rightImage:(UIImage *)rightImage andPlaceHolder:(NSString *)holder;


- (void)setLeftTitle:(NSString *)leftTitle;
@end
