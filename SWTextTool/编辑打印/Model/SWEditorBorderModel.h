//
//  SWEditorBorderModel.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWEditorBorderModel : NSObject
@property (nonatomic ,assign)int add_x_px;
@property (nonatomic ,assign)int add_y_px;
@property (nonatomic ,copy)NSString * create_time;
@property (nonatomic ,copy)NSString * id;
@property (nonatomic ,copy)NSString * image_name;
@property (nonatomic ,copy)NSString * image_url;
@property (nonatomic ,assign)int  ios_add_x_px;
@property (nonatomic ,assign)int  ios_add_y_px;
@property (nonatomic ,assign)int  ios_reduce_x_px;
@property (nonatomic ,assign)int  ios_reduce_y_px;
@property (nonatomic ,assign)int  reduce_x_px;
@property (nonatomic ,assign)int  reduce_y_px;
@property (nonatomic ,assign)int  sort;
@property (nonatomic ,assign)int  type;
@end

NS_ASSUME_NONNULL_END
