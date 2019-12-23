//
//  SWMainScorllerView.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWMainScorllerView.h"
#import "ChatView.h"
#import "GYStickerView.h"
#import "LabView.h"
#import <CoreText/CoreText.h>

@interface SWMainScorllerView ()<UITextViewDelegate,GYStickerViewDelegate>{
      GYStickerView * _oldStickerView;
}
@property (nonatomic , assign)BOOL isClickMe;
/**
 存放素材。图片的坐标点
 */
@property (nonatomic , strong)NSMutableDictionary * pointDictionary;


@end
@implementation SWMainScorllerView

 
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
         
        self.pointDictionary = [NSMutableDictionary dictionary];
        [self addSubview:self.topBoder];
        [self addSubview:self.centerBoder];
        [self addSubview:self.bottomBoder];
        [self addSubview:self.inputTextView];
        
        [self addTapGestureRecognizer:@selector(gestureRecoginzerClick) target:self numberTaps:1];
        
        
    }
    return self;
}

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
- (void)gestureRecoginzerClick{
//    if (_isClickMe) {
//           //启动第一响应者
//           [_inputTextView becomeFirstResponder];
//       }
    
}
#pragma mark ----textViewDelegate------
-(void)textViewDidChange:(UITextView *)textView
{
   //自适应高度
    [textView flashScrollIndicators];
    CGRect frmae = textView.frame;
    CGSize constraintSize = CGSizeMake(frmae.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    
    [textView scrollRangeToVisible:textView.selectedRange];
    
    textView.frame = CGRectMake(frmae.origin.x, frmae.origin.y, frmae.size.width, size.height);
    
    [self setContentSize:CGSizeMake(self.frame.size.width, [self getContentHeight])];//实时计算滚动最大值
    
     ///更新主题坐标
    [self upDataBoderFrame];
}


#pragma mark - 功能区

- (CGFloat)getContentHeight{
 
    return MAX([self getMaxY]+self.bottomBoder.height, 0);
    
}


///键盘隐藏更新坐标（外部调用）
-(void)keyBoardShowUpatafram:(CGFloat)keyBoderHeight{
    
    //取消贴纸的选中
       _oldStickerView.isSelected = NO;
       _oldStickerView = nil;
    
     //重新计算
    [self setContentSize:CGSizeMake(self.width, [self getContentHeight])];
    
    [self setContentInset:UIEdgeInsetsMake(0, 0,keyBoderHeight,0)];
    
    !self.selectCurrentStickerBlock?:self.selectCurrentStickerBlock(_oldStickerView,YES);
}

-(void)keyBoardHidenpatafram:(CGFloat)keyBoderHeight{
    //重新计算
    [self setContentSize:CGSizeMake(self.width, [self getContentHeight])];
    
    
    //取消贴纸的选中
    _oldStickerView.isSelected = NO;
    _oldStickerView = nil;
    
    //等逻辑
    [self setContentSize:CGSizeMake(self.width, [self getContentHeight])];
     [self setContentInset:UIEdgeInsetsMake(0, 0, 0,0)];
    
    !self.selectCurrentStickerBlock?:self.selectCurrentStickerBlock(_oldStickerView,YES);
    
    
}
//计算高度
- (CGFloat)getMaxY{
    CGFloat maxY = [[[self.pointDictionary allValues]valueForKeyPath:@"@max.floatValue"]floatValue];
    //默认高度
    CGFloat currenMaxY = maxY;
    
    //没有素材的坐标以输入框为准
    if (  self.pointDictionary.count <= 0|| maxY <= self.inputTextView.height) {
        currenMaxY = self.inputTextView.height;
        return currenMaxY + pointMagin + self.topBoder.height;
    }
    return pointMagin + currenMaxY;
}


- (void)creatTextStickers:(NSString *)text
                    image:(UIImage *)image
                infoModel:(SWEditorBorderModel *)model{
    
    UIImage *img = [UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:(UIImageOrientationUp)];
    
    ChatView *cv = [[ChatView alloc]initWithFrame:CGRectMake(self.centerX-(img.size.width)/2, [self getMaxY], img.size.width, img.size.height)];
    [cv setContentText:text];
    cv.tag = self.pointDictionary.count;
    [cv setingLableAndImage:image info:model];
    [self addStickerViewWithContentView:cv];
    
    
    
}
///生成贴纸
- (void)addStickerViewWithContentView:(UIView *)contentView {
    
    ///取消老的贴纸选择状态
    _oldStickerView.isSelected = NO;
    
    _oldStickerView = nil;
    ///修改值
       GYStickerView *stickerView = [[GYStickerView alloc] initWithContentView:contentView];
       ///表格取消旋转
       stickerView.ctrlType =[contentView isKindOfClass:[LabView class]]?GYStickerViewCtrlTypeNoRotation:GYStickerViewCtrlTypeGesture;
       stickerView.scaleMode = GYStickerViewScaleModeTransform;
       stickerView.delegate  =self;
       stickerView.tag = contentView.tag;
       stickerView.userInteractionEnabled = [contentView isKindOfClass:[LabView class]];
       stickerView.minItemWidth = 150;
       ////表格的时候需要自由缩放
       stickerView.scaleFit = ![contentView isKindOfClass:[LabView class]];
       [stickerView showOriginalPoint:YES];
       [stickerView setTransformCtrlImage:[UIImage imageNamed:@"image_btn_resize"]];
       [stickerView setResizeCtrlImage:[UIImage imageNamed:@"image_btn_resize"] rotateCtrlImage:[UIImage imageNamed:@"image_btn_rotate"]];
       [stickerView setRemoveCtrlImage:[UIImage imageNamed:@"image_btn_rotate"]];
       [self addSubview:stickerView];
    
    
    
    ///把坐标放进字典
    [self.pointDictionary setObject:[NSNumber numberWithFloat:(CGRectGetMaxY(stickerView.frame))] forKey:[NSString stringWithFormat:@"%ld",(long)contentView.tag]];
    
    
    ///增加滚动的范围值
      [self setContentSize:CGSizeMake(self.width, [self getContentHeight])];
      
    
    ///查询设置当前的所在位置，记录是否可以操作向上或者向下
    [self selectStickersLastNextButtomShow];
    
    //block 回调设置到按钮是否可以向下
    !self.selectCurrentStickerBlock ? :self.selectCurrentStickerBlock(_oldStickerView,self.pointDictionary.count >= 2?NO:YES);
    //滚动到底部
    [self scrollToBottom:keyBoxHeight];
    
    ///更新主题坐标
     [self upDataBoderFrame];
}

//字体大小修改
- (void)changeTheFontSize:(CGFloat)fontSize{
    self.fontModel.fontSize = fontSize;
    [self formatterTextView];
    
    
}

//字体修改
- (void)changeFontStyle:(NSString *)fontName{
    self.fontModel.fontName = fontName;
    [self formatterTextView];
}
///字体格式
-(void)changTextFomatter:(NSDictionary*)dict{
    NSInteger type = [dict[@"type"] integerValue];
    BOOL state = [dict[@"state"] boolValue];
    ///字体加粗
       if (type==Font_Bold) {
           self.fontModel.bold = state;
           [self formatterTextView];
       }else if (type==Font_Italic){
           self.fontModel.italic = state;
           [self formatterTextView];
       }else if (type==Font_Unline){
           self.fontModel.underLine = state;
           [self formatterTextView];
       }
 
}
// 修改字体对齐
/// @param dict 信息
-(void)textAligement:(NSDictionary*)dict{
    NSInteger type = [dict[@"type"] integerValue];
    self.fontModel.aligment = type;
    [self formatterTextView];
    
}
/// 修改字体间距
/// @param row 间距
-(void)textSpaceNum:(CGFloat)row{
    self.fontModel.rowSpace = row;
    [self formatterTextView];
}

/// 创建主题边框
/// @param dict 边框信息
-(void)creatTheme:(NSDictionary*)dict{
    //获取上中下三张图片
   UIImage * topImage;
   UIImage * centerImage ;
   UIImage * bttomImage ;
    
    //保险起见
    if (dict[@"top"] && dict[@"center"] &&  dict[@"bttom"]) {
        topImage = dict[@"top"];
        centerImage = dict[@"center"];
        bttomImage = dict[@"bttom"];
        if (topImage && centerImage && bttomImage) {
               self.topBoder.image =topImage;
               self.centerBoder.image = centerImage;
               self.bottomBoder.image = bttomImage;
            
            self.topBoder.height = topImage.size.height;
            self.bottomBoder.height =bttomImage.size.height;
            
            self.centerBoder.y = CGRectGetMaxY(self.topBoder.frame);
            [self upDataBoderFrame];
            //修改输入框的位置
            self.inputTextView.y = CGRectGetMaxY(self.topBoder.frame);
            self.inputTextView.x = dict.count>0?25:0;
            self.inputTextView.width = self.inputTextView.width - (dict.count>0?50:0);
            
            ///增加滚动的范围值
               [self setContentSize:CGSizeMake(self.width, [self getContentHeight])];
                  
            
           }
 
    }
 
    
}
#pragma mark - 字体样式设置
- (void)formatterTextView{
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = self.fontModel.aligment;//剧中
    style.lineSpacing = self.fontModel.rowSpace;//行间距
    
    
    UIFont *font = [self customFontWithPath:self.fontModel.fontName size:self.fontModel.fontSize];
    NSDictionary *fontAtt = @{
        NSFontAttributeName:font,
        NSStrokeWidthAttributeName:@(self.fontModel.bold?-5:0),
        NSObliquenessAttributeName:@(self.fontModel.italic?0.5:0),
        NSUnderlineStyleAttributeName:@(self.fontModel.underLine?1:0),
        NSParagraphStyleAttributeName:style,
    };
    self.inputTextView.typingAttributes = fontAtt;
     
    self.inputTextView.attributedText = [[NSMutableAttributedString alloc]initWithString:self.inputTextView.text attributes:fontAtt];
    
    //更新
    [self textViewDidChange:self.inputTextView];
}


///查询下，当前选中的贴纸所处的位置是否可以向下向上
-(void)selectStickersLastNextButtomShow{
    BOOL isLast=NO;
    BOOL isNext=NO;
    int selectIndex=-1;
    int mix=0;
    int max=0;
    for (UIView *view in self.subviews) {
        //如果是贴纸 ，找到贴纸 记录最后一个view
        if ([view isKindOfClass:[GYStickerView class]]) {
            NSInteger indexAA = [[self subviews] indexOfObject:view];
            if (_oldStickerView==view) {
                selectIndex=(int)indexAA;
            }
            if (mix==0) {
                mix=(int)indexAA;
            }else{
                mix=MIN(mix,(int)indexAA);
            }
            if (max==0) {
                max=(int)indexAA;
            }else{
                max=MAX(max, (int)indexAA);
            }
        }
    }
    if (selectIndex==mix) {
        isNext=NO;
    }else{
        isNext=YES;
    }
    if (selectIndex==max) {
        isLast=NO;
    }else{
        isLast=YES;
    }
    //是否可以拖动上下
    _oldStickerView.isLast = isLast;
    _oldStickerView.isNext = isNext;
    //    DLog(@"%d",isLast);
    //    DLog(@"%d",isNext);
}
///让滚动视图滚动到最下面
- (void)scrollToBottom:(CGFloat)y{
    if (self.contentSize.height > self.frame.size.height) {
        CGFloat bottom = self.contentSize.height - self.size.height;
        [self setContentOffset:CGPointMake(0, bottom + y) animated:YES];
    }
}

- (void)upDataBoderFrame{
    //更新中间图片高度
    if (self.centerBoder.image) {
        //最小的高度
        CGFloat height = MAX([self getMaxY] - self.topBoder.height, self.inputTextView.height + pointMagin );
        self.centerBoder.height = height;
//        更新底部图片的y轴
        self.bottomBoder.y = CGRectGetMaxY(self.centerBoder.frame);
        
    }
    
}


#pragma mark - 贴纸操作的代理

/**
单击贴纸

@param tag 标识符
@param stickerView 贴纸对象
*/
- (void)singleClickOnstickerIdentifier:(NSInteger)tag obj:(GYStickerView *)stickerView{
    
    //移除键盘
    [self.inputTextView resignFirstResponder];
    
    //如果点击的是相同的一个 就不要操作
    if (![_oldStickerView isEqual:stickerView]) {
        _oldStickerView.isSelected = NO;
        _oldStickerView = stickerView; // 记录
    }
    
    if (stickerView.isSelected) {
        //如果当前的已经选中
       //查询设置当前的所在位置，记录是否可以向上或者向下操作
        [self selectStickersLastNextButtomShow];
        !self.selectCurrentStickerBlock ? :self.selectCurrentStickerBlock(_oldStickerView,self.pointDictionary.count >= 2?NO:YES);
    }
    
}



/**
修改贴纸的位置和大小 ,移动完成回调

@param offsetY 坐标
@param tag 标识符
*/
- (void)changeGYStickerViewFrame:(CGFloat)offsetY identifier:(NSInteger)tag{
    
    //获取默认的y值
    SWLog(@"%f",offsetY);
    NSString *key = [NSString stringWithFormat:@"%ld",(long)tag];
    
    CGFloat nomolCurrenY = [[self.pointDictionary objectForKey:key] floatValue];
    SWLog(@"%f",nomolCurrenY);
    
    //修改 重新替换当前key 的值
    nomolCurrenY = offsetY;
    
    [self.pointDictionary setObject:@(nomolCurrenY) forKey:key];
    
    //更新坐标，滑动的最大值
    
    [UIView animateWithDuration:0.3 animations:^{
        //设置容量
          [self setContentSize:CGSizeMake(self.frame.size.width, [self getContentHeight])];
    
      }];
    ///更新主题坐标
    [self upDataBoderFrame];
    
    
    
    //判断是否拖动的是最后一个
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        CGPoint bottomOffset = CGPointMake(0, self.contentSize.height - self.bounds.size.height);
//
//        [self setContentOffset:bottomOffset animated:YES];
//
//
//    });
    
}

/**
删除贴纸

@param tag 标识符
@param stickerView 贴纸
*/

- (void)deleteStickerView:(NSInteger)tag obj:(GYStickerView *)stickerView{
    
    
    //移除 数据源的key
    [self.pointDictionary removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)tag]];
    
    //重新计算坐标
    [[SWKit currentWindow] endEditing:YES];
    
    //设置容量
    [UIView animateWithDuration:0.3 animations:^{
       [self setContentSize:CGSizeMake(self.frame.size.width, [self getContentHeight])];
    }];
    
    //更新主题坐标
    [self upDataBoderFrame];
}

