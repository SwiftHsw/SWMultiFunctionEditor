//
//  SWThemeView.h
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/23.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWBaseView.h"

NS_ASSUME_NONNULL_BEGIN
@interface SWThemeView : SWBaseView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

NS_ASSUME_NONNULL_END
