/*********************************************************************
 *
 * 版权所有：杭州树熊网络有限公司（2015）
 *
 * 文件名称： StorageUtils.h
 *
 * 内容摘要： 简单数据存储，主要是一些键值对存储及系统外部文件的存取，包括对NSUserDefault和plist存取的封装
 *
 * 作   者： 李华光
 *
 * 完成日期： 2015年04月03日
 *
 **********************************************************************/

#import <Foundation/Foundation.h>

@interface StorageUtils : NSObject

+ (StorageUtils*)sharedManager;

// 获得沙箱Document目录下全路径
- (NSString*)applicationDocumentsDirectoryFile:(NSString*)fileName;

- (NSString*)getPlistData:(NSString*)fileName;

- (BOOL)savePlistData:(NSString*)fileName data:(NSString*)data;

- (NSArray*)getPlistArray:(NSString*)fileName;

- (BOOL)savePlistArray:(NSString*)fileName dataArray:(NSArray*)array;

- (NSDictionary*)getPlistDict:(NSString*)fileName;

- (BOOL)savePlistDict:(NSString*)fileName dataDict:(NSDictionary*)dict;

/**
*  保存自定义数据类型到plist文件（类型需要实现NSCoding协议）
*
*  @param fileName
*  @param array
*
*  @return
*/
- (BOOL)saveCustomObjectPlist:(NSString*)fileName andArray:(NSArray*)array;

/**
 *  获取储存的自定义数据类型数据
 *
 *  @param fileName
 *
 *  @return
 */
- (NSArray*)getCustomObjectPlistData:(NSString*)fileName;

- (BOOL)removeItemWithName:(NSString*)fileName;

@end
