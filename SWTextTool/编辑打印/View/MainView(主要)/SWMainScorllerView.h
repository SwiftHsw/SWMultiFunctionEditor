//
//  SWMainScorllerView.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWBaseTextView.h"
#import "SWEditorBorderModel.h"
#import "GYStickerView.h"
//主空间
NS_ASSUME_NONNULL_BEGIN
@class GYStickerView;

@interface SWMainScorllerView : UIScrollView

 @property (nonatomic,strong) GYStickerView * oldStickerView;

/**
 总输入框
 */
@property (nonatomic,strong) SWBaseTextView *inputTextView;
/**
 主题顶部图片
 */
@property (nonatomic , strong)UIImageView * topBoder;
/**
 主题中间图片
 */
@property (nonatomic , strong)UIImageView *  centerBoder;
/**
 主题底部图片
 */
@property (nonatomic , strong)UIImageView *  bottomBoder;

/**
选中一个贴纸

@param sticker 贴纸
 @param show 是否显示按钮（贴纸大于1）
*/

@property (nonatomic,copy) void (^selectCurrentStickerBlock)(GYStickerView *sticker,BOOL isShowButton);


///键盘隐藏更新坐标（外部调用）
-(void)keyBoardShowUpatafram:(CGFloat)keyBoderHeight;

///键盘隐藏的更新（外部调用）
-(void)keyBoardHidenpatafram:(CGFloat)keyBoderHeight;

/**
 生产文本贴纸
 
 @param text 文本内容
 @param image 图片
 */
-(void)creatTextStickers:(NSString*)text
                   image:(UIImage*)image
               infoModel:(SWEditorBorderModel*)model;


/**
 生成贴纸

 @param contentView 贴纸内容
 */
- (void)addStickerViewWithContentView:(UIView *)contentView;
///修改字体大小
/// @param fontSize 大小
- (void)changeTheFontSize:(CGFloat)fontSize;

///修改字体样式
/// @param fontName 样式
- (void)changeFontStyle:(NSString *)fontName;

/// 修改字体格式
/// @param dict 信息
-(void)changTextFomatter:(NSDictionary*)dict;

/// 修改字体对齐
/// @param dict 信息
-(void)textAligement:(NSDictionary*)dict;

/// 修改字体间距
/// @param row 间距
-(void)textSpaceNum:(CGFloat)row;


/// 创建主题边框
/// @param dict 边框信息
-(void)creatTheme:(NSDictionary*)dict;

/**
 创建一个表情
 
 @param img 配置内容
 */
- (void)creatEmojiStickers:(UIImage*)img;

/// 创建图片
/// @param info 图片模型数组
- (void)creatImages:(NSArray*)info;


@end

NS_ASSUME_NONNULL_END
