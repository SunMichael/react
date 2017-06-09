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

#import "NSString+BK.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (BK)

+ (NSString*)convertNullOrNil:(NSString*)str
{
    if ([str isEqual:[NSNull null]]) {
        return @"";
    }
    else if ([str isKindOfClass:[NSNull class]]) {
        return @"";
    }
    else if (str == nil) {
        return @"";
    }
    return str;
}

+ (NSString*)stringFromDate:(NSDate*)date formatter:(NSString*)formatter
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* zone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:zone];
    [dateFormatter setDateFormat:formatter];
    
    return [dateFormatter stringFromDate:date];
}

+ (NSDate*)dateFromString:(NSString*)dateString formatter:(NSString*)formatter;
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* zone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:zone];
    [dateFormatter setDateFormat:formatter];
    
    return [dateFormatter dateFromString:dateString];
}

+ (BOOL)isValidatePhoneNumber:(NSString*)phoneNumber
{
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    //    NSString * regexp = @"^(0[0-9]{2,3}\\-)?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?$";
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //    NSPredicate *regextestRegexp = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    //    BOOL res1 = [regextestmobile evaluateWithObject:phoneNumber];
    //    BOOL res2 = [regextestcm evaluateWithObject:phoneNumber];
    //    BOOL res3 = [regextestcu evaluateWithObject:phoneNumber];
    //    BOOL res4 = [regextestct evaluateWithObject:phoneNumber];
    //    BOOL res5 = [regextestRegexp evaluateWithObject:phoneNumber];
    //
    //    if (res1 || res2 || res3 || res4 || res5)
    //    {
    //        return YES;
    //    }
    //    else
    //    {
    //        return NO;
    //    }
    
    //手机号判断1开头，11位，纯数字
    if ([phoneNumber hasPrefix:@"1"] && phoneNumber.length == 11 && [NSString isPureInt:phoneNumber]) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL)isValidateEmail:(NSString*)email
{
    NSString* emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//序列化JSON
+ (NSString*)serializeMessage:(id)message
{
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:message options:0 error:nil] encoding:NSUTF8StringEncoding];
}

//反序列化JSON
+ (id)deserializeMessageJSON:(NSString*)messageJSON
{
    if (messageJSON) {
        return [NSJSONSerialization JSONObjectWithData:[messageJSON dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    }
    return nil;
}

/**
 *  判断NSString是否为空
 *
 */
+ (BOOL)isEmply:(NSString*)str
{
    if (str == nil || [@"" isEqualToString:str] || [str isKindOfClass:[NSNull class]] || [@" " isEqualToString:str] || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return true;
    }
    return false;
}

// 检查密码是否合法
+ (BOOL)isValidateLoginCode:(NSString*)code
{
    NSInteger length = code.length;
    BOOL isChinese = NO;
    for (int i = 0; i < length; ++i) {
        NSRange range = NSMakeRange(i, 1);
        NSString* subString = [code substringWithRange:range];
        const char* cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            isChinese = YES;
            break;
        }
    }
    
    NSString* tab = @" ";
    NSRange found = [code rangeOfString:tab];
    //密码长度6-22位  没中文字符  没空格
    if (code.length >= 6 && code.length <= 22 && found.length == 0 && !isChinese) {
        return YES;
    }
    return NO;
}

+ (NSString*)getDateStringBy:(long long)time
{
    NSString* str = [NSString stringWithFormat:@"%lld", time]; //时间戳
    NSTimeInterval time2 = [str doubleValue] / 1000;
    NSDate* detaildate = [NSDate dateWithTimeIntervalSince1970:time2];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString* currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}


+ (NSString*)getdateStringByDate:(NSDate*)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString* currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}

+ (NSDate*)getCurrentDate
{
    NSDate* date = [NSDate date];
    NSTimeZone* zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSLog(@" %ld ", (long)interval);
    NSDate* localeDate;
    //    = [date  dateByAddingTimeInterval: interval];
    localeDate = [date dateByAddingTimeInterval:-24 * 3600];
    return localeDate;
}

