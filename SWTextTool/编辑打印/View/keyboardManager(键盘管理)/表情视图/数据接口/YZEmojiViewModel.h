//
//  YZEmojiViewModel.h
//  Printer
//
//  Created by admin on 2019/11/20.
//  Copyright © 2019 admin. All rights reserved.
//

 
NS_ASSUME_NONNULL_BEGIN

@interface YZEmojiViewModel : NSObject
///数据命令
@property (nonatomic , strong)RACCommand * dataCmd;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
