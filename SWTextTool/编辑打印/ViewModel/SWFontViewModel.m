//
//  SWFontViewModel.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFontViewModel.h"
#import "SWFontModel.h"

@implementation SWFontViewModel
-(RACCommand *)dataCmd{
   if (!_dataCmd) {
         @weakify(self);
        _dataCmd = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            //语言ID
            NSString * lang_type = @"1";
            RACSignal * signal= [[YZNetWorking getShard]postWithURL:RobotTff withParamater:@{@"lang_type":lang_type}];
            [signal subscribeNext:^(id  _Nullable x) {
                NSLog(@"%@",x);
                @strongify(self);
               if ([x[@"status"]integerValue]==1) {
                      NSArray * tmp = x[@"data"];
                   self.dataArray = [[tmp.rac_sequence map:^id _Nullable(id  _Nullable value) {
                          SWFontModel * model = [SWFontModel mj_objectWithKeyValues:value];
                          return model;
                      }]array].mutableCopy;
                  }
                
            }];
            return signal;
        }];
    }
    return _dataCmd;
}
@end
