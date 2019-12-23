
//
//  SWEditorBoderViewModel.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWEditorBoderViewModel.h"
#import "SWEditorBorderModel.h"

@implementation SWEditorBoderViewModel


-(RACCommand *)dataCmd{
    if (!_dataCmd) {
        _dataCmd = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            SWWeakSelf(self)
            NSString *lang_type = @"0";
            RACSignal *singnal = [[YZNetWorking getShard]postWithURL:RobotText withParamater:@{@"type":lang_type}];
            [singnal subscribeNext:^(id  _Nullable x) {
                SWLog(@"%@",x);
                SWStrongSelf(self)
                if ([x[@"status"]integerValue] == 1) {
                    NSArray *tmp = x[@"data"];
                    self.dataArray = [[tmp.rac_sequence map:^id _Nullable(id  _Nullable value) {
                        SWEditorBorderModel *model = [SWEditorBorderModel mj_objectWithKeyValues:value];
                        return model;
                    }]array].mutableCopy;
                }
            }];
            return singnal;
            
        }];
    }
    return _dataCmd;
}
@end
