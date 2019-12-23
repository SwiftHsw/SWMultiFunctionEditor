//
//  SWBaseLable.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWBaseLable : UILabel
@property (nonatomic, assign) IBInspectable CGFloat topEdge;
@property (nonatomic, assign) IBInspectable CGFloat leftEdge;
@property (nonatomic, assign) IBInspectable CGFloat bottomEdge;
@property (nonatomic, assign) IBInspectable CGFloat rightEdge;
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;

-(CGSize)getSize;
@end

NS_ASSUME_NONNULL_END
