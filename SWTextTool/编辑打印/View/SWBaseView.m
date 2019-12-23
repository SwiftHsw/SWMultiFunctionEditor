//
//  SWBaseView.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWBaseView.h"
#import <SWKit.h>

@implementation SWBaseView

 +(instancetype)shareInstance {
     
//     YZBaseView * view = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
//     return view;
     return [self sw_viewFromXib];
 }
@end
