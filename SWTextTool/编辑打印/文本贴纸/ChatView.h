//
//  ChatView.h
//  GYStickerViewDemo
//
//  Created by admin on 2019/7/27.
//  Copyright © 2019年 HuangGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZChatInputView.h"
#import "SWEditorBorderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChatView : UILabel<UITextViewDelegate,YZChatInputViewDelegate>
//+ (instancetype)getChatView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *textLable;


@property (nonatomic, strong) UITextView * textView;

@property (nonatomic, strong)YZChatInputView * inputView;


- (void)setContentText:(NSString *)text;

/// 设置内容
/// @param image 图片
/// @param model 模型信息
-(void)setingLableAndImage:(UIImage*)image info:(SWEditorBorderModel*)model;

@end

NS_ASSUME_NONNULL_END
