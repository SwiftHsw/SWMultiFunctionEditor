//
//  SWFontViewModel.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWFontViewModel : NSObject
///数据命令
@property (nonatomic , strong)RACCommand * dataCmd;
///数据
@property (nonatomic , strong)NSMutableArray * dataArray;

@end

NS_ASSUME_NONNULL_END
