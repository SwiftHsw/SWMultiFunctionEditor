//
//  JRSandBoxPath.h
//  crolerView
//
//  Created by 洪建文 on 2018/2/7.
//  Copyright © 2018年 jave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRSandBoxPath : NSObject
// 获取沙盒Document的文件目录
+ (NSString *)getDocumentDirectory;

// 获取沙盒Library的文件目录
+ (NSString *)getLibraryDirectory;

// 获取沙盒Library/Caches的文件目录
+ (NSString *)getCachesDirectory;

// 获取沙盒Preference的文件目录
+ (NSString *)getPreferencePanesDirectory;

// 获取沙盒tmp的文件目录
+ (NSString *)getTmpDirectory;
//创建沙盒文件
+(NSString*)creatDir:(NSSearchPathDirectory)type dir:(NSString*)dirName;
//判断文件是否存在
+(BOOL) isFileExist:(NSString *)fileName;
@end
