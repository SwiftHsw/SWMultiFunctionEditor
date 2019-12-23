//
//  ListItem.h
//  GYStickerViewDemo
//
//  Created by admin on 2019/7/15.
//  Copyright © 2019年 HuangGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWBaseLable.h"
#import "SWPickViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ListItem : SWBaseLable

@property(nonatomic , strong)SWPickViewModel *fromStyle;

@property(nonatomic , strong)CAShapeLayer *border;

@property(nonatomic , strong)CAShapeLayer *border2;

@property(nonatomic , strong)UIBezierPath *pat;

@property(nonatomic , strong)UIBezierPath *pat2;

@property(nonatomic , strong)NSMutableArray *paths;
@end

NS_ASSUME_NONNULL_END
