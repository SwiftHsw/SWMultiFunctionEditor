//
//  SWFontModel.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFontModel.h"

@implementation SWFontModel
///下载字体
-(void)downLoadFont{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:self.file_ttf parameters:nil error:nil];
    [request setValue:@"identity" forHTTPHeaderField:@"Accept-Encoding"];
    SWWeakSelf(self);
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        CGFloat x = 100.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([weakself.delegate respondsToSelector:@selector(downloadItem:totalBytesWritten:totalBytesExpectedToWrite:)]) {
                [weakself.delegate downloadItem:weakself totalBytesWritten:downloadProgress.completedUnitCount totalBytesExpectedToWrite:downloadProgress.totalUnitCount];
                weakself.countOfBytesExpectedToReceive = x;
                weakself.status = SWDownload_Status_downloading;
                
                if ([weakself.delegate respondsToSelector:@selector(downloadBegin:)] && x>0) {
                    [weakself.delegate downloadBegin:weakself];
                }

            }
            
        });
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        ///存储本地
        NSURL *path =  [NSURL fileURLWithPath:[JRSandBoxPath getDocumentDirectory]];
          path = [path URLByAppendingPathComponent:FontName];
          path = [path URLByAppendingPathComponent:weakself.name];
        return path;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (!error) {
             weakself.status = SWDownload_Status_complete;
            
        }else{
             weakself.status = SWDownload_Status_fail;
        }
        weakself.countOfBytesExpectedToReceive = 0;
        if ([weakself.delegate respondsToSelector:@selector(downloadEnd:)]) {
            [weakself.delegate downloadEnd:!error?YES:NO];
        }
        NSLog(@"%@",error);
    }];
    [downloadTask resume];
    
}
@end
