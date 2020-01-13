//
//  SWFontView.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFontView.h"
#import "SWFontBorder.h"
#import "SWFontListView.h"
#import "SWFontFormatView.h"

@interface SWFontView ()

/**
 边框素材
 */
@property (nonatomic , strong)SWFontBorder * fontBoderView;

/**
 字体大小
 */
@property (nonatomic , strong)SWFontListView * fontSizeView;


/**
 字体格式
 */
@property (nonatomic , strong)SWFontFormatView * formatView;

/**
存放显示的视图
 */
@property (nonatomic , strong)NSMutableArray * contents;

/**
 当前视图
 */
@property (nonatomic , strong)UIView * currentView;

/**
 当前按钮
 */
@property (nonatomic , strong)UIButton * currentButton;
@end
@implementation SWFontView


 -(id)initWithFrame:(CGRect)frame{
     if (self=[super initWithFrame:frame]) {
         [self setUpUi];
     }
     return self;
 }
 -(void)setUpUi{
     
     CGFloat itemHeight=60;
     CGFloat itemWidth=50;
     
     for (int i = 0; i<3; i++) {
         UIButton * button = [[UIButton alloc]init];
         button.frame = CGRectMake(0, i*itemHeight + (i==0?10:0), itemWidth, itemHeight);
         button.backgroundColor = [SWKit colorWithHexString:@"#999999"];
         [button addTarget:self action:@selector(leftMenueClick:) forControlEvents:(UIControlEventTouchUpInside)];
//         [button setTitle:[NSString stringWithFormat:@"%d",i] forState:(UIControlStateNormal)];
         button.tag = i;
         [self addSubview:button];
        
         if (i==0) {
             self.currentButton = button;
         }
         NSArray *arr = @[@"素材",@"文本素材",@"多功能"];
 
         [button setImage:kImageName(arr[i]) forState:UIControlStateNormal];
         
         
     }
     
     [self addSubview:self.fontBoderView];
     [self addSubview:self.fontSizeView];
     [self addSubview:self.formatView];
     self.currentView = self.fontBoderView;
     self.contents = [[NSMutableArray alloc]initWithObjects:self.fontBoderView,self.fontSizeView,self.formatView, nil];
     

     
 }
 -(void)leftMenueClick:(UIButton*)button{
   
     self.currentView.hidden = YES;
     UIView * indexView = self.contents[button.tag];
     indexView.hidden  =NO;
     self.currentView = indexView;
     
     self.currentButton.backgroundColor = [SWKit colorWithHexString:@"#999999"];
     button.backgroundColor = [SWKit colorWithHexString:@"#00DD98"];  ;
     self.currentButton = button;
     
     
     
 }

 -(SWFontBorder *)fontBoderView {
     if (!_fontBoderView) {
         _fontBoderView = [[SWFontBorder alloc]initWithFrame:CGRectMake(60, 0, self.width-70, self.height)];
         _fontBoderView.backgroundColor =[UIColor whiteColor];
     
     }
     return _fontBoderView;
 }
 - (SWFontListView *)fontSizeView{
     if (!_fontSizeView) {
     
         _fontSizeView = [[SWFontListView alloc]initWithFrame:CGRectMake(60, 0, self.width-70, self.height)];
         _formatView.backgroundColor =[UIColor whiteColor];
         _fontSizeView.hidden = YES;
     }
     return _fontSizeView;
 }

 - (SWFontFormatView *)formatView{
     if (!_formatView) {
         _formatView = [[SWFontFormatView alloc]initWithFrame:CGRectMake(60, 10, self.width-70, self.height-10)];
         _formatView.backgroundColor =[UIColor blackColor];
         _formatView.hidden = YES;
     }
     return _formatView;
 }

 -(void)layoutSubviews{
     [self LX_SetShadowPathWith:
     [[SWKit colorWithHexString:@"#000000"]colorWithAlphaComponent:0.15]
      shadowOpacity:1
      shadowRadius:4
      shadowSide:LXShadowPathTop
       shadowPathWidth:-2];
 }


@end
