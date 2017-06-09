/*********************************************************************
 *
 * 版权所有：杭州树熊网络有限公司（2015）
 *
 * 文件名称： UIColor (BK)
 *
 * 内容摘要： 颜色分类
 *
 * 作   者： 李华光
 *
 * 完成日期： 2015年04月03日
 *
 **********************************************************************/

#import "UIColor+BK.h"

#define DEFAULT_COLOR [UIColor whiteColor]

@implementation UIColor (BK)

// 十六进制颜色转UIColor
+ (UIColor *)colorWithString:(NSString *)colorStr
{
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
    {
        return DEFAULT_COLOR;
    }
    
    if ([cString hasPrefix:@"#FF"])
    {
        cString = [cString substringFromIndex:3];
    }
    else if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6)
    {
        return DEFAULT_COLOR;
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
