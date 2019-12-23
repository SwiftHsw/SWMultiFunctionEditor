//
//  SWThemeCell.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/23.
//  Copyright © 2019 sw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SWThemeModel;
@interface SWThemeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *themImage;
@property (nonatomic,strong) SWThemeModel *model;

@end

NS_ASSUME_NONNULL_END
