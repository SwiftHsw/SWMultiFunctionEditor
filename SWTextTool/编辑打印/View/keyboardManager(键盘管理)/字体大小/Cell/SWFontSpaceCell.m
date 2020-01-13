//
//  SWFontSpaceCell.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFontSpaceCell.h"
#import "SWFontSpceModel.h"
#import "SWFontSpaceNumCell.h"

@interface SWFontSpaceCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong)UICollectionView * collectionView;
@property (nonatomic , strong)NSMutableArray * data;
@property (nonatomic , strong)SWFontSpceModel * selectModel;
@end
@implementation SWFontSpaceCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubView];
    }
    return self;
}
-(void)setUpSubView{
    [self.contentView addSubview:self.collectionView];
    
    self.collectionView.sd_layout
    .topSpaceToView(self.lable, 10)
    .leftSpaceToView(self.contentView, 30)
    .heightIs(40)
    .rightSpaceToView(self.contentView, 30);
    
    
    [self setupAutoHeightWithBottomView:self.collectionView bottomMargin:15];
    self.line.hidden = YES;
    
      self.lable.text =@"间距";
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    SWFontSpaceNumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    SWFontSpceModel * m = self.data[indexPath.row];
    [cell setModel:m];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
      SWFontSpceModel * m = self.data[indexPath.row];
    m.isSelect = YES;
    self.selectModel.isSelect = NO;
    self.selectModel = m;
    [self.collectionView reloadData];
    [kNoti postNotificationName:FONTROWMAGIN object:m.titile];
}

/**
 分区内cell之间的最小列间距
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(40, 40);
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
       _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"SWFontSpaceNumCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        _collectionView.layer.cornerRadius = 3;
        _collectionView.clipsToBounds =YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator =NO;
    }
    return _collectionView;
}

-(NSMutableArray*)data{
    if (!_data) {
        _data  =[NSMutableArray new];
        NSMutableArray * nums =[[NSMutableArray alloc]initWithObjects:@"0.3",@"0.5",@"1.0",@"1.5", @"2.0",@"2.5",@"3.0",@"3.5",@"4.0",@"5.0",@"6.0", nil];
        for (int i = 0;i<nums.count; i++) {
            SWFontSpceModel * m = [SWFontSpceModel new];
           m.titile = nums[i];
           [_data addObject:m];
            if (i==0) {
                m.isSelect = YES;
                self.selectModel = m;
            }
        }
      
    }
    return _data;
}

@end
