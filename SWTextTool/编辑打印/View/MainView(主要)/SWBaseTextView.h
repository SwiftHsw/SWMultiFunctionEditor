//
//  SWBaseTextView.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^limitBlock)(void);

@interface SWBaseTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString  *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

/** 限制的字符 */
@property (nonatomic, assign) NSInteger kMaxNumber;

/** 超出限制回调 */
@property (nonatomic, copy) limitBlock limitBlock;
@end

NS_ASSUME_NONNULL_END
