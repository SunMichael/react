//
//  AppMacro.h
//  ApManager
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#ifndef ApManager_AppMacro_h
#define ApManager_AppMacro_h

//设备相关的宏
//处理Null字符
#define PASS_NULL_TO_NIL(instance) (([instance isKindOfClass:[NSNull class]]) ? nil : instance)

//设备相关
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kCameraWidth (kScreenWidth * 3 / 4) //相机宽
#define kCameraHeight kCameraWidth //相机长

#define kBatterHeight ([[[UIDevice currentDevice] systemVersion] floatValue]) < (7.0) ? (0.0) : (20.0)
#define kBundleIdentifier [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

#define kDeviceVersion [[UIDevice currentDevice].systemVersion floatValue]

#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//界面相关
#define kHeaderBarHeight 45.0f //子界面顶部bar高度
#define kFooterTabbarHeight 50.0f //底部bar高度
#define navigationBarHeight  65.0f

#define UserCellHeight    45.0f

#define kLineWidth ([[UIScreen mainScreen] scale] >= 2.0 ? 1.0f : 0.5f)
#define RootNavController   (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController


//颜色相关的方法宏
#define GetColorBy(a, b, c) [UIColor colorWithRed:a / 255.0 green:b / 255.0 blue:c / 255.0 alpha:1.0]
#define kRedColor [UIColor colorWithRed:244.0f / 255.0 green:54.0f / 255.0 blue:56.0f / 255.0 alpha:1.0]

#define kBackViewColor   [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.00f]
//#define kPinkColor       [UIColor colorWithRed:240.0f/255.0f green:172.0f/255.0f blue:172.0f/255.0f alpha:1.00f]
#define kPinkColor       [UIColor colorWithRed:1.00f green:0.35f blue:0.59f alpha:1.00f]
#define kGreenColor      [UIColor colorWithRed:114.0f / 255.0 green:204.0f / 255.0 blue:70.0f / 255.0 alpha:1.0]
#define kGrayColor       [UIColor colorWithRed:143.0f/255.0f green:143.0f/255.0f blue:143.0f/255.0f alpha:1.00f]
#define kBlackColor      [UIColor colorWithRed:0.40f green:0.40f blue:0.40f alpha:1.00f]
#define kLineColor       [UIColor colorWithRed:222.0f/255.0f green:222.0f/255.0f blue:222.0f/255.0f alpha:1.00f]
#define kLightGrayColor       [UIColor colorWithRed:222.0f/255.0f green:222.0f/255.0f blue:222.0f/255.0f alpha:1.00f]
#define KOrangeColor     [UIColor colorWithRed:1.00f green:0.54f blue:0.25f alpha:1.00f]

#define kWhiteColor      [UIColor whiteColor]

#define kUnenableBtnColor    [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f]
#define AllBgColor  [UIColor colorWithRed:((float)((0xf0f0f0 & 0xFF0000) >> 16))/255.0 green:((float)((0xf0f0f0 & 0xFF00) >> 8))/255.0 blue:((float)(0xf0f0f0 & 0xFF))/255.0 alpha:1.0]

#define GetImage(name) [UIImage imageNamed:name] //获取图片

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define UIColorFromRGBAndAlpha(rgbValue,alpha) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha]



//字体相关

#define GetFont(a) [UIFont systemFontOfSize:a]


//标记
#define kNoNetworkAlertTag 90001
#define kYOUKEID     @"-1000"



#endif
