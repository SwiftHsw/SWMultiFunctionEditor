//
//  SWEditorDrawContro.m
//  SWTextTool
//
//  Created by 帅到不行 on 2020/1/16.
//  Copyright © 2020 sw. All rights reserved.
//

#import "SWEditorDrawContro.h"
#import "YZDrawToolView.h"
#import "YZDrawWithView.h"
#import "YZEditorDrawView.h"
#import "YZEditorDrawView.h"
 
@interface SWEditorDrawContro ()<YZDrawWithViewDelegate,YZDrawToolViewDelegate>

/// 工具条
@property (nonatomic , strong)YZDrawToolView * toolView;
///宽度
@property (nonatomic , strong)YZDrawWithView * widthView;
///画板
@property (nonatomic , strong)YZEditorDrawView * drawView;

//@property (nonatomic , strong)UIButton * completeButton;

@end

@implementation SWEditorDrawContro

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"完成" ImageName:@"" highImageName:@"" target:self action:@selector(clipImage)];
    
}
-(void)setUpUI{
    self.view.backgroundColor = [SWKit colorWithHexString:@"#f5f5f5"];
    self.title =@"涂鸦";
 
    
    [self.view sd_addSubviews:@[self.toolView,
                                self.widthView,
                                self.drawView]];
    self.toolView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomSpaceToView(self.view, SafeBottomHeight)
    .heightIs(80);
    
    self.widthView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(55)
    .bottomSpaceToView(self.toolView, 0);
    
    self.drawView.sd_layout
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .topSpaceToView(self.view, NavBarHeight+10)
    .bottomSpaceToView(self.widthView, 0);
    
    
}
#pragma mark -----选择宽度回调------
-(void)yz_chooseLineWidth:(CGFloat)width{
    self.drawView.lineWidth  = width;
}
#pragma mark-----工具代理--------
-(void)yz_drawToolViewComletion:(SWDrawToolType)type{
    /*
     Stroke=0,//笔画
     Eraser=1,//橡皮擦
     Undo=2,//撤销
     Reply=3,//恢复
     */
    if (type==Undo) {
        [self.drawView undo];
    }else if (type==Reply){
        [self.drawView repeat];
    }else if(type==Stroke){
        self.drawView.lineColor = [UIColor blackColor];
    }else{
        self.drawView.lineColor = [UIColor whiteColor];
    }
}
///剪辑图片
-(void)clipImage{
   UIImage * image =  [self.drawView clipImage];
    if (image) { 
        self.backCpltion(image);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
#pragma mark ----lazy-----
- (YZDrawToolView *)toolView{
    if (!_toolView) {
        _toolView =[YZDrawToolView shareInstance];
        _toolView.delegate = self;
    }
    return _toolView;
}
- (YZDrawWithView *)widthView{
    if (!_widthView) {
        _widthView  =[[YZDrawWithView alloc]init];
        _widthView.delegate = self;
    }
    return _widthView;
}
- (YZEditorDrawView *)drawView{
    if (!_drawView) {
        _drawView =[[YZEditorDrawView alloc]init];
        _drawView.backgroundColor = [UIColor whiteColor];
    }
    return _drawView;
}
 

@end

