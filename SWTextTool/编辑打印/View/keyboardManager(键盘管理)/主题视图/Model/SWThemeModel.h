//
//  SWThemeModel.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/23.
//  Copyright © 2019 sw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SWThemeModel : NSObject

@property (nonatomic , copy)NSString * an_image;

@property (nonatomic , copy)NSString *create_time;

@property (nonatomic , copy)NSString *head_img;

@property (nonatomic , assign)CGFloat head_px;

@property (nonatomic , copy)NSString *id;

@property (nonatomic , copy)NSString *image_url;

@property (nonatomic , assign)CGFloat ios_head_px;

@property (nonatomic , assign)CGFloat ios_middle_px;

@property (nonatomic , assign)CGFloat ios_tail_px;

@property (nonatomic , copy)NSString *middle_img;

@property (nonatomic , assign)CGFloat  middle_px;

@property (nonatomic , copy)NSString *sort;

@property (nonatomic , copy)NSString *tail_img;

@property (nonatomic , assign)CGFloat  tail_px;

@property (nonatomic , copy)NSString *thumb_img;
///获取主题图片
/// @param width 显示的宽度
-(NSDictionary*)getThemeImage:(CGFloat)width image:(UIImage*)themeImage;
@end

 
