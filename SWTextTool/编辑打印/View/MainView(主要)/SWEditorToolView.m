//
//  SWEditorToolView.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWEditorToolView.h"
#import "SWKeyboardToolModel.h"
#import "SWKeyboardCell.h"

@interface SWEditorToolView()
{
    NSIndexPath *_selectIndexPath;
    SWKeyboardCell *_selectCell;
    NSArray *_imageArr;
    NSArray *_selectImageArr;
}
@end
@implementation SWEditorToolView



- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.menuDataArray = [SWEditorToolView getMenuDataArray].mutableCopy;
        [self addSubview:self.menueCollection];
        [self addSubview:self.closeButton];
        //self.fromView
        //@"文本",@"表情",@"图片",@"主题",@"涂鸦" ,
        
        self.showViews = [[NSMutableArray alloc]initWithObjects:self.fontView,self.faceView,[UIView new],self.themeView, [UIView new], nil];
        
        self.backgroundColor = [UIColor whiteColor];
      _imageArr  =  @[@"文本",@"表情",@"图片",@"主题",@"涂鸦"];
      _selectImageArr =  @[@"文本-1",@"表情-1",@"图片-1",@"主题-1", @"涂鸦-1"];
        
    }
    
    return self;
}


#pragma mark - Collection Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.menuDataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SWKeyboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
     cell.model = _menuDataArray[indexPath.row];
    cell.tag = indexPath.row;
    
    if (_selectIndexPath == indexPath) {
     cell.imageView.image = kImageName(_selectImageArr[indexPath.row]);
    }else{
      cell.imageView.image = kImageName(_imageArr[indexPath.row]);
    }
 
  
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
 
    //取消之前的选择

   _selectIndexPath = indexPath;//当前选择的打钩
    [collectionView reloadData];

    !self.sw_editorToolViewSelectActionIndex?:self.sw_editorToolViewSelectActionIndex(indexPath.row);
    
    //弹出动画处理
    [[SWKit currentWindow] resignFirstResponder];
    [[SWKit currentWindow] endEditing:YES];
    UIView *showView = self.showViews[indexPath.item];
    if ([showView isEqual:self.showView]) {
        //点击的同一个 取返
        [UIView animateWithDuration:0.25 animations:^{
            self.showView.y = SCREEN_HEIGHT;
            !self.sw_editorToolViewDismiss?:self.sw_editorToolViewDismiss(indexPath.row);
            
        }];
        self.showView = nil;
        return;
    }
    
    //没有选中的做动画
    [UIView animateWithDuration:.25 animations:^{
        showView.y = SCREEN_HEIGHT - showView.height - KHeight_Tabar - SafeBottomHeight;
    }];
    
    [UIView animateWithDuration:.25 animations:^{
        self.showView.y = SCREEN_HEIGHT; //选中的下去
    }];
    
    self.showView = showView; //记录
}

- (void)hideAllShowView{
    [UIView animateWithDuration:.25 animations:^{
        self.showView.y = SCREEN_HEIGHT;
    }];
    self.showView=nil;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //必要
    for (UIView *view in self.showViews) {
        [self.superview addSubview:view];
        [self.superview insertSubview:self aboveSubview:view];
    }
    [self LX_SetShadowPathWith:
              [[SWKit colorWithHexString:@"#000000"]colorWithAlphaComponent:0.15]
               shadowOpacity:1
               shadowRadius:4
               shadowSide:LXShadowPathTop
                shadowPathWidth:-2];
}
/**
 获取工具条的菜单

 @return 数组
 */
+(NSMutableArray*)getMenuDataArray{
    //@"表格",@"二维码",
    NSArray *dataArr = @[@"文本",@"表情",@"图片",@"主题" ,@"涂鸦"];
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (NSString *title in dataArr) {
        SWKeyboardToolModel *model = [[SWKeyboardToolModel alloc]init];
        model.titile = title;
        [result addObject:model];
    }
    return result;
}

 
#pragma mark - Lazy

- (UICollectionView *)menueCollection{
    if (!_menueCollection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemWidth = (SCREEN_WIDTH - 50)/5.5;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(itemWidth, KHeight_Tabar);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _menueCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 50, KHeight_Tabar) collectionViewLayout:flowLayout];
        
        _menueCollection.backgroundColor = [UIColor whiteColor];
        _menueCollection.showsVerticalScrollIndicator = NO;
       _menueCollection.showsHorizontalScrollIndicator = NO;
       _menueCollection.delegate = self;
       _menueCollection.dataSource = self;
       [_menueCollection registerClass:[SWKeyboardCell class] forCellWithReuseIdentifier:@"cell"];
    }
    
    return _menueCollection;
}
-(SWFontView *)fontView{
    if (!_fontView) {
        _fontView =[[SWFontView alloc]initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, keyBoxHeight)];
        _fontView.backgroundColor = [UIColor whiteColor];
    }
    return _fontView;
}
 
-(SWFaceView *)faceView{
    if (!_faceView) {
        _faceView =[[SWFaceView alloc]initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, keyBoxHeight)];
        _faceView.backgroundColor =[UIColor whiteColor];
    }
    return _faceView;
}
 
-(SWThemeView *)themeView{
    if (!_themeView) {
        _themeView =[SWThemeView sw_viewFromXib];
        _themeView.frame = CGRectMake(0, KScreenHeight, KScreenWidth, 180);
        _themeView.backgroundColor = [SWKit colorWithHexString:@"#999999"];
    }
    return _themeView;
}



@end
