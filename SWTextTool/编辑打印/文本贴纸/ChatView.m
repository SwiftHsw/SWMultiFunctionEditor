//
//  ChatView.m
//  GYStickerViewDemo
//
//  Created by admin on 2019/7/27.
//  Copyright © 2019年 HuangGY. All rights reserved.
//

#import "ChatView.h"
#import "AppDelegate.h"
@implementation ChatView
-(instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame])
     {
   
         self.imageView =[[UIImageView alloc]initWithFrame:self.bounds];
         [self addSubview:self.imageView];
         
         
         self.textLable = [[UILabel alloc]initWithFrame:CGRectZero];
         self.textLable.textColor = [UIColor blackColor];
         self.textLable.backgroundColor = [UIColor clearColor];
         self.textLable.textAlignment = NSTextAlignmentCenter;
         self.textLable.font = [UIFont systemFontOfSize:20];
         self.textLable.numberOfLines = 0;
        [self addSubview:self.textLable];
         
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEvent:)];
         tap.numberOfTapsRequired= 2;
         [self addGestureRecognizer: tap];
         
         
         ///占位键盘
         self.textView= [[UITextView alloc]init];
         self.textView.tag = 100001;
         [self addSubview:self.textView];
         self.textView.delegate = self;
         
         ///工具条输入框
         YZChatInputView * inputView = [YZChatInputView shareInstance];
         inputView.frame = CGRectMake(0, 0, KScreenWidth, 50);
         inputView.delegate = self;
         inputView.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
         inputView.textField.leftViewMode = UITextFieldViewModeAlways;
            
         self.textView.inputAccessoryView = inputView;
         self.inputView = inputView;
   
         
    }
  return self;
}

- (void)clickEvent:(UITapGestureRecognizer *)tap
{
    if ([[self getCurrenfirstResponder] isEqual:self.inputView.textField]) {
        return;
    }
    [self.textView becomeFirstResponder];
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self.inputView.textField becomeFirstResponder];
      });
       
  }
- (void)clickHiden{
//    self.bgView.hidden =YES;
    [self.inputView.textField resignFirstResponder];
    [self.textView resignFirstResponder];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}
///背景图
-(UIImage *)resizableImageWithName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    // 设置端盖的值--其它方向不需要拉伸，只拉伸头部
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    return newImage;
}

/**
 设置气泡内容

 @param text 内容
 */
-(void)setContentText:(NSString *)text{

     self.textLable.text = text;
//    [self setFontSizeThatFits:self.textLable];

}
///文字自适应大小
- (void)setFontSizeThatFits:(UILabel*)label

{
    CGFloat fontSizeThatFits;
    [label.text sizeWithFont:label.font
                 minFontSize:10.0   //最小字体
              actualFontSize:&fontSizeThatFits
                    forWidth:label.bounds.size.width
               lineBreakMode:NSLineBreakByWordWrapping];
    
    label.font = [label.font fontWithSize:fontSizeThatFits];
    
}

-(void)sureClick:(NSString *)text{
    [self setContentText:text];
    [self clickHiden];
    AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.isEitorText = NO;
//    [self.inputView.textField resignFirstResponder];
}

-(void)setingLableAndImage:(UIImage*)image info:(SWEditorBorderModel*)model{
    
    self.imageView.image = image;
    self.textLable.frame = CGRectMake(0, 0, model.ios_reduce_x_px, model.ios_reduce_y_px);
    self.textLable.sd_layout
    .leftSpaceToView(self, model.ios_add_x_px)
    .rightSpaceToView(self, model.ios_reduce_x_px)
    .topSpaceToView(self, model.ios_add_y_px)
    .bottomSpaceToView(self, model.ios_reduce_y_px);
}
-(void)dealloc{
    [kNoti removeObserver:self];
}

-(UIView*)getCurrenfirstResponder{

  UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
  UIView * firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    return firstResponder;
}


@end
