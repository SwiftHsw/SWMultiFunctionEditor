//
//  YZPathModel.m
//  HuiZhi
//
//  Created by admin on 2019/7/18.
//  Copyright © 2019年 admin. All rights reserved.
//

#import "YZPathModel.h"


@implementation YZPathModel

void MyCGPathApplierFunc (void *info, const CGPathElement *element) {
    NSMutableArray *pathPoints = (__bridge NSMutableArray *)info;
    CGPoint *points = element->points;
    CGPathElementType type = element->type;
    
    switch(type) {
        case kCGPathElementMoveToPoint: // contains 1 point
            [pathPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddLineToPoint: // contains 1 point
            [pathPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddQuadCurveToPoint: // contains 2 points
            [pathPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [pathPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            break;
            
        case kCGPathElementAddCurveToPoint: // contains 3 points
            [pathPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [pathPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            [pathPoints addObject:[NSValue valueWithCGPoint:points[2]]];
            break;
            
        case kCGPathElementCloseSubpath: // contains no point
            break;
    }
}
///CGPathRef 转成point
+ (NSArray<NSValue *> *)pathPointsWithCGPath:(CGPathRef)path
{
    NSMutableArray *points = [NSMutableArray array];
    CGPathApply(path, (__bridge void *)(points), MyCGPathApplierFunc);
    return points;
}

+ (instancetype)pathModelWithAction:(MHPathModelAction)action path:(CGPathRef)path lineWidth:(CGFloat)lineWidth color:(UIColor *)color
{
    YZPathModel *pathModel = [YZPathModel new];
    
    pathModel.action = action;
    pathModel.color = color;
    
    if (action & MHPathModelActionLine ||
        action & MHPathModelActionStraightLine) {
        pathModel.path = [UIBezierPath bezierPathWithCGPath:path];
    }
    else if (action & MHPathModelActionRectangle) {
        NSArray<NSValue *> *pathPoints = [self.class pathPointsWithCGPath:path];
        
        CGPoint firstPoint = pathPoints.firstObject.CGPointValue;
        CGPoint lastPoint = pathPoints.lastObject.CGPointValue;
        
        pathModel.path = [UIBezierPath bezierPathWithRect:CGRectMake(firstPoint.x, firstPoint.y, lastPoint.x - firstPoint.x, lastPoint.y - firstPoint.y)];
        CGFloat lengths[4] = {8,5,8,5};
        [pathModel.path setLineDash:lengths count:4 phase:0];

    }
    
    
    pathModel.path.lineWidth = lineWidth;
    pathModel.path.lineCapStyle = kCGLineCapRound;
    pathModel.path.lineJoinStyle = kCGLineJoinRound;
    
    return pathModel;
}

@end
