//
//  SWFontFormatterCell.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFontFormatterCell.h"

@implementation SWFontFormatterCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setSubViews];
    }
    return self;
}
-(void)setSubViews{
    self.lable.text =@"字形/缩进";
    UIView * leftView = self.contentView;
    CGFloat leftV = 30;
    NSArray * img = @[@"B",@"I",@"U"];
    for (int i = 0; i<3; i++) {
        UIButton * button = [[UIButton alloc]init];
        button.backgroundColor =[SWKit colorWithHexString:@"#f5f5f5"];
        [button setTitle:img[i] forState:(UIControlStateNormal)];
        button.titleLabel.font =[UIFont systemFontOfSize:10];
        [button setTitleColor:[SWKit colorWithHexString:@"#00DD98"] forState:(UIControlStateSelected)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = i;
        [self.contentView addSubview:button];
        button.sd_layout
        .leftSpaceToView(leftView, leftV)
        .topSpaceToView(self.lable, 10)
        .heightIs(40)
        .widthIs(40);
        leftView = button;
        leftV = 15;
    
    }
    
    [self setupAutoHeightWithBottomView:leftView bottomMargin:15];
    
    
}
-(void)click:(UIButton*)button{
    button.selected = !button.selected;
    SWFontFormatterType type = button.tag;
    
    NSDictionary * dict = @{@"type":@(type),@"state":@(button.selected)};
    [kNoti postNotificationName:FONTFOMMATER object:nil userInfo:dict];
    
}

@end
