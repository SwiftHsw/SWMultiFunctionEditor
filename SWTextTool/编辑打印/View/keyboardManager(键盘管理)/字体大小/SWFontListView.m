
//
//  SWFontListView.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFontListView.h"
#import "SWFontSizeSliderView.h"
#import "SWFontViewModel.h"
#import "SWFontStyleCell.h"
#import "SWFontModel.h"
@interface SWFontListView ()<UICollectionViewDelegate,UICollectionViewDataSource,SWFontStyleCellDelegate>
@property (nonatomic , strong) UICollectionView* collectionView;
@property (nonatomic , strong) SWFontViewModel* VM;
@property (nonatomic , strong) SWFontModel* oldSelectModel;
@end
@implementation SWFontListView

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.collectionView];
    
    ///获取网络数据
    SWWeakSelf(self);
    [[self.VM.dataCmd execute:nil]subscribeNext:^(id  _Nullable x) {
        [weakself.collectionView reloadData];
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.VM.dataArray.count;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SWFontModel * model = self.VM.dataArray[indexPath.row];
    
    ///判断是否存在下载
     NSString * fontName = [NSString stringWithFormat:@"%@/%@",FontName,model.name];
      if ([JRSandBoxPath isFileExist:fontName]) {
          model.isSelect = YES;
          self.oldSelectModel.isSelect =NO;
          self.oldSelectModel = model;
          [kNoti postNotificationName:CHNAGEFONTSTYLE object:model];
          [self.collectionView reloadData];
          return;
      }
    
    if (model.status==SWDownload_Status_downloading || model.status==SWDownload_Status_complete) {
         NSLog(@"下载，不要操作");
         return;
     }
     [model downLoadFont];
}
/**
 分区内cell之间的最小列间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
return UIEdgeInsetsMake(0, 20, 0, 20);//分别为上、左、下、右

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemW = (self.width - (20*3) )/2;
    return CGSizeMake(itemW, 40);
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeMake(self.frame.size.width, 130);
    return size;
}
/**
 创建cell
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    SWFontStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    SWFontModel * model = self.VM.dataArray[indexPath.row];
    cell.listView = self.collectionView;
    cell.delegate = self;
    [cell setModel:model];
    return cell;
}

// 创建一个继承collectionReusableView的类,用法类比tableViewcell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SWFontSizeSliderView *tempHeaderView =(SWFontSizeSliderView*) [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        reusableView = (UICollectionReusableView*)tempHeaderView;
    }
    return reusableView;
}
//下载完毕
-(void)downLoadEnd:(SWFontModel *)model{
     model.isSelect = YES;
     self.oldSelectModel.isSelect =NO;
     self.oldSelectModel = model;
     [kNoti postNotificationName:CHNAGEFONTSTYLE object:model];
     [self.collectionView reloadData];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
       _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"SWFontStyleCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[SWFontSizeSliderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        _collectionView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator =NO;
    }
    return _collectionView;
}
- (SWFontViewModel *)VM{
    if (!_VM) {
        _VM  = [[SWFontViewModel alloc]init];
    }
    return _VM;
}


@end