+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSArray*)words
{
#if !__has_feature(objc_arc)
    NSMutableArray* words = [[[NSMutableArray alloc] init] autorelease];
#else
    NSMutableArray* words = [[NSMutableArray alloc] init];
#endif
    
    const char* str = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    char* word;
    for (int i = 0; i < strlen(str);) {
        int len = 0;
        if (str[i] >= 0xFFFFFFFC) {
            len = 6;
        }
        else if (str[i] >= 0xFFFFFFF8) {
            len = 5;
        }
        else if (str[i] >= 0xFFFFFFF0) {
            len = 4;
        }
        else if (str[i] >= 0xFFFFFFE0) {
            len = 3;
        }
        else if (str[i] >= 0xFFFFFFC0) {
            len = 2;
        }
        else if (str[i] >= 0x00) {
            len = 1;
        }
        
        word = malloc(sizeof(char) * (len + 1));
        for (int j = 0; j < len; j++) {
            word[j] = str[j + i];
        }
        word[len] = '\0';
        i = i + len;
        
        NSString* oneWord = [NSString stringWithCString:word encoding:NSUTF8StringEncoding];
        free(word);
        [words addObject:oneWord];
    }
    
    return words;
}

+ (NSString*)filterHTML:(NSString*)html
{
    NSScanner* scanner = [NSScanner scannerWithString:html];
    NSString* text = nil;
    while ([scanner isAtEnd] == NO) {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    // NSString * regEx = @"<([^>]*)>";
    // html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

+(CGFloat)getStringWidth:(NSString *)str font:(UIFont *)font limitHeight:(CGFloat)height
{
    if (str==nil || str.length==0) {
        return 0;
    }
    
    CGSize size=[str  boundingRectWithSize:CGSizeMake(1000, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.width;
    
    
}
+(CGFloat)getStringheight:(NSString *)str font:(UIFont *)font limitWidth:(CGFloat)Width
{
    if (str==nil || str.length==0) {
        return 0;
    }
    
    CGSize size=[str  boundingRectWithSize:CGSizeMake(Width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.height;
}

+ (NSString *)doFileMD5:(NSString *)filePath
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if (filePath == nil || [filePath length] == 0) {
        return nil;
    }
    
    /*
     NSError *error;
     NSData *fileData =[NSData dataWithContentsOfFile:filePath options:0 error:&error];
     
     const char *cStr = [fileData bytes];
     unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
     CC_MD5(cStr, (CC_LONG)strlen(cStr), outputBuffer);
     */
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        NSData *fileData = [handle readDataOfLength: UINT_MAX ];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if([fileData length] == 0) {
            done = YES;
        }
    }
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(outputBuffer, &md5);
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [output appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return output;
}

+(NSString *)changeMoneyFormatter:(NSString *)string{
    NSString *zStr = @"";
    NSString *xStr = @"";
    if ([string rangeOfString:@"."].location != NSNotFound) {
        NSArray *ary = [string componentsSeparatedByString:@"."];
        zStr = ary[0];
        xStr = ary[1];
    }else{
        zStr = string;
    }
    if ([NSString isEmply:zStr]) {
        return string;
    }
    NSMutableString *mString = [NSMutableString stringWithString:zStr];
    NSInteger num = mString.length/ 3;
    for (int i = 1; i <= num; i++) {
        if (mString.length - i*3 > 0) {
            [mString insertString:@"," atIndex:(mString.length - i*3)];
        }
    }
    if( xStr.length == 0 ){
        return mString;
    }else{
        [mString appendString:[NSString stringWithFormat:@".%@",xStr]];
        return mString;
    }
}

+ (NSString *)encodeToPercentEscapeString:(NSString *)input
{
    NSString*
    outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                             
                                                                             NULL, /* allocator */
                                                                             
                                                                             (__bridge CFStringRef)input,
                                                                             
                                                                             NULL, /* charactersToLeaveUnescaped */
                                                                             
                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                             
                                                                             kCFStringEncodingUTF8);
    
    
    return outputStr;
}


@end
