//
//  JRSandBoxPath.m
//  crolerView
//
//  Created by 洪建文 on 2018/2/7.
//  Copyright © 2018年 jave. All rights reserved.
//

#import "JRSandBoxPath.h"

@implementation JRSandBoxPath
#pragma mark - 获取沙盒Document的文件目录
+ (NSString *)getDocumentDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒Library的文件目录
+ (NSString *)getLibraryDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒Library/Caches的文件目录
+ (NSString *)getCachesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒Preference的文件目录
+ (NSString *)getPreferencePanesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒tmp的文件目录
+ (NSString *)getTmpDirectory{
    return NSTemporaryDirectory();
}
#pragma mark -创建沙盒文件夹
+(NSString*)creatDir:(NSSearchPathDirectory)type dir:(NSString*)dirName{
    
   
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(type, NSUserDomainMask,YES)lastObject];
    
    NSString *File1Path = [documentsPath stringByAppendingPathComponent:dirName];
    
    BOOL isHave = [fileManage fileExistsAtPath:File1Path];
    
    if (isHave) {
        
//        NSLog(@"文件已存在");
        
    }else{
        
//        NSLog(@"文件不存在");
        
        BOOL isSuccess = [fileManage createDirectoryAtPath:File1Path withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSLog(@"%@",isSuccess ? @"创建成功" : @"创建失败");
        
    }
    
    return File1Path;
    
}
+(BOOL) isFileExist:(NSString *)fileName
{
    NSString *path=[JRSandBoxPath getDocumentDirectory];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    
//    NSLog(@"文件=%@",filePath);
//    NSLog(@"是否存在文件%d",result);
    return result;
}

@end
