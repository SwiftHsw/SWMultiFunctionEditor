//
//  SWEditorBorderCell.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWEditorBoderViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SWEditorBorderCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic , strong)SWEditorBoderViewModel * model;
@end

NS_ASSUME_NONNULL_END
