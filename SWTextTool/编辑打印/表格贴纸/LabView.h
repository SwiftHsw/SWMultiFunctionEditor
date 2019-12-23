//
//  LabView.h
//  GYStickerViewDemo
//
//  Created by admin on 2019/7/13.
//  Copyright © 2019年 HuangGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWPickViewModel.h"
#import "YZChatInputView.h"

NS_ASSUME_NONNULL_BEGIN
 
@interface LabView : UIView<YZChatInputViewDelegate>

@property (nonatomic , strong)CAShapeLayer *border;


/// 创建表格
/// @param frame 坐标
/// @param boderType 边框布局
/// @param fromType 表格布局
/// @param rowNum 行数
/// @param colNum 列数
-(id)initWithFrame:(CGRect)frame
       boderLayout:(SWPickViewModel*)boderType
        fromLayout:(SWPickViewModel*)fromType
               row:(NSInteger)rowNum
               col:(NSInteger)colNum;

/// 更新样式
/// @param dict 样式信息
-(void)updateStyle:(NSDictionary*)dict;


@end

NS_ASSUME_NONNULL_END
