//
//  YZDrawWithView.h
//  Printer
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 admin. All rights reserved.
//

#import "SWBaseView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol YZDrawWithViewDelegate <NSObject>

-(void)yz_chooseLineWidth:(CGFloat)width;

@end
@interface YZDrawWithView : SWBaseView
@property (nonatomic  ,weak)id<YZDrawWithViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
