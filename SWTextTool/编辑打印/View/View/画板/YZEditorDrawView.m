//
//  YZEditorDrawView.m
//  Printer
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 admin. All rights reserved.
//

#import "YZEditorDrawView.h"

@implementation YZEditorDrawView
{
     CGMutablePathRef _currentPath;
     NSMutableArray<YZPathModel *> *_pathModelArray;
     BOOL  isDraw;
    UIColor * currentLineColor;

    NSMutableArray * _startY;
    NSMutableArray * _endY;
    
    NSMutableArray * _startX;
    NSMutableArray * _endX;

    
    YZPathModel * _maxModel;
    
  
}
-(id)init{
    if (self=[super init]) {
        currentLineColor = [UIColor blackColor];
        self.lineColor = [UIColor blackColor];
         [self customInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
    
}

- (void)customInit
{
    _pathModelArray = [NSMutableArray array];

    _pathModelAction = MHPathModelActionLine;
    _lineWidth = 6;
}

- (void)addPathModelToArray:(YZPathModel *)pathModel
{
    [_pathModelArray enumerateObjectsUsingBlock:^(YZPathModel * _Nonnull pathModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (pathModel.action & MHPathModelActionUndo) {
            [self->_pathModelArray removeObject:self->_pathModelArray[idx]];
        }
        
    }];
    [_pathModelArray addObject:pathModel];
}

#pragma mark - Draw UI

- (void)drawRect:(CGRect)rect
{

    _endY = [[NSMutableArray alloc]init];
    _startY = [[NSMutableArray alloc]init];
    
    _endX = [[NSMutableArray alloc]init];
    _startX = [[NSMutableArray alloc]init];
    
   
    [_pathModelArray enumerateObjectsUsingBlock:^(YZPathModel * _Nonnull pathModel, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (pathModel.action & MHPathModelActionUndo) return;
           [pathModel.color set];
           [pathModel.path stroke];
          
            CGFloat y = CGRectGetMaxY(pathModel.path.bounds);
            [_endY addObject:@(y)];
            [_startY addObject:@(pathModel.path.bounds.origin.y)];
            

            CGFloat x = CGRectGetMaxX(pathModel.path.bounds);
            [_endX addObject:@(x)];
            [_startX addObject:@(pathModel.path.bounds.origin.x)];
        
        
    }];
    
 
    ///当前绘制
    if (_currentPath) {
       UIColor * color =  _pathModelAction == MHPathModelActionRectangle?currentLineColor:[currentLineColor colorWithAlphaComponent:0.6];
        
        YZPathModel *pathModel = [YZPathModel pathModelWithAction:_pathModelAction path:_currentPath lineWidth:_lineWidth color:color];
        [pathModel.color set];
        [pathModel.path stroke];
        
    }
}

#pragma mark - Touches Event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (event.allTouches.count>=2) {return;}
    CGPoint location = [touches.anyObject locationInView:self];
    _currentPath = CGPathCreateMutable();
    CGPathMoveToPoint(_currentPath, NULL, location.x, location.y);

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (event.allTouches.count>=2) {return;}
    CGPoint location = [touches.anyObject locationInView:self];
    ///绘制线条
    CGPathAddLineToPoint(_currentPath, NULL, location.x, location.y);
    [self setNeedsDisplay];
    isDraw = YES;

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (event.allTouches.count>=2) {return;}
    
    YZPathModel *pathModel = [YZPathModel pathModelWithAction:_pathModelAction path:_currentPath lineWidth:_lineWidth color:currentLineColor];
    [self addPathModelToArray:pathModel];
    _currentPath = nil;
    
    [self setNeedsDisplay];
    isDraw = NO;
    pathModel.color = self.lineColor;
}

#pragma mark - Function

- (void)repeat
{
    self.backgroundColor =[UIColor whiteColor];
    [_pathModelArray removeAllObjects];
    
    for (YZPathModel *pathModel in [_pathModelArray reverseObjectEnumerator]) {
        if (! (pathModel.action & MHPathModelActionUndo)) {
            pathModel.action |= MHPathModelActionUndo;
            break;
        }
    }

    [self setNeedsDisplay];
}

- (void)undo
{
    for (YZPathModel *pathModel in _pathModelArray) {
        if (pathModel.action & MHPathModelActionUndo) {
            pathModel.action ^= MHPathModelActionUndo;
            break;
        }
//         pathModel.action ^= MHPathModelActionUndo;
    }

    [self setNeedsDisplay];
}

- (void)clearAll
{
    for (YZPathModel *pathModel in _pathModelArray) {
        pathModel.action |= MHPathModelActionUndo;
    }

    [self setNeedsDisplay];
}
-(UIImage*)clipImage{
    
    CGFloat maxlineW = 16;
    
    //最大值最大Y值
    CGFloat maxY = [[_endY valueForKeyPath:@"@max.floatValue"] floatValue];
    maxY = MIN(self.height, maxY);

    ///最小的最小Y
    CGFloat minY = [[_startY valueForKeyPath:@"@min.floatValue"] floatValue];
    minY = minY - maxlineW;
    minY = MAX(0, minY);
    

    
    CGFloat minX = [[_startX valueForKeyPath:@"@min.floatValue"] floatValue];
    minX = minX - maxlineW;
    minX = MAX(0, minX);
    
    CGFloat maxX = [[_endX valueForKeyPath:@"@max.floatValue"] floatValue];
    maxX = MIN(self.width, maxX);
    
    
    
    CGFloat h =   (maxY - minY) +  (maxY==self.height ? 0:maxlineW);
    CGFloat w = (maxX - minX) + (maxX==self.width ? 0:maxlineW);


    
   UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), NO,[UIScreen mainScreen].scale);

   CGContextRef context = UIGraphicsGetCurrentContext();
   CGContextSaveGState(context);
   CGContextTranslateCTM(context, - (minX), -(minY));
    [self.layer renderInContext:context];
   UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();

   CGContextRestoreGState(context);
   UIGraphicsEndImageContext();
    
    return capturedImage;

    
}

@end
