/*********************************************************************
 *
 * 版权所有：杭州树熊网络有限公司（2015）
 *
 * 文件名称： StorageUtils.m
 *
 * 内容摘要： 简单数据存储，主要是一些键值对存储及系统外部文件的存取，包括对NSUserDefault和plist存取的封装
 *
 * 作   者： 李华光
 *
 * 完成日期： 2015年04月03日
 *
 **********************************************************************/

#import "StorageUtils.h"

static StorageUtils* g_storage = nil;

@implementation StorageUtils

+ (StorageUtils*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        g_storage = [[super alloc] init];
    });
    return g_storage;
}

- (NSString*)applicationDocumentsDirectoryFile:(NSString*)fileName
{

    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* path = [documentDirectory stringByAppendingPathComponent:fileName];

    return path;
}

- (NSString*)getPlistData:(NSString*)fileName
{
    NSString* filePath = [self applicationDocumentsDirectoryFile:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSString* data = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        return data;
    }
    else {
        //文件不存在，则创建
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        return nil;
    }
}

- (BOOL)savePlistData:(NSString*)fileName data:(NSString*)data
{
    NSString* filePath = [self applicationDocumentsDirectoryFile:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        BOOL isSave = [data writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        return isSave;
    }
    else {
        //文件不存在，则创建
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        BOOL isSave = [data writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        return isSave;
    }
}

- (NSArray*)getPlistArray:(NSString*)fileName
{
    NSString* filePath = [self applicationDocumentsDirectoryFile:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray* dataArr = [[NSArray alloc] initWithContentsOfFile:filePath];
        return dataArr;
    }
    else {
        //文件不存在，则创建
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        return nil;
    }
}

- (BOOL)savePlistArray:(NSString*)fileName dataArray:(NSArray*)array
{
    NSString* filePath = [self applicationDocumentsDirectoryFile:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        BOOL isSave = [array writeToFile:filePath atomically:YES];
        return isSave;
    }
    else {
        //文件不存在，则创建
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        BOOL isSave = [array writeToFile:filePath atomically:YES];
        return isSave;
    }
}

- (NSDictionary*)getPlistDict:(NSString*)fileName
{
    NSString* filePath = [self applicationDocumentsDirectoryFile:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSDictionary* dataDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        return dataDict;
    }
    else {
        //文件不存在，则创建
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        return nil;
    }
}

- (BOOL)savePlistDict:(NSString*)fileName dataDict:(NSDictionary*)dict
{
    NSString* filePath = [self applicationDocumentsDirectoryFile:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        BOOL isSave = [dict writeToFile:filePath atomically:YES];
        return isSave;
    }
    else {
        //文件不存在，则创建
        //[[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        BOOL isSave = [dict writeToFile:filePath atomically:YES];
        return isSave;
    }
}
/**
 *  保存自定义数据类型到plist文件（类型需要实现NSCoding协议）
 *
 *  @param fileName
 *  @param array
 *
 *  @return
 */
- (BOOL)saveCustomObjectPlist:(NSString*)fileName andArray:(NSArray*)array;
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:array];
    NSString* filePath = [self applicationDocumentsDirectoryFile:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        BOOL isSave = [data writeToFile:filePath atomically:YES];
        return isSave;
    }
    else {
        //文件不存在，则创建
        BOOL isSave = [data writeToFile:filePath atomically:YES];
        return isSave;
    }
}

/**
*  获取储存的自定义数据类型数据
*
*  @param fileName
*
*  @return
*/
- (NSArray*)getCustomObjectPlistData:(NSString*)fileName
{
    NSString* filePath = [self applicationDocumentsDirectoryFile:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData* data = [NSData dataWithContentsOfFile:fileName];
        NSArray* dataArr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return dataArr;
    }
    else {
        //文件不存在，则创建
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        return nil;
    }
}

- (BOOL)removeItemWithName:(NSString*)fileName
{
    NSString* filePath = [self applicationDocumentsDirectoryFile:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    else {
        return NO;
    }
}

@end
