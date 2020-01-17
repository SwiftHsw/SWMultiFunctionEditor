//
//  YZPathModel.h
//  HuiZhi
//
//  Created by admin on 2019/7/18.
//  Copyright © 2019年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, MHPathModelAction) {
    MHPathModelActionNone = 0,
    
    MHPathModelActionUndo = 1 << 0,
    MHPathModelActionRepeat = 1 << 1,
    MHPathModelActionInsertImage = 1 << 2,
    MHPathModelActionBackgroundImage = 1 << 3,
    
    MHPathModelActionLine = 1 << 16,
    MHPathModelActionStraightLine = 1 << 17,
    MHPathModelActionCircle = 1 << 18,
    MHPathModelActionRectangle = 1 << 19,
    MHPathModelActionPolygon = 1 << 20,
    MHPathModelActionText = 1 << 21
};

@interface YZPathModel : NSObject

@property(assign, nonatomic)MHPathModelAction action;
@property(strong, nonatomic)UIBezierPath *path;
@property(strong, nonatomic)UIColor *color;
@property(nonatomic, assign)BOOL isDraw;
@property(strong, nonatomic)NSString *text;

@property(strong, nonatomic)UIFont *font;

+ (NSArray<NSValue *> *)pathPointsWithCGPath:(CGPathRef)path;

+ (instancetype)pathModelWithAction:(MHPathModelAction)action path:(CGPathRef)path lineWidth:(CGFloat)lineWidth color:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
