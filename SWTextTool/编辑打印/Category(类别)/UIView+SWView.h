//
//  UIView+SWView.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

 
#import "SWViewFontModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SWView)

@property (nonatomic,strong) SWViewFontModel *fontModel;

@property (nonatomic,copy) NSString *nameWithSetterGetter;

@end

NS_ASSUME_NONNULL_END
