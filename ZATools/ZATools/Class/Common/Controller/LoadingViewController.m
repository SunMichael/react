//
//  LoadingViewController.m
//  ApManager
//
//  Created by zjjllj on 16/4/15.
//  Copyright © 2016年 treebear. All rights reserved.
//

#import "AppDelegate.h"
#import "IntroPage.h"
#import "IntroPageView.h"
#import "YzjNavigationController.h"
#import "YzjTabbarController.h"
#import "LoadingViewController.h"
#import "UIImage+ColorToImage.h"

@interface LoadingViewController () {
    BOOL isFirstLanunch;
    NSTimer* _overtimer;
}

@property (nonatomic, strong) UIButton* skipButton;
@property (nonatomic, strong) UIImageView* adImageView;

@end

static NSString* const kAdImageName = @"adImage";

@implementation LoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView* superView = self.view;
    [self setNeedsStatusBarAppearanceUpdate];
    
    isFirstLanunch = [[IvyUserDefaults shareUserDefaults] getIsFirstLaunch];
    // 判断是否有更新或第一次登录
    NSString* oldVersion = [[IvyUserDefaults shareUserDefaults] getCurrentVersion];
    if (!oldVersion || ![oldVersion isEqualToString:kAppVersion]) {
        isFirstLanunch = NO;
        [[IvyUserDefaults shareUserDefaults] setCurrentVersion:kAppVersion];
    }
    
    if (!isFirstLanunch) {
        IntroPage* page1 = [[IntroPage alloc] init];
        IntroPage* page2 = [[IntroPage alloc] init];
        IntroPage* page3 = [[IntroPage alloc] init];
        
        page1.bgImage = GetImage(@"guideImage1");
        page2.bgImage = GetImage(@"guideImage2");
        page3.bgImage = GetImage(@"guideImage3");
        
        IntroPageView* pageView = [[IntroPageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight) andPages:@[ page1, page2, page3 ] andFinished:^{
            [self changeToRootViewController];
        }];
        [self.view addSubview:pageView];
        
    }
    else {
        UIImage* adImage = [UIImage imageNamed:kAdImageName];
        if (!adImage) {
            //无广告图片则跳转
            [self changeToRootViewController];
            return;
        }
        
        NSString* documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        UIImage* adNewImage = [self loadImage:kAdImageName ofType:@"png" inDirectory:documentsDirectoryPath];
        if (adNewImage) {
            adImage = adNewImage;
        }
        
        _adImageView = [[UIImageView alloc] init];
        _adImageView.image = adImage;
        [superView addSubview:_adImageView];
        
        _skipButton = [[UIButton alloc] init];
        [_skipButton setTitle:@"5 跳过" forState:UIControlStateNormal];
        [_skipButton setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]] forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _skipButton.layer.masksToBounds = YES;
        _skipButton.layer.cornerRadius = 5.0f;
        [superView addSubview:_skipButton];
        
        _skipButton.frame = CGRectMake(kScreenWidth - 80.0f, 30.0f, 60.0f, 40.0f);
        _overtimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timerRepeatDo) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_overtimer forMode:NSRunLoopCommonModes];
    }
    [self downloadNewImage];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    //隐藏工具栏
    return YES;
}

- (void)buttonClick:(UIButton*)button
{
    if (_overtimer) {
        [_overtimer invalidate];
        _overtimer = nil;
    }
    [self changeToRootViewController];
}

- (void)timerRepeatDo
{
    static NSUInteger times = 5;
    if (times == 0) {
        if (_overtimer) {
            [_overtimer invalidate];
            _overtimer = nil;
        }
        times = 5;
        [self changeToRootViewController];
    }
    else {
        [_skipButton setTitle:[NSString stringWithFormat:@"%ld 跳过", (unsigned long)times--] forState:UIControlStateNormal];
    }
}

- (void)changeToRootViewController
{
    YzjTabbarController* tabbarCtr = [[YzjTabbarController alloc] initWithNibName:nil bundle:nil];
    YzjNavigationController* navigationCtr = [[YzjNavigationController alloc] initWithRootViewController:tabbarCtr];
    
//    AppDelegate* appdel = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [appdel replaceRootViewController:navigationCtr animationOptions:UIViewAnimationOptionTransitionCrossDissolve];
}

- (UIImage*)getImageFromURL:(NSString*)fileURL
{
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    return [UIImage imageWithData:data];
}

- (void)saveImage:(UIImage*)image withFileName:(NSString*)imageName ofType:(NSString*)extension inDirectory:(NSString*)directoryPath
{
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    }
    else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    }
    else {
        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
        NSLog(@"文件后缀不认识");
    }
}

- (UIImage*)loadImage:(NSString*)fileName ofType:(NSString*)extension inDirectory:(NSString*)directoryPath
{
    UIImage* result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    
    return result;
}

- (void)downloadNewImage
{
    if (!_downloadUrl) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString* documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            
            UIImage* newAdImage = [self getImageFromURL:_downloadUrl];
            [self saveImage:newAdImage withFileName:@"adImage" ofType:@"png" inDirectory:documentsDirectoryPath];
            
        });
    }
}

@end
