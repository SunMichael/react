//
//  VideoPlayView.h
//  yizhenjia
//
//  Created by 汪宁 on 16/9/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface VideoPlayView : UIView


/** 创建视频新特性界面
 *  @param URL 视频路径
 *  @param enterBlock 进入主页面的回调
 *  @param configurationBlock 配置回调
 */
-(id)initWithPlayerURL:(NSURL *)URL enterBlock:(void(^)())enterBlock configuration:(void (^)(AVPlayerLayer *playerLayer))configurationBlock;





@end
