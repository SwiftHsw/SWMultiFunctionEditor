//
//  SWThemeView.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/23.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWThemeView.h"
#import "SWThemeViewModel.h"
#import "SWThemeCell.h"
#import "SWThemeModel.h"
@interface SWThemeView()
@property (nonatomic,strong) SWThemeViewModel *VM;
@end

@implementation SWThemeView

 

- (void)awakeFromNib{
    [super awakeFromNib];
    self.collection.delegate = self;
    self.collection.dataSource =self;
    self.collection.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.collection registerNib:[UINib nibWithNibName:@"SWThemeCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    SWWeakSelf(self);
    [[self.VM.dataCmd execute:nil]subscribeNext:^(id  _Nullable x) {
        [weakself.collection reloadData];
    }];
}
#pragma mark -----UICollectionViewDelegate-----
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.VM.dataArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemW = (collectionView.width - (10*5) )/3;
    return CGSizeMake(itemW, self.height-20);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    SWThemeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.model = self.VM.dataArray[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ///下载大图
    SWThemeModel * theme= self.VM.dataArray[indexPath.row];
 

    if (!theme.thumb_img) {
        [kNoti postNotificationName:INSERTTHEME object:theme userInfo:@{@"image":@""}];
        return;
    }
    ///获取缓存图片
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache queryCacheOperationForKey:theme.thumb_img done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
  //从缓存找，没有的话 直接下载
        if (image) {
            [kNoti postNotificationName:INSERTTHEME object:theme userInfo:@{@"image":image}];
            NSLog(@"缓存图片");
            return;
        }
        [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:theme.thumb_img] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
               if (image) {
                    NSLog(@"下载图片");
                   ///缓存图片
                   
                   [[SDImageCache sharedImageCache]storeImage:image forKey:theme.thumb_img toDisk:YES completion:nil];

                  dispatch_async(dispatch_get_main_queue(), ^{
                      [kNoti postNotificationName:INSERTTHEME object:theme userInfo:@{@"image":image}];
                  });
               }
           }];


    }];
    
   
}

-(SWThemeViewModel *)VM{
    if (!_VM) {
        _VM = [[SWThemeViewModel alloc]init];
    }
    return _VM;
}

-(void)layoutSubviews{
    [self LX_SetShadowPathWith:
    [[SWKit colorWithHexString:@"#000000"]colorWithAlphaComponent:0.15]
     shadowOpacity:1
     shadowRadius:4
     shadowSide:LXShadowPathTop
      shadowPathWidth:-2];
}

@end
