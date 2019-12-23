//
//  SWFontSpaceNumCell.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFontSpaceNumCell.h"

@implementation SWFontSpaceNumCell

 -(void)setModel:(SWFontSpceModel *)model{
     _model= model;
     self.number.text = model.titile;
     
     self.backgroundColor = model.isSelect ?[UIColor greenColor]:[SWKit colorWithHexString:@"#f5f5f5"];
  
 }

@end
