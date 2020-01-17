//
//  YZDrawToolView.m
//  Printer
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 admin. All rights reserved.
//

#import "YZDrawToolView.h"

@implementation YZDrawToolView

- (IBAction)actionClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(yz_drawToolViewComletion:)]) {
        [self.delegate yz_drawToolViewComletion:sender.tag];
    }
}


@end
