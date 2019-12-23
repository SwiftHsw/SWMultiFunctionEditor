//
//  YZNetWorking.h
//  ailixiong
//
//  Created by admin on 2019/3/14.
//  Copyright © 2019年 ileadtek Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZNetWorking : AFHTTPSessionManager

/**
 获取网络请求工具对象

 @return 单例 YZNetWorking对象
 */
+ (YZNetWorking *)getShard;
/**
POST网络请求

 @param urlString 请求url
 @param parameter 参数字典
 @return 信号
 */
- (RACSignal *)postWithURL:(NSString *)urlString withParamater:(NSDictionary *)parameter;
/**
 GET网络请求
 
 @param urlString 请求url
 @param parameter 参数字典
 @return 信号
 */
- (RACSignal *)getWithURL:(NSString *)urlString withParamater:(NSDictionary *)parameter;

/**
 上传图片到服务器

 @param urlString url
 @param parameter 参数
 @param obj 图片
 @param name 文件名称
 @return RACSignal
 */

- (RACSignal *)postImageRequstDataWithURL:(NSString *)urlString withParamater:(NSDictionary *)parameter image:(UIImage*)obj name:(NSString*)name;
/**
 上传视频到服务器
 
 @param urlString url
 @param parameter 参数
 @param obj 数据流
 @return RACSignal
 */
- (RACSignal *)postVideoRequstDataWithURL:(NSString *)urlString withParamater:(NSDictionary *)parameter data:(NSData*)obj;


- (RACSignal *)postRequstDataWithURL:(NSString *)urlString withParamater:(NSDictionary *)parameter;

@end


