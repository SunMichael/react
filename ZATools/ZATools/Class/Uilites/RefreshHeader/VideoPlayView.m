//
//  VideoPlayView.m
//  yizhenjia
//
//  Created by 汪宁 on 16/9/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "VideoPlayView.h"
@interface VideoPlayView ()

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic,copy) void(^enterBlock)();

@end

@implementation VideoPlayView
// 初始化视频新特性界面

-(id)initWithPlayerURL:(NSURL *)URL enterBlock:(void(^)())enterBlock configuration:(void (^)(AVPlayerLayer *playerLayer))configurationBlock
{
    if (self=[super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        
        // 初始化播放器
        configurationBlock([self playerWith:URL]);
        
        // 监听通知
        [self setUpNotification];
        
               //记录block
        self.enterBlock = enterBlock;
        
    }
    
    return self;
    
}


// 监听通知
- (void)setUpNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)dealloc
{
    [self.playerLayer.player replaceCurrentItemWithPlayerItem:nil];
    [self.playerLayer.player.currentItem cancelPendingSeeks];
    [self.playerLayer.player.currentItem.asset cancelLoading];
    [self.playerLayer.player pause];
    self.playerLayer.player = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - 初始化播放器
- (AVPlayerLayer *)playerWith:(NSURL *)URL
{
    if (_playerLayer == nil) {
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        [audioSession setActive:YES error:nil];
        // 2.创建AVPlayerItem
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:URL];
        
        // 3.创建AVPlayer
        AVPlayer * player = [AVPlayer playerWithPlayerItem:item];
        
        // 4.添加AVPlayerLayer
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        
        _playerLayer.frame = self.bounds;
        _playerLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//AVLayerVideoGravityResizeAspect;
        [self.layer addSublayer:_playerLayer];
        [player play];
        
        
    }
    return _playerLayer;
}



- (void)dismiss{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame=CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    }completion:^(BOOL finished) {
        [self.playerLayer.player replaceCurrentItemWithPlayerItem:nil];
        [self.playerLayer.player.currentItem cancelPendingSeeks];
        [self.playerLayer.player.currentItem.asset cancelLoading];
        [self.playerLayer.player pause];
        self.playerLayer.player = nil;
        [self.playerLayer removeFromSuperlayer];
        if(self.enterBlock != nil) _enterBlock();
        [self removeFromSuperview];
    }];
   
}


@end
