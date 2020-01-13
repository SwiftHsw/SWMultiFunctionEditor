//
//  SWEditorToolView.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWBaseView.h"
#import "SWFontView.h"
#import "SWThemeView.h"
#import "SWFaceView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWEditorToolView : SWBaseView<UICollectionViewDelegate,UICollectionViewDataSource>
//工具菜单
@property(nonatomic,strong) UICollectionView *menueCollection;
//功能数组
@property(nonatomic,strong) NSMutableArray *menuDataArray;
//View载体
@property(nonatomic,strong) NSMutableArray *showViews;
//文本
@property(nonatomic,strong)SWFontView *fontView;
//主题
@property(nonatomic,strong)SWThemeView *themeView;
//表情
@property(nonatomic,strong)SWFaceView *faceView;

//记录弹出的视图
@property (nonatomic , weak)UIView * showView;

@property (nonatomic , strong)UIButton * closeButton;
//隐藏所有视图
- (void)hideAllShowView;


//点击菜单回调
@property (nonatomic,copy)void (^sw_editorToolViewSelectActionIndex)(NSInteger index);

@property (nonatomic,copy)void (^sw_editorToolViewDismiss)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
