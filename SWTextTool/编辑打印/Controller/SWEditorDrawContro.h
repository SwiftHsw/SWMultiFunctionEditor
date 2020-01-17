//
//  SWEditorDrawContro.h
//  SWTextTool
//
//  Created by 帅到不行 on 2020/1/16.
//  Copyright © 2020 sw. All rights reserved.
//

#import <SWKit/SWKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWEditorDrawContro : SWSuperViewContoller
@property (nonatomic,copy) void (^backCpltion)(UIImage *img);
@end

NS_ASSUME_NONNULL_END
