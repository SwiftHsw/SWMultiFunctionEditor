//
//  SWFontSizeSliderView.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFontSizeSliderView.h"
#import "PublicAudioPlayProgressView.h"

@interface SWFontSizeSliderView ()<PublicAudioPlayProgressViewDelegate>
@property (nonatomic , strong)UILabel * titile;
@property (nonatomic , strong)UILabel * titile2;
@property (nonatomic  ,strong)UIButton * subFontBtn;
@property (nonatomic  ,strong)UIButton * addFontBtn;
@property (nonatomic  ,strong)PublicAudioPlayProgressView * sliderView;
@end
@implementation SWFontSizeSliderView
-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        
        [self setUpUi];
    }
    return self;
}
-(void)setUpUi{
    [self sd_addSubviews:@[self.titile,
                           self.sliderView,
                           self.subFontBtn,
                           self.addFontBtn,
                           self.titile2]];
    
    self.titile.sd_layout
    .leftSpaceToView(self, 10)
    .topSpaceToView(self,10)
    .heightIs(14);
    [self.titile setSingleLineAutoResizeWithMaxWidth:100];
    
    
  
    self.addFontBtn.sd_layout
   .rightSpaceToView(self, 20)
   .centerYEqualToView(self.sliderView)
   .heightIs(20)
   .widthIs(20);
    
    self.subFontBtn.sd_layout
   .leftSpaceToView(self, 20)
   .centerYEqualToView(self.sliderView)
   .heightIs(20)
   .widthIs(20);

    
    self.titile2.sd_layout
   .leftSpaceToView(self, 10)
   .topSpaceToView(self.sliderView,15)
   .heightIs(14);
   [self.titile2 setSingleLineAutoResizeWithMaxWidth:100];
    
    
  
    
}
-(void)changePlayTimeByPublicAudioPlayProgressView:(int)playCount{
    [kNoti postNotificationName:CHNAGEFONT object:@(playCount)];
}
-(PublicAudioPlayProgressView *)sliderView{
    if (!_sliderView) {
        _sliderView = [[PublicAudioPlayProgressView alloc]initWithFrame:CGRectMake(50, 45, self.frame.size.width-100, 35)];
        [_sliderView changePlayProgress:40 totalLength:100];
         _sliderView.delegate = self;
    }
    return _sliderView;
}
-(UILabel *)titile{
    if (!_titile) {
        _titile  =[[UILabel alloc]init];
        _titile.text = @"字号";
        _titile.font  =[UIFont systemFontOfSize:14];
        _titile.textColor = [UIColor blackColor];
    }
    return _titile;
}
-(UILabel *)titile2{
    if (!_titile2) {
        _titile2  =[[UILabel alloc]init];
        _titile2.text = @"字体";
        _titile2.font  =[UIFont systemFontOfSize:14];
        _titile2.textColor = [UIColor blackColor];
    }
    return _titile2;
}
- (UIButton *)addFontBtn{
    if (!_addFontBtn) {
        _addFontBtn =[[UIButton alloc]init];
        _addFontBtn.backgroundColor =[SWKit randomColor];
    }
    return _addFontBtn;
}
- (UIButton *)subFontBtn{
    if (!_subFontBtn) {
        _subFontBtn =[[UIButton alloc]init];
        _subFontBtn.backgroundColor =[SWKit randomColor];
    }
    return _subFontBtn;
}
@end
