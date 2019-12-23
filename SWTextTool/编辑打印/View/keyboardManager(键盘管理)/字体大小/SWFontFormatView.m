//
//  SWFontFormatView.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFontFormatView.h"
#import "SWBaseFontFormaterCell.h"
#import "SWFontFormatterCell.h"
#import "SWFontAligementCell.h"
#import "SWFontSpaceCell.h"

@interface SWFontFormatView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)UITableView * tableView;
@property (nonatomic , strong)NSMutableArray * cellIDs;
@end

@implementation SWFontFormatView

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.tableView];
    
    self.cellIDs = [[NSMutableArray alloc]initWithObjects:@"cell",@"cell1",@"cell2",nil];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.cellIDs.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = self.cellIDs[indexPath.row];
    SWBaseFontFormaterCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return  [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:self.width tableView:tableView];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:(UITableViewStylePlain)];
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
       
        [_tableView registerClass:[SWFontFormatterCell class] forCellReuseIdentifier:@"cell"];
         [_tableView registerClass:[SWFontAligementCell class] forCellReuseIdentifier:@"cell1"];
         [_tableView registerClass:[SWFontSpaceCell class] forCellReuseIdentifier:@"cell2"];
        _tableView.rowHeight = 100;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
