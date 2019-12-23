//
//  SWViewFontModel.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWViewFontModel : NSObject
//文字大小
@property (nonatomic  ,assign)CGFloat fontSize;
//字体
@property (nonatomic  ,strong)UIFont * font;
//文字
@property (nonatomic  ,copy)NSString * text;
//字体包
@property (nonatomic  ,copy)NSString * fontName;
//是否加粗
@property (nonatomic  ,assign)BOOL  bold;
//是否斜体
@property (nonatomic  ,assign)BOOL  italic;
//是否加下划线
@property (nonatomic  ,assign)BOOL  underLine;
//剧中样式
@property (nonatomic  ,assign)NSTextAlignment  aligment;
//行间距
@property (nonatomic  ,assign)CGFloat  rowSpace;
@end

NS_ASSUME_NONNULL_END
