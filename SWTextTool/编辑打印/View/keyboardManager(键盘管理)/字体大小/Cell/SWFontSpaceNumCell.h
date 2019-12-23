//
//  SWFontSpaceNumCell.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWFontSpceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SWFontSpaceNumCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (nonatomic , strong)SWFontSpceModel * model;
@end

NS_ASSUME_NONNULL_END
