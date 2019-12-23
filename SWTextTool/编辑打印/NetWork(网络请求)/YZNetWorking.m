//
//  YZNetWorking.m
//  ailixiong
//
//  Created by admin on 2019/3/14.
//  Copyright © 2019年 ileadtek Co.,Ltd. All rights reserved.
//

#import "YZNetWorking.h"
#import <AdSupport/AdSupport.h>
@implementation YZNetWorking
//单列属性
static YZNetWorking * shard;

//单列类的创建
+ (YZNetWorking *)getShard
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shard = [[YZNetWorking alloc]init];
        shard.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"charset=utf-8",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/plain", nil];
        shard.requestSerializer.timeoutInterval = 40;
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        [shard.requestSerializer setValue:appCurVersion forHTTPHeaderField:@"version"];
        [shard.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"platform"];
        [shard.requestSerializer setValue:@"Accept-Encoding" forHTTPHeaderField:@"identity"];
//    shard.requestSerializer.
//        Request.Builder().addHeader(“Accept-Encoding”, “identity”)解决下载字体文件获取不到总大小
    });
    
    return shard;
    
}
- (RACSignal *)postWithURL:(NSString *)urlString withParamater:(NSDictionary *)parameter
{
    NSLog(@"--url--%@", urlString);
    NSLog(@"--参数值:---%@", parameter);
    
    RACSubject *sub =[ RACSubject subject];
    [shard POST:urlString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [sub sendNext:responseObject];
        [sub sendCompleted];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        @strongify(self);
//        SHOW_SVP(@"");
//        [sub sendNext:@{@"code":@-400}];
//        [sub sendCompleted];
//          SHOW_ERROE(@"请求超时");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            SHOW_ERROE(@"请求超时");
        });
        
    }];
    return sub;
}
- (RACSignal *)getWithURL:(NSString *)urlString withParamater:(NSDictionary *)parameter
{
    //    NSLog(@"%@")
//    NSLog(@"参数=%@url=%@", parameter,urlString);
    RACSubject *sub =[ RACSubject subject];
    [shard GET:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [sub sendNext:responseObject];
        [sub sendCompleted];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        SHOW_ERROE([NSString stringWithFormat:@"%d",error._code]);
//        [sub sendNext:@{@"code":@-400}];
//        [sub sendCompleted];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//               SHOW_ERROE(@"请求超时");
        });
     
    }];
    return sub;
}
- (RACSignal *)postImageRequstDataWithURL:(NSString *)urlString withParamater:(NSDictionary *)parameter image:(UIImage*)obj name:(NSString*)name{
    RACSubject *sub =[ RACSubject subject];
    [shard POST:urlString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData*imageData =UIImageJPEGRepresentation(obj,0.5);
        
        NSString * fileName = [shard getFileName:@"png"];
    
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
         
                                    name:name
    
                                fileName:fileName
         
                                mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [sub sendNext:responseObject];
        [sub sendCompleted];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败%@",error);
        [sub sendNext:nil];
         [sub sendCompleted];
    }];
    return sub;
}

- (RACSignal *)postVideoRequstDataWithURL:(NSString *)urlString withParamater:(NSDictionary *)parameter data:(NSData*)obj{
    RACSubject *sub =[ RACSubject subject];
    [shard POST:urlString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData*imageData =UIImageJPEGRepresentation(obj,0.5);
        
        NSString * fileName = [shard getFileName:@"mp4"];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:obj
         
                                    name:@"file"
         
                                fileName:fileName
         
                                mimeType:@"application/octet-stream"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
       [sub sendNext:uploadProgress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        [sub sendCompleted];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败%@",error);
    }];
    return sub;
}


- (RACSignal *)postRequstDataWithURL:(NSString *)urlString withParamater:(NSDictionary *)parameter
{
    RACSubject *sub =[ RACSubject subject];
    NSDictionary *body = parameter;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSString *url = urlString;
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[shard dataTaskWithRequest:req uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            [sub sendNext:responseObject];
            [sub sendCompleted];
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//              SHOW_ERROE(@"请求超时");
            });
            
        }
        
        
    }]resume];
    
    return sub;
}

/**
 获取时间为上传文件名称

 @param suffix 后缀
 */
-(NSString*)getFileName:(NSString*)suffix{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyyMMddHHmmss";
    NSString*str=[formatter stringFromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%@.%@",str,suffix];
    
}
@end
