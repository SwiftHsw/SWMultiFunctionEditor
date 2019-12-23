//
//  SWBaseLable.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWBaseLable.h"

@implementation SWBaseLable
 
@synthesize contentEdgeInsets = _contentEdgeInsets;
- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
{
    _contentEdgeInsets = contentEdgeInsets;
    _topEdge = _contentEdgeInsets.top;
    _leftEdge = _contentEdgeInsets.left;
    _rightEdge = _contentEdgeInsets.right;
    _bottomEdge = _contentEdgeInsets.bottom;
    
    [self invalidateIntrinsicContentSize];
}
- (void)setTopEdge:(CGFloat)topEdge
{
    _topEdge = topEdge;
    [self invalidateIntrinsicContentSize];
}
 
- (void)setLeftEdge:(CGFloat)leftEdge
{
    _leftEdge = leftEdge;
    [self invalidateIntrinsicContentSize];
}
 
- (void)setBottomEdge:(CGFloat)bottomEdge
{
    _bottomEdge = bottomEdge;
    [self invalidateIntrinsicContentSize];
}
 
- (void)setRightEdge:(CGFloat)rightEdge
{
    _rightEdge = rightEdge;
    [self invalidateIntrinsicContentSize];
}
 
- (UIEdgeInsets)contentEdgeInsets
{
    _contentEdgeInsets = UIEdgeInsetsMake(_topEdge, _leftEdge, _bottomEdge, _rightEdge);
    return _contentEdgeInsets;
}
 
- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    size.height += (_topEdge  + _bottomEdge);
    size.width  += (_leftEdge + _rightEdge);
    return size;
}
 
- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize newSize = [super sizeThatFits:size];
    newSize.height += (_topEdge  + _bottomEdge);
    newSize.width  += (_leftEdge + _rightEdge);
    return newSize;
}
 
-(void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(_topEdge, _leftEdge, _bottomEdge, _rightEdge))];
}

-(CGSize)getSize{
     CGSize size = [self sizeWithFont:self.font string:self.text];
    return CGSizeMake(size.width+60, size.height+15);
    
}

-(CGSize)sizeWithFont:(UIFont *)font string:(NSString *)string{
    
    NSDictionary *attrs = @{NSFontAttributeName:font};
    
    return [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

 
