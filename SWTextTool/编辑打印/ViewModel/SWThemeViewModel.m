//
//  SWThemeViewModel.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/23.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWThemeViewModel.h"
#import "SWThemeModel.h"

@implementation SWThemeViewModel
-(RACCommand *)dataCmd{
   if (!_dataCmd) {
        _dataCmd = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @weakify(self);
            
            //语言ID
            NSString * lang_type = @"0";
            RACSignal * signal= [[YZNetWorking getShard]postWithURL:Theme withParamater:@{@"type":lang_type}];
            [signal subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                if ([x[@"status"]integerValue]==1) {
                  NSArray * tmp = x[@"data"];
                 self.dataArray = [[tmp.rac_sequence map:^id _Nullable(id  _Nullable value) {
                        SWThemeModel * model = [SWThemeModel mj_objectWithKeyValues:value];
                        return model;
                    }]array].mutableCopy;
                    
//                    SWThemeModel * m =[SWThemeModel new];
//                    m.image_url =@"";
//                    [self.dataArray insertObject:m atIndex:0];
                    
                }
                
            }];
            return signal;
        }];
    }
    return _dataCmd;
}
@end
