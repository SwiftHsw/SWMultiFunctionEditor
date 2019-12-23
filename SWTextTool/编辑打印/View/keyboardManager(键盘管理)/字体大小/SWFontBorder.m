//
//  SWFontBorder.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFontBorder.h"
#import "SWEditorBoderViewModel.h"
#import "SWEditorBorderCell.h"
#import "SWEditorBorderModel.h"


@interface SWFontBorder() <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UICollectionView* collectionView;
@property (nonatomic , strong)SWEditorBoderViewModel * VM;
@end

@implementation SWFontBorder

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
/**
 分区内cell之间的最小列间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemW = (self.width - (10*4) )/4;
    return CGSizeMake(itemW, itemW*.6);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ///发送添加文本贴纸
    
    SWEditorBorderCell *cell = (SWEditorBorderCell*)[collectionView cellForItemAtIndexPath:indexPath];
    SWEditorBorderModel * model = self.VM.dataArray[indexPath.row];
    [kNoti postNotificationName:INSERTTEXT object:cell.imageView.image userInfo:@{@"info":model}];
}

/**
 创建cell
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    SWEditorBorderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    SWEditorBorderModel * model = self.VM.dataArray[indexPath.row];
 
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
   
    return cell;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
       _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"SWEditorBorderCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        _collectionView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator =NO;
    }
    return _collectionView;
}
- (SWEditorBoderViewModel *)VM{
    if (!_VM) {
        _VM  = [[SWEditorBoderViewModel alloc]init];
    }
    return _VM;
}
@end