#pragma mark - init Lazy

- (SWBaseTextView *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [[SWBaseTextView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth - 20, 45)];
  
        _inputTextView.backgroundColor = [UIColor whiteColor];
        _inputTextView.delegate = self;
        _inputTextView.font = kFontWithSize(self.fontModel.fontSize);
        _inputTextView.placeholderColor = [UIColor grayColor];
        _inputTextView.scrollEnabled = NO;
    }
    
    return _inputTextView;
    
}
- (UIImageView *)topBoder{
    if (!_topBoder) {
        _topBoder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth-20, 0)];
        _topBoder.backgroundColor =[UIColor whiteColor];
    }
    return _topBoder;
}
- (UIImageView *)bottomBoder{
    if (!_bottomBoder) {
        _bottomBoder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth-20, 0)];
        _bottomBoder.backgroundColor =[UIColor whiteColor];
    }
    return _bottomBoder;
}
- (UIImageView *)centerBoder{
    if (!_centerBoder) {
        _centerBoder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth-20, 0)];
        _centerBoder.backgroundColor =[UIColor whiteColor];
    }
    return _centerBoder;
}
- (void)setFontModel:(SWViewFontModel *)fontModel{
    [super setFontModel:fontModel];
    self.inputTextView.font = kFontWithSize(fontModel.fontSize);
    [self textViewDidChange:self.inputTextView];
}




#pragma mark - 获取本地文件地址(已下载的字体)

-(UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size
{
    //    [loadView closeView];
    NSString *path22 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/FontName/"];
    NSString *filePath22 = [path22 stringByAppendingPathComponent:path];
    NSURL *fontUrl = [NSURL fileURLWithPath:filePath22];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    //    NSArray *arr = [NSArray arrayWithObject:font];
    [[NSUserDefaults standardUserDefaults]setObject:fontName forKey:@"123"];
    return font;
}


@end
