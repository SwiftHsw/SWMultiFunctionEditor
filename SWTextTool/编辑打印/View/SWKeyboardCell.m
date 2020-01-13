//
//  SWKeyboardCell.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWKeyboardCell.h"

 
@interface SWKeyboardCell ()
@property (nonatomic , strong)UILabel * titile;


@end
@implementation SWKeyboardCell
-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    self.backgroundColor =[UIColor whiteColor];
    [self.contentView sd_addSubviews:@[self.imageView,self.titile]];
    self.imageView.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.contentView, 10)
    .heightIs(20)
    .widthIs(20);
    
    self.titile.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.imageView, 5)
    .heightIs(12);
    [self.titile setSingleLineAutoResizeWithMaxWidth:50];
    
    
}
-(void)setModel:(SWKeyboardToolModel *)model{
    _model = model;
    self.titile.text = model.titile;
}

#pragma mark ------lazy---------
-(UILabel *)titile{
    if (!_titile) {
        _titile = [[UILabel alloc]init];
        _titile.font =[UIFont systemFontOfSize:10];
        _titile.textColor = [UIColor blackColor];
        _titile.textAlignment = NSTextAlignmentCenter;
    }
    return _titile;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView= [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor clearColor];
        kImageContenMode(_imageView);
        
    }
    return _imageView;
}
@end
 
