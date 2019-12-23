//
//  SWEditorBorderCell.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWEditorBorderCell.h"

@implementation SWEditorBorderCell

 
- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.cornerRadius = 3;
    self.clipsToBounds = YES;
    self.layer.borderWidth = .5;
    self.layer.borderColor = [SWKit colorWithHexString:@"#BBBBBB"].CGColor;
    
}
-(void)setModel:(SWEditorBoderViewModel *)model{
    _model = model;
   
}
@end
