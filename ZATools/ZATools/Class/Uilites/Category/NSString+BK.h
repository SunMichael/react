/*********************************************************************
 *
 * 版权所有：杭州树熊网络有限公司（2015）
 *
 * 文件名称： NSString (BK)
 *
 * 内容摘要： 字符串分类
 *
 * 作   者： 李华光
 *
 * 完成日期： 2015年04月03日
 *
 **********************************************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (BK)

// 处理空字符串
+ (NSString *)convertNullOrNil:(NSString *)str;

// 根据指定格式将 NSDate 转换为 NSString
+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter;

// 根据指定格式将 NSString 转换为 NSDate
+ (NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter;

// 验证手机号码合法性（正则）
+ (BOOL)isValidatePhoneNumber:(NSString *)phoneNumber;

// 验证邮箱合法性（正则）
+ (BOOL)isValidateEmail:(NSString *)email;

// 序列化JSON
+ (NSString *)serializeMessage:(id)message;

// 反序列化JSON
+ (id)deserializeMessageJSON:(NSString *)messageJSON;

// 是否为空
+(BOOL)isEmply:(NSString *)str;


// 检查密码是否合法
+(BOOL) isValidateLoginCode:(NSString *)code;

// 时间戳转时间
+ (NSString *)getDateStringBy:(long long)time;


+ (NSString *)getdateStringByDate:(NSDate *)date;
+ (NSDate *)getCurrentDate;

+ (BOOL)isPureInt:(NSString*)string;

//字符串中每个字符
- (NSArray *)words;

+ (NSString *)filterHTML:(NSString *)html;

+ (CGFloat)getStringWidth:(NSString *)str font:(UIFont *)font limitHeight:(CGFloat)height;
+ (CGFloat)getStringheight:(NSString *)str font:(UIFont *)font limitWidth:(CGFloat)Width;

+ (NSString *)doFileMD5:(NSString *)filePath;


+ (NSString *)changeMoneyFormatter:(NSString *)string;
+ (NSString *)encodeToPercentEscapeString:(NSString *)input;

@end
