//
//  UIView+Extension.m
//  ailixiong
//
//  Created by admin on 2019/3/13.
//  Copyright © 2019年 ileadtek Co.,Ltd. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

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
                    radius:(CGFloat)radiusvalue
{
    // 阴影颜色
    self.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    self.layer.shadowOffset = rect;
    // 阴影透明度，默认0
    self.layer.shadowOpacity =  opacityValue;
    // 阴影半径，默认3
    self.layer.shadowRadius = radiusvalue;
}
//使用该方法不会模糊，根据屏幕密度计算
- (UIImage *)convertViewToImage {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    CGSize size = CGSizeMake(self.frame.size.width-1,self.frame.size.height-1);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
    
}



//使用该方法不会模糊，根据屏幕密度计算
- (UIImage *)convertViewToImage:(CGFloat)magrin {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    CGSize size = CGSizeMake(self.frame.size.width,self.frame.size.height-magrin);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
    
}
-(UIImage *)addHeadImage:(UIImage *)headImage footImage:(UIImage *)footImage toMasterImage:(UIImage *)masterImage {
    
    CGSize size;
    size.width = masterImage.size.width;
    
    CGFloat headHeight = !headImage? 0:size.width/headImage.size.width*headImage.size.height;
    CGFloat footHeight = !footImage? 0:size.width/footImage.size.width*footImage.size.height;
    
    //    CGFloat headHeight = !headImage? 0:headImage.size.height/2.0;
    //    CGFloat footHeight = !footImage? 0:footImage.size.height/2.0;
    
    size.height = masterImage.size.height + headHeight + footHeight;
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    if (headImage)
        [headImage drawInRect:CGRectMake(0, 0, masterImage.size.width, headHeight)];
    
    
    [masterImage drawInRect:CGRectMake(0, headHeight, masterImage.size.width, masterImage.size.height)];
    
    if (footImage)
        [footImage drawInRect:CGRectMake(0, masterImage.size.height + headHeight, masterImage.size.width, footHeight)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return resultImage;
}
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

-(void)LX_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(LXShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth{
    
    
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = shadowColor.CGColor;
    
    self.layer.shadowOpacity = shadowOpacity;
    
    self.layer.shadowRadius =  shadowRadius;
    
    self.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;
    
    CGFloat originX = 0;
    
    CGFloat originY = 0;
    
    CGFloat originW = self.bounds.size.width;
    
    CGFloat originH = self.bounds.size.height;
    
    
    switch (shadowPathSide) {
        case LXShadowPathTop:
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW,  shadowPathWidth);
            break;
        case LXShadowPathBottom:
            shadowRect  = CGRectMake(originX, originH -shadowPathWidth/2, originW, shadowPathWidth);
            break;
            
        case LXShadowPathLeft:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
            
        case LXShadowPathRight:
            shadowRect  = CGRectMake(originW - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case LXShadowPathNoTop:
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY +1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case LXShadowPathAllSide:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY - shadowPathWidth/2, originW +  shadowPathWidth, originH + shadowPathWidth);
            break;
            
    }
    
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
    
    self.layer.shadowPath = path.CGPath;
    
}
@end
