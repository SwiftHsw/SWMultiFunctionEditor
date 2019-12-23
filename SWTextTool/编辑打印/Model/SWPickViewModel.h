//
//  SWPickViewModel.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SolidLine =0,//实线
    DashLine =1//虚线
} LineStyle;

@interface SWPickViewModel : NSObject
@property (nonatomic , assign)CGFloat lineWidth;

@property (nonatomic , strong)UIColor * boderColor;

@property (nonatomic , assign)LineStyle style;

@property (nonatomic , assign)NSInteger layout;

@property (nonatomic , assign)NSInteger row;

@property (nonatomic , assign)NSInteger col;
@end

NS_ASSUME_NONNULL_END
