//
//  YZDrawToolView.h
//  Printer
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 admin. All rights reserved.
//

#import "SWBaseView.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YZDrawToolViewDelegate <NSObject>

-(void)yz_drawToolViewComletion:(SWDrawToolType)type;

@end
@interface YZDrawToolView : SWBaseView

@property (nonatomic , weak)id<YZDrawToolViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
