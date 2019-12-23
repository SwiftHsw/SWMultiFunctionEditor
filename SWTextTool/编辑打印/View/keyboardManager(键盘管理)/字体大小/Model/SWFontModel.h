//
//  SWFontModel.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import <Foundation/Foundation.h>



@class SWFontModel;
@protocol SWFontModelDelegate <NSObject>

///开始下载
- (void)downloadBegin:(SWFontModel *)item;

///点击下载
- (void)downloadItem:(SWFontModel *)item totalBytesWritten:(CGFloat)totalBytesWritten totalBytesExpectedToWrite:(CGFloat)totalBytesExpectedToWrite;
///下载结束
- (void)downloadEnd:(BOOL)isOk;
@end

  
@interface SWFontModel : NSObject
@property (nonatomic , copy)NSString * name;

@property (nonatomic , copy)NSString * image;

@property (nonatomic , copy)NSString * file_ttf;

@property (nonatomic , copy)NSString * create_time;

@property (nonatomic , assign)SWDownload_Status  status;

@property (nonatomic , assign)BOOL  isSelect;

@property (nonatomic , assign)CGFloat  progress;

@property (nonatomic,assign) CGFloat countOfBytesExpectedToReceive;

@property (nonatomic , assign)CGFloat  donwLoadValue;
///下载字体
-(void)downLoadFont;


@property (nonatomic , weak)id<SWFontModelDelegate>  delegate;

@end

 
