//
//  SWBaseFontFormaterCell.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWBaseFontFormaterCell.h"

@implementation SWBaseFontFormaterCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)setUpUI{
    [self.contentView addSubview:self.lable];
    [self.contentView addSubview:self.line];
    
    self.lable.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 15)
    .heightIs(14);
    [self.lable setSingleLineAutoResizeWithMaxWidth:self.contentView.width];
    
    self.line.sd_layout
    .leftSpaceToView(self.contentView, 25)
    .bottomEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(1);
    
    [self setupAutoHeightWithBottomView:self.lable bottomMargin:15];
}
-(UILabel *)lable{
    if (!_lable) {
        _lable  =[[UILabel alloc]init];
        _lable.font  =[UIFont systemFontOfSize:14];
        _lable.text =@"标题";
        _lable.textColor = [UIColor blackColor];
    }
    return _lable;
}
-(SWBaseView *)line{
    if (!_line) {
        _line =[[SWBaseView alloc]init];
        _line.backgroundColor = [SWKit colorWithHexString:@"f5f5f5"];
    }
    return _line;
}

@end
