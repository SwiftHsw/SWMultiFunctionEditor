//
//  ListItem.m
//  GYStickerViewDemo
//
//  Created by admin on 2019/7/15.
//  Copyright © 2019年 HuangGY. All rights reserved.
//

#import "ListItem.h"
#import <SWKit.h>

@implementation ListItem
-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.textColor = [UIColor blackColor];
        self.font = [UIFont systemFontOfSize:18];
        self.numberOfLines = 0;
        self.userInteractionEnabled =  YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.hidden = YES;
        [self.layer addSublayer:self.border];
        [self.layer addSublayer:self.border2];
        self.contentEdgeInsets = UIEdgeInsetsMake(3, 5, 3, 5);
        self.paths= [[NSMutableArray alloc]init];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];

    
    [self.pat removeAllPoints];
    [self.pat moveToPoint:CGPointMake(0, 0)];
    [self.pat addLineToPoint:CGPointMake(0, self.frame.size.height)];
    self.border.path = self.pat.CGPath;
    self.border.lineWidth = self.fromStyle.lineWidth;
    self.border.strokeColor = self.fromStyle.boderColor.CGColor;
    self.border.lineDashPattern = self.fromStyle.style==DashLine?@[@5, @3]:nil;
    
    
    


    [self.pat2 removeAllPoints];
    [self.pat2 moveToPoint:CGPointMake(0,self.frame.size.height)];
    [self.pat2 addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    self.border2.path = self.pat2.CGPath;
    self.border2.lineWidth = self.fromStyle.lineWidth;
    self.border2.lineDashPattern = self.fromStyle.style==DashLine?@[@5, @3]:nil;
    self.border2.strokeColor = self.fromStyle.boderColor.CGColor;
    
   
    ///取巧的方式来隐藏显示i边框
    self.border.hidden = !self.x;
    
    self.border2.hidden =  self.maxY >= self.superview.height?YES:NO;
    
}
-(UIBezierPath *)pat{
    if (!_pat) {
        _pat = [UIBezierPath bezierPath];
    }
    return _pat;
}
-(UIBezierPath *)pat2{
    if (!_pat2) {
        _pat2 = [UIBezierPath bezierPath];
    }
    return _pat2;
}
-(CAShapeLayer *)border{
    if (!_border) {
        _border = [CAShapeLayer layer];
        //虚线的颜色
        _border.strokeColor = [UIColor blackColor].CGColor;
        
        //填充的颜色
        _border.fillColor = [UIColor clearColor].CGColor;
        
        //设置路径
        //虚线的宽度
        _border.lineWidth = 1.f;
        
        
        //设置线条的样式
        //    border.lineCap = @"square";
        //虚线的间隔
//        _border.lineDashPattern = @[@5, @3];
        
    }
    return _border;
}

-(CAShapeLayer *)border2{
    if (!_border2) {
        _border2 = [CAShapeLayer layer];
        //虚线的颜色
        _border2.strokeColor = [UIColor blackColor].CGColor;
        //填充的颜色
        _border2.fillColor = [UIColor clearColor].CGColor;
        
        //虚线的宽度
        _border2.lineWidth = 1.f;
        
        
    }
    return _border2;
}


@end
