//
//  UIView+Extension.h
//  ailixiong
//
//  Created by admin on 2019/3/13.
//  Copyright © 2019年 ileadtek Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum :NSInteger{
    
    LXShadowPathLeft,
    
    LXShadowPathRight,
    
    LXShadowPathTop,
    
    LXShadowPathBottom,
    
    LXShadowPathNoTop,
    
    LXShadowPathAllSide
    
} LXShadowPathSide;
@interface UIView (Extension)

/**
 给视图添加四边阴影效果
 
 @param theColor 颜色
 @param rect 阴影偏移
 @param opacityValue 透明度
 @param radiusvalue 半径
 */
- (void)addShadowWithColor:(UIColor *)theColor
                    offset:(CGSize)rect
                   opacity:(CGFloat)opacityValue
                    radius:(CGFloat)radiusvalue;

/**
 把uiview对象转成image对象

 @return image
 */
- (UIImage *)convertViewToImage;


- (UIImage *)convertViewToImage:(CGFloat)magrin;

/**
 拼接图片
 */
-(UIImage *)addHeadImage:(UIImage *)headImage footImage:(UIImage *)footImage toMasterImage:(UIImage *)masterImage;
/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 
 * shadowPathWidth 阴影的宽度，
 
 */

-(void)LX_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(LXShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;
@end
