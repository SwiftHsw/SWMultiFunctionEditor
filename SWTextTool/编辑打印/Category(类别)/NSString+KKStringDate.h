//
//  NSString+KKStringDate.h
//  QuicklyGo_Driver
//
//  Created by xxf on 16/9/21.
//  Copyright © 2016年 lk06. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (KKStringDate)

+(NSString *)lfstringDate;

//只显示时分
+(NSString *)kHourAndMminuteDate;

//字典转json格式字符串
+ (NSString *)dictionaryToJson:(id)dic;

- (NSInteger)getStringLenthOfBytes;

- (NSString *)subBytesOfstringToIndex:(NSInteger)index;
//价格去除后面的00.00
+(NSString*)removeFloatAllZero:(CGFloat)price;
+(NSString*)removeStrAllZero:(NSString*)string;
@end
