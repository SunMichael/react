//
//  SearchBar.m
//  yizhenjia
//
//  Created by mac on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar
{
    BOOL lastWord;
    float tfW;
}
-(instancetype)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle andPlaceHolder:(NSString *)holder{
    
    return [self initWithFrame:frame leftTitle:leftTitle leftImage:nil andRightTitle:rightTitle rightImage:nil andPlaceHolder:holder];
}

-(instancetype)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle leftImage:(UIImage *)leftImage andRightTitle:(NSString *)rightTitle rightImage:(UIImage *)rightImage andPlaceHolder:(NSString *)holder{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float offy = 30.0f;
        CGSize size = [leftTitle sizeWithFont:GetFont(15.0f) forWidth:frame.size.width lineBreakMode:NSLineBreakByWordWrapping];
        NSLog(@" rect %@ ",NSStringFromCGSize(size));
        _leftLab = [[IvyLabel alloc] initWithFrame:CGRectMake(0.0f, offy, self.width , frame.size.height - offy) text:leftTitle font:GetFont(15.0f) textColor:kBlackColor textAlignment:NSTextAlignmentCenter numberLines:1];
        [_leftLab sizeToFit];
        float sizew = size.width > 50.0f ? 50.0f : size.width;
        _leftLab.frame = CGRectMake(5.0f, offy, sizew + leftImage.size.width + 5.0f, frame.size.height - offy);
        [self addSubview:_leftLab];
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = _leftLab.frame;
        
        if (leftImage && leftTitle) {
            _leftLab.text = nil;
            [_leftBtn setTitle:leftTitle forState:UIControlStateNormal];
            [_leftBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
            _leftBtn.titleLabel.font = GetFont(15.0f);
            [_leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -10.0f, 5.0f, 5.0f)];
            [_leftBtn setImage:leftImage forState:UIControlStateNormal];
            [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0f, _leftBtn.width -leftImage.size.width , 5.0f, 0.0f)];
            _leftBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            //            _leftBtn.frame = CGRectMake(_leftBtn.x, _leftBtn.y, 80.0f, _leftBtn.height);
        }else if (leftImage && !leftTitle) {
            _leftBtn.frame = CGRectMake(0.0f, _leftBtn.y , leftImage.size.width + 20.0f, _leftBtn.height -5.0f);
            [_leftBtn setImage:leftImage forState:UIControlStateNormal];
        }
        [self addSubview:_leftBtn];
        
        
        IvyLabel *rightLab = [[IvyLabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, offy, frame.size.height - offy) text:rightTitle font:GetFont(15.0f) textColor:kBlackColor textAlignment:NSTextAlignmentCenter numberLines:1];
        [rightLab sizeToFit];
        float maxw = rightLab.width < 40.0f ? 40.0f : rightLab.width;
        
        if (rightImage == nil && [NSString isEmply:rightTitle]) {
            maxw = 5.0f;
        }
        rightLab.frame = CGRectMake(kScreenWidth - maxw , offy, maxw, frame.size.height - offy);
        [self addSubview:rightLab];
        
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = rightLab.frame;
        if (rightImage && [NSString isEmply:rightTitle]) {
            [_rightBtn setImage:rightImage forState:UIControlStateNormal];
        }
        [self addSubview:_rightBtn];
        
        tfW = self.width - _rightBtn.width - _leftBtn.width -_leftBtn.x -5.0f;
        
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(5.0f +_leftBtn.width + _leftBtn.x , offy, tfW, frame.size.height - offy - 5.0f)];
        _searchView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
        _searchView.layer.masksToBounds = YES;
        _searchView.layer.cornerRadius = _searchView.height/2;
        [self addSubview:_searchView];
        
        UIImage *icon = GetImage(@"Seach");
        UIImageView *ivName = [[UIImageView alloc] initWithImage:icon];
        ivName.frame = CGRectMake( 10.0f, _searchView.height/2 - icon.size.height/2, icon.size.width, icon.size.height);
        [_searchView addSubview:ivName];
        
        _tfield = [[UITextField alloc] initWithFrame:CGRectMake(ivName.width + ivName.x + 10.0f, 0.0, tfW - (ivName.size.width + 20.0f), _searchView.height)];
        _tfield.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
        _tfield.delegate = self;
        _tfield.font = GetFont(15.0f);
        _tfield.placeholder = holder;
        _tfield.returnKeyType = UIReturnKeySearch;
        [_tfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEditingEvents];
        [_searchView addSubview:_tfield];
        
        CALayer *line = [CALayer layer];
        line.backgroundColor = kBackViewColor.CGColor;
        line.frame = CGRectMake(0.0f, self.height - 1.0f, kScreenWidth, 1.f);
        [self.layer addSublayer:line];
        
        
    }
    return self;
}

- (void)textChange:(UITextField *)textField{
    if (textField.text.length == 0) {
        if (lastWord == YES) {
            [_searchDelegate searchDidEndEdit];
            if ([textField canResignFirstResponder]) {
                [self performSelector:@selector(resetKeyboard:) withObject:textField afterDelay:0.3f];
                
            }
        }
        lastWord = NO;
    }else{
        lastWord = YES;
    }
}
- (void)resetKeyboard:(id)sender{
    UITextField *textField = sender;
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    [_searchDelegate searchForText:textField.text];
    return YES;
}

- (void)setLeftTitle:(NSString *)leftTitle{
    _leftLab.text = leftTitle;
    [_leftLab sizeToFit];
    CGSize size = [leftTitle sizeWithFont:GetFont(15.0f) forWidth:kScreenWidth lineBreakMode:NSLineBreakByTruncatingTail];
    
    float sizew = size.width > 60.0f ? 60.0f : size.width;
    [_leftBtn setTitle:leftTitle forState:UIControlStateNormal];
    _leftBtn.titleLabel.font = GetFont(15.0f);
    _leftBtn.frame = CGRectMake(_leftBtn.x, _leftBtn.y, sizew + _leftBtn.imageView.image.size.width +5.0f, _leftBtn.height);
    [_leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -10.0f, 5.0f, 5.0f)];
    [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0f, _leftBtn.width - _leftBtn.imageView.image.size.width , 5.0f, 0.0f)];
    _leftLab.text = @"";
    
    tfW = self.width - _rightBtn.width - _leftBtn.width - _leftBtn.x - 5.0f;
    _searchView.frame = CGRectMake(_leftBtn.width + 5.0f +_leftBtn.x , _searchView.y, tfW, _searchView.height);
}

@end
