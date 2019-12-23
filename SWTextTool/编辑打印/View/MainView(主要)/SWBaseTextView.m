//
//  SWBaseTextView.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWBaseTextView.h"
#import "NSString+KKStringDate.h"

@interface SWBaseTextView ()
@property(nonatomic, retain)UILabel *placeHolderLab;
@end

@implementation SWBaseTextView

 - (instancetype)initWithFrame:(CGRect)frame
 {
     if (self = [super initWithFrame:frame]) {
         
         self.font = [UIFont systemFontOfSize:15];
         
         // 设置默认颜色
         self.placeholderColor = [UIColor lightGrayColor];
         
         // 使用通知监听文字改变
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
         
     }
     return self;
 }


- (void)textDidChange:(NSNotification *)note{
    //会重新调用fdrawRect 方法
    [self setNeedsDisplay];
//    文字输入限制
    [self limitTextViewLength];
}

#pragma mark - 文字输入限制
- (void)limitTextViewLength
{
    if (self.kMaxNumber == 0) {
        return;
    }
    
    NSString *toBeString = self.text;
    
    NSString *lang = [[self textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) {
        // 简体中文输入，包括简体拼音，健体五笔，简体手写
        //判断markedTextRange是不是为Nil，如果为Nil的话就说明你现在没有未选中的字符，
        //可以计算文字长度。否则此时计算出来的字符长度可能不正确
        
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分(感觉输入中文的时候才有)
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            //中文和字符一起检测  中文是两个字符
            if ([toBeString getStringLenthOfBytes] > self.kMaxNumber)
            {
                self.text = [toBeString subBytesOfstringToIndex:self.kMaxNumber];
                self.limitBlock ? self.limitBlock() : nil;
            }
        }
    } else  {
        if ([toBeString getStringLenthOfBytes] > self.kMaxNumber) {
            self.text = [toBeString subBytesOfstringToIndex:self.kMaxNumber];
            self.limitBlock ? self.limitBlock() : nil;
        }
    }
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
/**
 * 每次调用drawRect:方法，都会将以前画的东西清除掉
 */
- (void)drawRect:(CGRect)rect
{
    // 如果有文字，就直接返回，不需要画占位文字
    if (self.hasText) return;
    
    // 属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    // 画文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attrs];
  
}

-(void)layoutSubviews{
    [super layoutSubviews];
 
    [self setNeedsDisplay];
    
}


- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
    
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}
@end
