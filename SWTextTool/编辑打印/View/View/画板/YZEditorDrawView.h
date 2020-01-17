//
//  YZEditorDrawView.h
//  Printer
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 admin. All rights reserved.
//

#import "SWBaseView.h"
#import "YZPathModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YZEditorDrawView : SWBaseView
///绘制类型
@property(nonatomic , assign) MHPathModelAction pathModelAction;
///绘制宽度
@property(nonatomic , assign) NSInteger lineWidth;
///绘制颜色
@property(nonatomic , strong)UIColor * lineColor;

///撤销绘制
- (void)undo;
- (void)repeat;
- (void)clearAll;
-(void)end;
-(UIImage*)clipImage;
@end

NS_ASSUME_NONNULL_END
