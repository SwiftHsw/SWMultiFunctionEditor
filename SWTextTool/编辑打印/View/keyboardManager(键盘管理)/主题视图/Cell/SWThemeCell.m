//
//  SWThemeCell.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/23.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWThemeCell.h"
#import "SWThemeModel.h"
@implementation SWThemeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 3;
    self.layer.borderColor  = [SWKit colorWithHexString:@"#f5f5f5"].CGColor;
    self.layer.borderWidth = 1;
}

-(void)setModel:(SWThemeModel *)model{
    _model = model;
    [self.themImage sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    
    
}
@end
