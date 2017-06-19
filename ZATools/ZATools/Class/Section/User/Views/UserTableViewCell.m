//
//  UserTableViewCell.m
//  yizhenjia
//
//  Created by mac on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell
{
    CALayer *line;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _iconIv = [[UIImageView alloc] init];
        
        [self addSubview:_iconIv];
        
        UIImage *icon = GetImage(@"next");
        _arrowIv = [[UIImageView alloc] initWithImage:icon];
        _arrowIv.frame = CGRectMake(kScreenWidth - icon.size.width - 10.0f, kUserCellH/2 - icon.size.height/2, icon.size.width, icon.size.height);
        [self addSubview:_arrowIv];
        
        _titleLab = [[IvyLabel alloc] initWithFrame:CGRectMake(_iconIv.x + _iconIv.width + 10.0f, 0.0f, kScreenWidth, kUserCellH) text:nil font:GetFont(15.0f) textColor:kBlackColor textAlignment:NSTextAlignmentLeft numberLines:1];
        [self addSubview:_titleLab];
        
        _tipLab = [[IvyLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _arrowIv.x - 5.0f, kUserCellH) text:nil font:GetFont(15.0f) textColor:kGrayColor textAlignment:NSTextAlignmentRight numberLines:1];
        [self addSubview:_tipLab];
        
    }
    return self;
}

- (void)updateCellWithImage:(UIImage *)image andTitle:(NSString *)title needBottomLine:(BOOL)need{
    _iconIv.image = image;
    _iconIv.frame = CGRectMake(10.0f, kUserCellH/2 - image.size.height/2, 18, 18);
    
    _titleLab.text = title;
    _titleLab.frame = CGRectMake(_iconIv.x + _iconIv.width + 10.0f, 0.0f, kScreenWidth, kUserCellH);
//    if (need) {
//        line = [CALayer layer];
//        line.backgroundColor = kLineColor.CGColor;
//        line.frame = CGRectMake(0.0f, kUserCellH - 0.5f, kScreenWidth, 0.5f);
//        [self.layer addSublayer:line];
//        line.hidden = NO;
//    }else{
//        line.hidden = YES;
//    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
