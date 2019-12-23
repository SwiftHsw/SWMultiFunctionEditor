//
//  SWFontStyleCell.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWFontModel.h"

NS_ASSUME_NONNULL_BEGIN

@class SWFontModel;
@protocol SWFontStyleCellDelegate <NSObject>

-(void)downLoadEnd:(SWFontModel*)model;

@end

@interface SWFontStyleCell : UICollectionViewCell<SWFontModelDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageVi;
@property (strong, nonatomic)  UIView *progress;
@property (nonatomic , strong)SWFontModel * model;
@property (nonatomic , weak)id<SWFontStyleCellDelegate> delegate;
@property (nonatomic  ,strong)UICollectionView * listView;
@end

NS_ASSUME_NONNULL_END
