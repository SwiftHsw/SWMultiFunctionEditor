//
//  YZEmojiViewModel.m
//  Printer
//
//  Created by admin on 2019/11/20.
//  Copyright © 2019 admin. All rights reserved.
//

#import "YZEmojiViewModel.h"

@implementation YZEmojiViewModel
-(RACCommand *)dataCmd{
   if (!_dataCmd) {
        _dataCmd = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @weakify(self);
            
            //语言ID
            NSString * lang_type = @"0";
            RACSignal * signal= [[YZNetWorking getShard]postWithURL:Emoticon withParamater:@{@"type":lang_type}];
            [signal subscribeNext:^(id  _Nullable x) {
//                NSLog(@"%@",x);
                @strongify(self);
                self.dataArray = x[@"data"];
                
            }];
            return signal;
        }];
    }
    return _dataCmd;
}
@end
