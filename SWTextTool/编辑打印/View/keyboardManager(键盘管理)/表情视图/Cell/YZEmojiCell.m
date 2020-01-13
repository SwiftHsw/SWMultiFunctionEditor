//
//  YZEmojiCell.m
//  Printer
//
//  Created by admin on 2019/11/20.
//  Copyright © 2019 admin. All rights reserved.
//

#import "YZEmojiCell.h"

@implementation YZEmojiCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.borderWidth = 1;
    self.layer.borderColor = [SWKit colorWithHexString:@"#f5f5f5"].CGColor;
    self.layer.cornerRadius = 3;
}

@end
