//
//  YZDrawWithView.m
//  Printer
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 admin. All rights reserved.
//

#import "YZDrawWithView.h"
@implementation YZDrawWithView
{
    NSArray * linewWidth;
    UIButton * oldButton;
}
-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUpUI];
        linewWidth = @[@6,@8,@10,@12,@15,@18,@20];
        
    }
    return self;
}
-(void)setUpUI{
    NSArray * widths = @[@"10",@"13",@"15",@"18",@"20",@"23",@"25"];
    
    
    UIView * leftView = self;
    for (int i = 0; i<widths.count; i++) {
        CGFloat w = [widths[i] floatValue];
        UIButton * button = [[UIButton alloc]init];
        button.backgroundColor  =[UIColor blackColor];
        [button addTarget:self action:@selector(widthClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = i;
        [self addSubview:button];
        button.layer.cornerRadius  = w/2;
        button.clipsToBounds = YES;
         button.layer.borderWidth = 2;
        button.sd_layout
        .leftSpaceToView(leftView, 15)
        .widthIs(w)
        .centerYEqualToView(self)
        .heightIs(w);
        leftView = button;
        if (i==0) {
            button.layer.borderColor  =[UIColor redColor].CGColor;
            oldButton  =button;
            
        }
    }
}
-(void)widthClick:(UIButton*)button{
   
    button.layer.borderColor = [UIColor redColor].CGColor;
    oldButton.layer.borderColor = [UIColor clearColor].CGColor;
    oldButton  = button;
    
    CGFloat lineW = [linewWidth[button.tag] floatValue];
    if ([self.delegate respondsToSelector:@selector(yz_chooseLineWidth:)]) {
        [self.delegate yz_chooseLineWidth:lineW];
    }
    
}

@end
