//
//  UIImage+ColorToImage.m
//  Ivy
//
//  Created by mac on 15/6/2.
//  Copyright (c) 2015年 treebear. All rights reserved.
//

#import "UIImage+ColorToImage.h"

#define CurrentWindow [[UIApplication sharedApplication].windows firstObject]

@implementation UIImage (ColorToImage)
/**
 *  将颜色转成图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+(UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *colorImg = UIGraphicsGetImageFromCurrentImageContext();
    return colorImg;
}


/**
 *  模糊图片
 *
 *  @param image 图片
 *  @param level 程度
 *
 */
+(UIImage *)blurryImage:(UIImage *)image withBlurryLevel:(float)level{
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey, inputImage,@"inputRadius", @(level), nil];
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    return [UIImage imageWithCGImage:outImage];
}

/**
 *  将彩色图片变黑白
 *
 *  @param sourceImage 彩色图
 *
 *  @return 黑白图
 */
+ (UIImage*)getGrayImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGBitmapByteOrderDefault);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:grayImageRef];
    CGContextRelease(context);
    CGImageRelease(grayImageRef);
    
    return grayImage;
}

/**
 *  获取启动页
 *
 *  @return
 */
+ (UIImage*)getLaunchImage{
    return [UIImage imageNamed:[self getLaunchImageName]];
}


+ (NSString*)getLaunchImageName
{
    NSString* viewOrientation = @"Portrait";
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        viewOrientation = @"Landscape";
    }
    NSString* launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    CGSize viewSize = CurrentWindow.bounds.size;
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}


/**
 *  先收缩图片后对图片进行高度裁剪
 *
 *  @param image 原始图片
 *  @param size  组件的大小
 *
 */
+(UIImage *)imageWithCutImage:(UIImage *)image moduleSize:(CGSize)size{
    float scale = [UIScreen mainScreen].scale;
    if (image.size.width < size.width && image.size.height < size.height) {
        return image;
    }
    
    float newWidth = 0.0f;
    float newHeight = 0.0f;
    //先判断收缩是以宽为主还是以高为主
    if ((image.size.height/2 - size.height/2) > (image.size.width/2 - size.width/2)) {
        newHeight = size.width/image.size.width *image.size.height;
        newWidth = size.width;
    }
    else{
        newHeight = size.height;
        newWidth = size.height/image.size.height * image.size.width;
    }
    
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (newImage.size.height < size.height || newImage.size.width < size.width) {
        return newImage;
    }
    //如果收缩的图比要求大小还要大就取中间部分
    CGImageRef imageRef = newImage.CGImage;
    CGRect rect = CGRectMake(newImage.size.width/2 - size.width/2, newImage.size.height/2 - size.height/2, size.width * scale, size.height * scale);
    CGImageRef cutImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *cutImage = [UIImage imageWithCGImage:cutImageRef scale:scale orientation:UIImageOrientationUp];
    
    CGImageRelease(cutImageRef);
    newImage = nil;
    return cutImage;
    
}



@end
