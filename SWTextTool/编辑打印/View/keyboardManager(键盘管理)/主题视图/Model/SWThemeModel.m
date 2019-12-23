//
//  SWThemeModel.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/23.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWThemeModel.h"

@implementation SWThemeModel
-(NSDictionary*)getThemeImage:(CGFloat)width image:(UIImage*)themeImage{
       UIImage *backGroundimage = themeImage;
       CGFloat strImageH=themeImage.size.height;
       CGFloat viewWidth=width;
       CGFloat scaleSize=viewWidth/backGroundimage.size.width;
       backGroundimage=[self scaleImage:backGroundimage toScale:scaleSize];
       CGFloat scaleH=backGroundimage.size.height/strImageH;
     
       ///顶部图片
       CGRect rects = CGRectMake(0, 0, backGroundimage.size.width,self.head_px*scaleH);
       CGImageRef imageTopRef =CGImageCreateWithImageInRect([backGroundimage CGImage], rects);
       UIImage *imageTop = [UIImage imageWithCGImage:imageTopRef];
      
       
       
       ///底部图片
       rects = CGRectMake(0, backGroundimage.size.height-self.ios_tail_px *scaleH, backGroundimage.size.width,self.ios_tail_px*scaleSize);
       CGImageRef imagebottomRef =CGImageCreateWithImageInRect([backGroundimage CGImage], rects);
       UIImage *imageBottom = [UIImage imageWithCGImage:imagebottomRef];
    
    
    
       ///中间图片
        CGFloat centerY=backGroundimage.size.height-self.ios_head_px-self.ios_tail_px;
        rects = CGRectMake(0, self.ios_head_px+centerY/2-self.ios_middle_px/2, backGroundimage.size.width, self.ios_middle_px);
        CGImageRef imageCenterRef =CGImageCreateWithImageInRect([backGroundimage CGImage], rects);
        UIImage *imageCenter = [UIImage imageWithCGImage:imageCenterRef];
      
      return @{@"top":imageTop,@"center":imageCenter,@"bttom":imageBottom};
    
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(CGFloat)scaleSize{
    int imageWidth=image.size.width * scaleSize;
    int imageHeight=image.size.height * scaleSize;
    UIGraphicsBeginImageContext(CGSizeMake(imageWidth, imageHeight));
    [image drawInRect:CGRectMake(0, 0, imageWidth, imageHeight)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end
