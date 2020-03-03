# SWMultiFunctionEditor
超级编辑器，多功能


![演示图](https://github.com/SwiftHsw/SWMultiFunctionEditor/blob/master/%E6%BC%94%E7%A4%BA.gif)

###前言

>作者脑洞大开，从现有的app里面写过的功能拿出来单独做一个demo，这边我想说的是，逻辑功能比较齐全，很多大项目里面都会用到一些基础功能，所以我已经实现了这个demo

###功能点描述

>1。字体SWBaseTextView.h文件里面，实现了自定义占位文字属性，以及超过字符和长度等。字体的大小，加粗，斜体，对齐方式，间距等属性知识；

> 2。解决UIScorllView和手势冲突，实现了自定义贴纸功能，包括帖子内输入文字，以及贴纸删除，旋转，拉伸等操作；
```
#pragma mark - 解决手势冲突

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //解决移动贴纸，scrollView会滚动
    //获取当天触发的View
    UIView *view = [super hitTest:point withEvent:event];
    BOOL isoldView = [view isEqual:_oldStickerView] ;
    //不是贴纸或者表格就打开，是的话就关闭
    self.scrollEnabled = !isoldView ;
    self.isClickMe = [view isEqual:self];
    
    BOOL is = [view.superview isKindOfClass:[GYStickerView class]] ||  [view.superview isKindOfClass:[LabView class]];
    if (is) {
        GYStickerView *sup = (GYStickerView *)view.superview;
        if ([sup isKindOfClass:[LabView class]]) {
            sup = (GYStickerView *)view.superview.superview;
        }
        self.scrollEnabled = !sup.isSelected;
        
    }
    
    return view;
    
}
```

> 3。插入自定义表情作为贴纸插入界面；（方法：通过字典来新增一个key值，当操作界面的时候能够获取到当前的贴纸是第几个）

> 4。插入自定义图片（方法：通过字典来新增一个key值，当操作界面的时候能够获取到当前的贴纸是第几个）

```
///把坐标放进字典
    [self.pointDictionary setObject:[NSNumber numberWithFloat:(CGRectGetMaxY(stickerView.frame))] forKey:[NSString stringWithFormat:@"%ld",(long)contentView.tag]];

```

>5。实现主题功能（从服务端获取主题，再通过缩放系数来切割上中下三张图片）代码如下
```
 CGImageRef imageCenterRef =CGImageCreateWithImageInRect([backGroundimage CGImage], rects);
        UIImage *imageCenter = [UIImage imageWithCGImage:imageCenterRef]; 
        
```
>6.每一个操作都必须要调用demo 中的UIScorllView容量ContenSize，代码如下




## demo说明

```
ViewController这个控制器是主界面，主要承载
/**
 滚动主视图
 */
@property(nonatomic , strong)SWMainScorllerView *scrollView;

/**
 功能键盘区
 */
@property(nonatomic , strong)SWEditorToolView *keyBoardBox;

我把所有功能逻辑都放在scorllView里面，大部分的控件的逻辑操作都使用通知来监听事件的触发
```

>控件区域

```
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

```

>监听区域

```
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
     ///插入表情
     [kNoti addObserver:self selector:@selector(inserEmoji:) name:INSEREMOJI object:nil];
}
```

##注意点⚠️

>当键盘弹出或消失要做的事情，处理好键盘逻辑坐标

```
#pragma mark ------键盘以及功能回调--------
-(void)keyboardWillShow:(NSNotification *)info{
    NSDictionary *userInfo = [info userInfo];
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
     UIView * firstResponder = [self.view getCurrenfirstResponder];
    CGFloat keyboardH  = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    ///隐藏所有的工具栏目
    if (self.keyBoardBox) {
         [self.keyBoardBox hideAllShowView];
    }
    if ([firstResponder isKindOfClass:[UIAlertController class]]) {
        return;
    }
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
```
