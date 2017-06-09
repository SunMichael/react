//
//  UIImage+ColorToImage.h
//  Ivy
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorToImage)

/**
*  将颜色转成图片
*
*  @param color 颜色
*
*  @return 图片
*/
+(UIImage *)createImageWithColor:(UIColor *)color;



/**
*  模糊图片
*
*  @param image 图片
*  @param level 程度
*
*/
+(UIImage *)blurryImage:(UIImage *)image withBlurryLevel:(float)level;



/**
 *  将彩色图片变黑白
 *
 *  @param sourceImage 彩色图
 *
 *  @return 黑白图
 */
+ (UIImage*)getGrayImage:(UIImage*)sourceImage;

/**
 *  获取启动页
 *
 *  @return
 */
+ (UIImage*)getLaunchImage;

/**
 *  先收缩图片后对图片进行高度裁剪
 *
 *  @param image 原始图片
 *  @param size  组件的大小
 *
 */
+(UIImage *)imageWithCutImage:(UIImage *)image moduleSize:(CGSize)size;

@end
