//
//  Other.h
//  Printer
//
//  Created by admin on 2019/7/27.
//  Copyright © 2019年 admin. All rights reserved.
//

#ifndef Other_h
#define Other_h
 
 
typedef NS_ENUM(NSInteger,SWDownload_Status) {
    SWDownload_Status_wait,//已启动但处于等待状态
    SWDownload_Status_downloading,//正在下载
    SWDownload_Status_suspended,//暂停(当App重新启动后、所有未完成任务将被置为暂停状态)
    SWDownload_Status_fail,//失败
    SWDownload_Status_complete//完成
};


typedef NS_ENUM(NSInteger,SWFontFormatterType) {
    Font_Bold=0,//加粗
    Font_Italic=1,//斜体
    Font_Unline=2,//下滑线
    
};

typedef NS_ENUM(NSInteger,SWFontTextAligementType) {
    Font_Left=0,//右对齐
    Font_Center=1,//剧中
    Font_Right=2,//左对齐
};

#endif /* Other_h */
