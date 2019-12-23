
//
//  SWFontStyleCell.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFontStyleCell.h"

@implementation SWFontStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 3;
    self.clipsToBounds = YES;
    self.layer.borderWidth = .5;
    self.layer.borderColor = [SWKit colorWithHexString:@"#BBBBBB"].CGColor;
    
    [self.contentView addSubview:self.progress];
    self.progress.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(0);
    

    
}

-(void)setModel:(SWFontModel *)model{
    _model = model;
    [self.imageVi sd_setImageWithURL:[NSURL URLWithString:_model.image]];

 
    if (_model.countOfBytesExpectedToReceive!=0) {
          self.progress.hidden = NO;
      }else{
          self.progress.hidden = YES;
      }
    
    _model.delegate = self;
    
     CGFloat x2 =  self.contentView.size.width/100*model.countOfBytesExpectedToReceive;
     self.progress.sd_layout
     .widthIs(x2);
     [self.progress updateLayout];
    
    self.layer.borderColor =  _model.isSelect ? [UIColor redColor].CGColor:[SWKit colorWithHexString:@"#BBBBBB"].CGColor;
 
    
}

#pragma mark - SWFontModel Delegate
- (void)downloadItem:(SWFontModel *)item totalBytesWritten:(CGFloat)totalBytesWritten totalBytesExpectedToWrite:(CGFloat)totalBytesExpectedToWrite{
    ///计算长度
       CGFloat x = 100.0 * totalBytesWritten / totalBytesExpectedToWrite;
       CGFloat x2 =  self.contentView.size.width/100*x;
       self.progress.sd_layout
       .widthIs(x2);
       [self.progress updateLayout];
       
       NSLog(@"下载进度-d--%lf%%",x2);
    
}
//开始下载
-(void)downloadBegin:(SWFontModel *)item{
    [self.listView reloadData];
}
//下载结束
- (void)downloadEnd:(BOOL)isOk{
    [self.listView reloadData];
    if (isOk) {
        if ([self.delegate respondsToSelector:@selector(downLoadEnd:)]) {
            [self.delegate downLoadEnd:self.model];
        }
    }
}

-(UIView *)progress{
    if (!_progress) {
         _progress  =[[UIView alloc]init];
         _progress.backgroundColor =[[UIColor redColor]colorWithAlphaComponent:0.5];
         _progress.layer.cornerRadius = 3;
         _progress.clipsToBounds = YES;
    }
    return _progress;
}

@end
