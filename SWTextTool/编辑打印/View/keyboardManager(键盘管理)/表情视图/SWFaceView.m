
//
//  SWFaceView.m
//  SWTextTool
//
//  Created by 帅到不行 on 2020/1/13.
//  Copyright © 2020 sw. All rights reserved.
//

#import "SWFaceView.h"
#import "YZEmojiViewModel.h"
#import "YZFaceIndexCell.h"
#import "YZEmojiCell.h"

@interface SWFaceView ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UITableViewDataSource,
UITableViewDelegate>
@property (nonatomic  ,strong)UICollectionView * datacolletionView;

@property (nonatomic  ,strong)UITableView * leftTableView;

@property (nonatomic  ,strong)YZEmojiViewModel * VM;

@property (nonatomic  ,assign)NSInteger type;

@property (nonatomic  ,strong)NSMutableArray * dataArray;

@end

@implementation SWFaceView
-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    
    self.backgroundColor = [UIColor whiteColor];
    [self sd_addSubviews:@[self.leftTableView,self.datacolletionView]];
    self.leftTableView.frame = CGRectMake(0, 0, 50, keyBoxHeight);
    self.datacolletionView.frame = CGRectMake(60, 10, KScreenWidth-70, keyBoxHeight-10);
    self.type = 8;
    SWWeakSelf(self)
    
    [[self.VM.dataCmd execute:nil]subscribeNext:^(id  _Nullable x) {
        
        NSDictionary * dict =  weakself.VM.dataArray.firstObject;
        weakself.dataArray= dict[@"data"];
        [weakself.datacolletionView reloadData];
        [weakself.leftTableView reloadData];
    }];
}


#pragma mark -----UICollectionViewDelegate-----
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemW = (collectionView.width - (10*4) )/4;
    return CGSizeMake(itemW, itemW+15);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    YZEmojiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary * dict = self.dataArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:dict[@"image"]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     YZEmojiCell * cell =  (YZEmojiCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.imageView.image) {
      [kNoti postNotificationName:INSEREMOJI object:cell.imageView.image];
    }
  
}

#pragma mark -----tableViewDelegate-----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.VM.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YZFaceIndexCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary * dict = self.VM.dataArray[indexPath.row];
    [cell.icon sd_setImageWithURL:dict[@"icon_url"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
   NSDictionary * dict =  self.VM.dataArray[indexPath.row];
  self.dataArray= dict[@"data"];
  [self.datacolletionView reloadData];
}

#pragma mark -----lazy-------
-(UICollectionView *)datacolletionView{
    if (!_datacolletionView) {
         UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _datacolletionView  =[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _datacolletionView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
        _datacolletionView.backgroundColor = [UIColor whiteColor];
        _datacolletionView.delegate = self;
        _datacolletionView.dataSource = self;
        [_datacolletionView registerNib:[UINib nibWithNibName:@"YZEmojiCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _datacolletionView;
}
-(UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _leftTableView.dataSource= self;
        _leftTableView.delegate = self;
        _leftTableView.rowHeight = 55;
        [_leftTableView registerNib:[UINib nibWithNibName:@"YZFaceIndexCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _leftTableView;
}
-(YZEmojiViewModel *)VM{
    if (!_VM) {
        _VM = [YZEmojiViewModel new];
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
