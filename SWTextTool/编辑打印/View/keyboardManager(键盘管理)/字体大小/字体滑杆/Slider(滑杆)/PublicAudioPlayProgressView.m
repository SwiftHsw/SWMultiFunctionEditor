//
//  PublicAudioPlayProgressView.m
//  ProjectFramework
//
//  Created by 李海群 on 2019/4/24.
//  Copyright © 2019 hsrd-hq. All rights reserved.
//

#import "PublicAudioPlayProgressView.h"


@interface PublicAudioPlayProgressView ()

@property (nonatomic, assign) CGRect tempFrame;

@property (nonatomic, strong) UIButton *playTimeLabel;

@property (nonatomic, strong) UIView *backGaryView;//背景视图

@property (nonatomic, strong) UIView *backLoadProgressView;//加载进度视图

@property (nonatomic, strong) UIView *backGreenView;//已播放进度颜色视图

@property (nonatomic, assign) CGFloat backViewY;

@property (nonatomic, assign) CGFloat backViewH;

@property (nonatomic, assign) CGFloat playTimeW;//时间视图宽度

@property (nonatomic, assign) int totalLength;

@end

@implementation PublicAudioPlayProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tempFrame = frame;
        self.backViewH = 1.5;
        self.backViewY = (self.tempFrame.size.height - 1.5)/2.0f;
        self.playTimeW = 25;
        [self addSubview:self.backGaryView];
        [self addSubview:self.backLoadProgressView];
        [self addSubview:self.backGreenView];
        [self addSubview:self.playTimeLabel];
        
        self.backgroundColor = [UIColor whiteColor];

    }
    return self;
}

- (UIView *)backGaryView
{
    if (!_backGaryView) {
        _backGaryView = [[UIView alloc] initWithFrame:CGRectMake(0, self.backViewY, self.tempFrame.size.width, self.backViewH)];
//        _backGaryView.layer.masksToBounds = YES;
//        _backGaryView.layer.cornerRadius = self.backViewH/2.0f;
        _backGaryView.backgroundColor = [SWKit colorWithHexString:@"#E9E9E9"];
    }
    return _backGaryView;
}

- (UIView *)backLoadProgressView
{
    if (!_backLoadProgressView) {
        _backLoadProgressView = [[UIView alloc] initWithFrame:CGRectMake(0, self.backViewY, 0, self.backViewH)];
//        _backLoadProgressView.layer.masksToBounds = YES;
//        _backLoadProgressView.layer.cornerRadius = self.backViewH/2.0f;
        _backLoadProgressView.backgroundColor =[SWKit colorWithHexString:@"#E9E9E9"];
    }
    return _backLoadProgressView;
}

- (UIView *)backGreenView
{
    if (!_backGreenView) {
        _backGreenView = [[UIView alloc] initWithFrame:CGRectMake(0, self.backViewY, 0, self.backViewH)];
//        _backGreenView.layer.masksToBounds = YES;
//        _backGreenView.layer.cornerRadius = self.backViewH/2.0f;
        _backGreenView.backgroundColor = [SWKit colorWithHexString:@"#E9E9E9"];
    }
    return _backGreenView;
}

- (UIButton *)playTimeLabel
{
    if (!_playTimeLabel) {
        _playTimeLabel            = [UIButton new];
        _playTimeLabel.frame               = CGRectMake(0, 0, self.playTimeW, self.playTimeW);
        _playTimeLabel.backgroundColor     = [UIColor whiteColor];
        _playTimeLabel.layer.cornerRadius  = self.playTimeW/2;
        _playTimeLabel.layer.masksToBounds = NO;
        _playTimeLabel.titleLabel.font =[UIFont systemFontOfSize:10];
        [_playTimeLabel setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];

        _playTimeLabel.layer.shadowColor   = [UIColor lightGrayColor].CGColor;
        _playTimeLabel.layer.shadowOffset  = CGSizeMake(2, 3);
        _playTimeLabel.layer.shadowOpacity = 0.4;
        _playTimeLabel.layer.shadowRadius  = 5;
    
        UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(doMoveAction:)];
        _playTimeLabel.userInteractionEnabled = YES;
        [_playTimeLabel addGestureRecognizer:panGestureRecognizer];
        [self doMoveAction:panGestureRecognizer];
    }
    return _playTimeLabel;
}

-(void)doMoveAction:(UIPanGestureRecognizer *)recognizer{
    
    
    // Figure out where the user is trying to drag the view.
    
    CGPoint translation = [recognizer translationInView:self];
    CGPoint newCenter = CGPointMake(recognizer.view.center.x+ translation.x,
                                    recognizer.view.center.y + translation.y);
    //    限制屏幕范围：
    newCenter.y = MAX(recognizer.view.frame.size.height/2, recognizer.view.frame.size.width/2);
    newCenter.y = MIN(self.frame.size.height - recognizer.view.frame.size.height/2, recognizer.view.frame.size.width/2);
    newCenter.x = MAX(recognizer.view.frame.size.width/2, newCenter.x);
    newCenter.x = MIN(self.frame.size.width - recognizer.view.frame.size.width/2,newCenter.x);
//    newCenter.y =9;
    
    CGFloat totalW = self.tempFrame.size.width - self.playTimeW;
    CGFloat moveW = newCenter.x - recognizer.view.frame.size.width/2;
    int moveX = moveW/totalW*self.totalLength;
    

    
    recognizer.view.center = CGPointMake(newCenter.x, 17);
    [recognizer setTranslation:CGPointZero inView:self];
    
    CGRect greenRect = self.backGreenView.frame;
    greenRect.size.width = newCenter.x;
    self.backGreenView.frame = greenRect;
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        if ([self.delegate respondsToSelector:@selector(changePlayTimeByPublicAudioPlayProgressView:)]) {
            
            [self.delegate changePlayTimeByPublicAudioPlayProgressView:[self.playTimeLabel.titleLabel.text intValue]];
        }
    }
    self.currentFont = moveX;
    [self.playTimeLabel setTitle:[NSString stringWithFormat:@"%d",MIN(moveX+30, 100)] forState:(UIControlStateNormal)];
}

- (void)changeCanPlayAbleProgress:(int)progressFloat totalLength:(int)totalCount
{
}

- (void)changePlayProgress:(int)progressFloat totalLength:(int)totalCount
{
    if (progressFloat <= 0) {
        return;
    }
    if (totalCount <= 0 ) {
        return;
    }
    self.totalLength = totalCount;
    CGFloat moveX = (self.tempFrame.size.width - self.playTimeW)/totalCount;
    CGRect timeRect = self.playTimeLabel.frame;
    timeRect.origin.x = moveX*(progressFloat-30);
    timeRect.origin.y = 3;

    self.playTimeLabel.frame = timeRect;

    
    CGRect greenRect = self.backGreenView.frame;
    greenRect.size.width = timeRect.origin.x;
    self.backGreenView.frame = greenRect;
    
    [self.playTimeLabel setTitle: [NSString stringWithFormat:@"%d",(progressFloat)] forState:(UIControlStateNormal)];
    self.currentFont = progressFloat;
    
}

+ (instancetype)publicAudioPlayProgressView:(CGRect)frame
{
    PublicAudioPlayProgressView *view = [[PublicAudioPlayProgressView alloc] initWithFrame:frame];
    return view;
}

@end
