//
//  ViewController.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "ViewController.h"
#import "SWMainScorllerView.h"
#import "SWViewFontModel.h"
#import "UIView+SWView.h"
#import "SWEditorToolView.h"
#import "SWEditorBorderModel.h"
#import "SWFontModel.h"
#import "SWThemeModel.h"

@interface ViewController ()
/**
 滚动主视图
 */
@property(nonatomic , strong)SWMainScorllerView *scrollView;

/**
 功能键盘区
 */
@property(nonatomic , strong)SWEditorToolView *keyBoardBox;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self addNotif];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable=NO;
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [IQKeyboardManager sharedManager].enable=YES;
     [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

#pragma mark - setUpUI

- (void)setUpUI{
    
    self.view.backgroundColor = bg_color;
    
    self.title = @"SWTextTool";
    
    //添加主要控件
    
    [self.view sd_addSubviews:@[self.scrollView,self.keyBoardBox]];
    
}


- (void)addNotif{
 
    //键盘
    [kNoti addObserver:self  selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [kNoti addObserver:self  selector:@selector(keyboardWillHiden:) name:UIKeyboardWillHideNotification  object:nil];
    ///插入
    [kNoti addObserver:self selector:@selector(selectTextBoder:) name:INSERTTEXT object:nil];
    //字体号修改
    [kNoti addObserver:self selector:@selector(changeFont:) name:CHNAGEFONT object:nil];
    ///修改字体
    [kNoti addObserver:self selector:@selector(changeFontStyle:) name:CHNAGEFONTSTYLE object:nil];
    ///字体格式
    [kNoti addObserver:self selector:@selector(changeTextFomatter:) name:FONTFOMMATER object:nil];
    ///字体对齐
    [kNoti addObserver:self selector:@selector(changeTextAligement:) name:FONTALIGMENT object:nil];
    ///字体间距
    [kNoti addObserver:self selector:@selector(changeTextMagin:) name:FONTROWMAGIN object:nil];
    ///写入主题
    [kNoti addObserver:self selector:@selector(insertTheme:) name:INSERTTHEME object:nil];
     
}
#pragma mark ------键盘以及功能回调--------
-(void)keyboardWillShow:(NSNotification *)info{
    NSDictionary *userInfo = [info userInfo];
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
     UIView * firstResponder = [self.view getCurrenfirstResponder];
    CGFloat keyboardH  = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    ///隐藏所有的工具栏目
    [self.keyBoardBox hideAllShowView];
    if (firstResponder.tag==100001) {
        ///键盘弹出,更新坐标，f防止被挡住
        [self.scrollView keyBoardShowUpatafram:(keyboardH*.5)+KHeight_Tabar+pointMagin];
        return;
    }
    ///键盘弹出,更新坐标，防止被挡住
     [self.scrollView keyBoardShowUpatafram:(keyboardH/2)+KHeight_Tabar];
    
    //改变底部键盘工具的Y
    CGRect rect = self.keyBoardBox.frame;
    rect.origin.y = keyboardH - KHeight_Tabar;
    self.keyBoardBox.frame = rect;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

///创建文本贴纸
-(void)selectTextBoder:(NSNotification*)info{
    SWLog(@"创建文本贴纸");
    UIImage *image = info.object;
    SWEditorBorderModel *borderModel = info.userInfo[@"info"];
    [self.scrollView creatTextStickers:@"双击编辑文本内容" image:image infoModel:borderModel];
}
//当键盘退出时调用
-(void)keyboardWillHiden:(NSNotification *)info{
    NSDictionary *userInfo = [info userInfo];
    CGRect rect = self.keyBoardBox.frame;
    CGFloat keyboardH  = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    rect.origin.y = SCREEN_HEIGHT - KHeight_Tabar -SafeBottomHeight;
    self.keyBoardBox.frame = rect;
    [UIView animateWithDuration:.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    [self.scrollView keyBoardHidenpatafram:keyboardH];
}
 ///修改文字大小
 -(void)changeFont:(NSNotification*)info{
     [self.scrollView changeTheFontSize:[info.object floatValue]];
 }
//修改字体
- (void)changeFontStyle:(NSNotification *)info{
    SWFontModel*Model = (SWFontModel *)info.object;
    [self.scrollView changeFontStyle:Model.name];
}
///字体格式加粗等
-(void)changeTextFomatter:(NSNotification*)info{
    [self.scrollView changTextFomatter:info.userInfo];
}
///修改对齐方式
-(void)changeTextAligement:(NSNotification*)info{
    [self.scrollView textAligement:info.userInfo];
}
///修改字体间距
-(void)changeTextMagin:(NSNotification*)info{
    [self.scrollView textSpaceNum:[info.object floatValue]];
}
///插入主题
-(void)insertTheme:(NSNotification*)info{
    SWThemeModel *model = (SWThemeModel *)info.object;
    if (!model.thumb_img.length) {
        [self.scrollView creatTheme:@{}];return;
    }
    UIImage *image = info.userInfo[@"image"];
    //拆分3张图
    NSDictionary *dict = [model getThemeImage:SCREEN_WIDTH image:image];
    [self.scrollView creatTheme:dict];
}
#pragma mark - Lazy
- (SWMainScorllerView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[SWMainScorllerView alloc]init];
        _scrollView.frame = CGRectMake(10, NavBarHeight + 10, SCREEN_WIDTH -20, SCREEN_HEIGHT - NavBarHeight - SafeBottomHeight - 10 - KHeight_Tabar);
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.inputTextView.placeholder = @"请输入占位字符";
  
        SWViewFontModel *fontModel = [SWViewFontModel new];
        fontModel.fontSize = 30.f;
        _scrollView.fontModel = fontModel; //runtime属性
  
    }
    return _scrollView;
    
}

-(SWEditorToolView *)keyBoardBox{
    if (!_keyBoardBox) {
        _keyBoardBox = [[SWEditorToolView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - KHeight_Tabar - SafeBottomHeight, SCREEN_WIDTH, KHeight_Tabar+SafeBottomHeight)];
        [_keyBoardBox setSw_editorToolViewDismiss:^(NSInteger index) {
            
        }];
        
        [_keyBoardBox setSw_editorToolViewSelectActionIndex:^(NSInteger index) {
            
        }];
 
    }
    return _keyBoardBox;
}

@end
