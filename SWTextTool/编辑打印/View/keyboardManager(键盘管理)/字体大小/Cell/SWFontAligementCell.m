//
//  SWFontAligementCell.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFontAligementCell.h"
@interface SWFontAligementCell ()
@property (nonatomic , strong)UIButton * oldButton;
@end
@implementation SWFontAligementCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubViews];
    }
    return self;
}
-(void)setSubViews{
    self.lable.text =@"对齐";
     UIView * leftView = self.contentView;
     CGFloat leftV = 30;
     NSArray * img = @[@"左",@"中",@"右"];
     for (int i = 0; i<3; i++) {
         UIButton * button = [[UIButton alloc]init];
         button.backgroundColor =[SWKit colorWithHexString:@"#f5f5f5"];
         [button setTitle:img[i] forState:(UIControlStateNormal)];
         button.titleLabel.font =[UIFont systemFontOfSize:10];
         button.tag  =i;
          [button setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
         [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
         [button addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
         [self.contentView addSubview:button];
         button.sd_layout
         .leftSpaceToView(leftView, leftV)
         .topSpaceToView(self.lable, 10)
         .heightIs(40)
         .widthIs(40);
         leftView = button;
         leftV = 15;
         if (i==0) {
             self.oldButton = button;
             button.selected  = YES;
         }
     }
     
     [self setupAutoHeightWithBottomView:leftView bottomMargin:15];
       
}
-(void)click:(UIButton*)button{
    if ([button isEqual:self.oldButton]) {
        return;
    }
    button.selected = !button.selected;
    self.oldButton.selected = NO;
    self.oldButton = button;
    
    SWFontTextAligementType type = button.tag;
    NSDictionary * dict = @{@"type":@(type)};
    [kNoti postNotificationName:FONTALIGMENT object:nil userInfo:dict];
    
    
}
@end
