//
//  LabView.m
//  GYStickerViewDemo
//
//  Created by admin on 2019/7/13.
//  Copyright © 2019年 HuangGY. All rights reserved.
//

#import "LabView.h"
#import "ListItem.h"
#import "GYStickerView.h"
@implementation LabView
{
    UILabel *labe;
    NSArray *_pictures;
    ///边框样式
    SWPickViewModel * _boderType;
    ///表格样式
    SWPickViewModel * _fromType;
    ///记录点击视图
    ListItem * _selectView;
    ///占位输入框
    UITextView * _placeText;
    
    YZChatInputView * _inputView;
}

-(id)initWithFrame:(CGRect)frame
              boderLayout:(SWPickViewModel*)boderType
              fromLayout:(SWPickViewModel*)fromType
               row:(NSInteger)rowNum
               col:(NSInteger)colNum
{
    if (self=[super initWithFrame:frame]) {
        _boderType = boderType.mutableCopy;
        _fromType = fromType.mutableCopy;
        
        [self loadImage];
        [self layoutFromList];
        self.backgroundColor =[UIColor whiteColor];
        ///90度
        if (_boderType.layout==1) {
         self.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
        
        [self.layer addSublayer:self.border];
        
        [self setPlaceTextView];
        
    }
    return self;
}
- (void)loadImage {
    NSMutableArray *picArray = [NSMutableArray array];
    for (int i = 0; i < 64; i++) {
        ListItem *imageName = [[ListItem alloc]init];
        imageName.fromStyle = _fromType;
        imageName.tag= i;
        [picArray addObject:imageName];
        [self addSubview:imageName];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClick:)];
        tap.numberOfTapsRequired = 2;
        [imageName addGestureRecognizer:tap];
        if (i==0) {
            imageName.text = @"双击编辑文本内容";
        }
        
   
    
    }
    _pictures = picArray.copy;
}
///重新布局大小
- (void)layoutFromList {
    CGFloat w = 0;
    CGFloat h = 0;
    
    if (_boderType.layout) {
         w = self.frame.size.height / _boderType.col;
         h = self.frame.size.width /  _boderType.row;
    }else{
         w = self.frame.size.width / _boderType.col;
         h = self.frame.size.height / _boderType.row;
    }

    CGFloat allCount =  _boderType.row* _boderType.col;
    for (int i = allCount; i<_pictures.count; i++) {
        ListItem *imageView = _pictures[i];
        imageView.hidden = YES;

    }
    
    for (int i = 0; i<allCount; i++) {
        ListItem *imageView = _pictures[i];
        imageView.fromStyle = _fromType;
        NSInteger row = i / _boderType.col;
        NSInteger col = i % _boderType.col;
        imageView.hidden = NO;
        CGFloat picX = w * col;
        CGFloat picY = h * row;
        imageView.frame = CGRectMake(picX, picY, w, h);
        [imageView layoutSubviews];
        
//        int index = i%row;
        
//        imageView.border.hidden = picX==0?YES:NO;

//        NSInteger index2 = (row * col)-col;
//        imageView.border2.hidden = i>=index2?YES:NO;
//
        
        
    }
}
///更新属性
-(void)updateStyle:(NSDictionary*)dict{
    ///更新模型属性
    SWPickViewModel * boderModel = dict[@"boder"];
    
    SWPickViewModel * fromModel = dict[@"from"];
    
    _boderType = boderModel.mutableCopy;
    _fromType =  fromModel.mutableCopy;
    
    [self layoutSubviews];
    
    [self layoutFromList];
    
    [self setNeedsDisplay];
//    [self layoutSubviews];

    
}
-(void)itemClick:(UITapGestureRecognizer*)tap{
    NSLog(@"==点击tag=%ld",tap.view.tag);
    
    ListItem * lable = (ListItem*)tap.view;
    
    lable.backgroundColor  =[UIColor grayColor];
    _selectView.backgroundColor = [UIColor clearColor];
    _selectView  = lable;
    
    _inputView.textField.text = [lable.text isEqualToString:@"双击编辑文本内容"]? @"":lable.text;
    
    
    ///点击其他的不要在弹出
    UIView * firstResponder = [self getCurrenfirstResponder];
    if ([firstResponder isEqual:_inputView.textField]) {
        return;
    }
    
    
    [_placeText becomeFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self->_inputView.textField becomeFirstResponder];
    });
    

}
-(CAShapeLayer *)border{
    if (!_border) {

      _border = [CAShapeLayer layer];
       
       //虚线的颜色
       _border.strokeColor = [UIColor redColor].CGColor;
       //填充的颜色
       _border.fillColor = [UIColor clearColor].CGColor;
       //虚线的宽度
       _border.lineWidth = _boderType.lineWidth;
    }
    return _border;
}

 

///设置占位输入框
-(void)setPlaceTextView{
    _placeText = [[UITextView alloc]init];
    _placeText.tag = 100001;
    
    ///工具条输入框
   YZChatInputView * inputView = [YZChatInputView shareInstance];
   inputView.frame = CGRectMake(0, 0, KScreenWidth, 50);
   inputView.delegate = self;
   inputView.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
   inputView.textField.leftViewMode = UITextFieldViewModeAlways;
      
   _placeText.inputAccessoryView = inputView;
   _inputView = inputView;
    [self addSubview:_placeText];
}
///键盘工具代理
-(void)sureClick:(NSString *)text{
    _selectView.backgroundColor = [UIColor clearColor];
    _selectView = nil;
    
    [_inputView.textField resignFirstResponder];
    [_placeText resignFirstResponder];
}
- (void)yz_textChangeCompletion:(NSString *)text{
     _selectView.text = text;
}

-(void)drawRect:(CGRect)rect{
    
    
    
    if (self.border.path) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:self.border.path];
        bezierPath =nil;
    }
 
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:0];
    self.border.path = path.CGPath;
    ///判断父视图是否选中。。
    GYStickerView * sup = (GYStickerView*)self.superview;
    
    ///选中的时候取消虚线
    NSArray * lineDashPattern = _boderType.style ==DashLine?@[@4,@2]:nil;

    self.border.lineDashPattern = !sup.isSelected?lineDashPattern:nil;
    
    self.border.strokeColor = !sup.isSelected?_boderType.boderColor.CGColor:[UIColor redColor].CGColor;
    
    self.border.lineWidth = !sup.isSelected?_boderType.lineWidth:1.5;
   

    
}
-(void)layoutSubviews{
    [super layoutSubviews];
     [self layoutFromList];
}

-(UIView*)getCurrenfirstResponder{

  UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
  UIView * firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    return firstResponder;
}
@end
