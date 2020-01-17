//
//  SettingViewController.m
//  SWTextTool
//
//  Created by 帅到不行 on 2020/1/13.
//  Copyright © 2020 sw. All rights reserved.
//

#import "SettingViewController.h"
#import "ATAboutUsViewController.h"
#import "SWFeedbackViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *TableView;
@property (nonatomic, assign) float cacheSize;
@end
 
@implementation SettingViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:17],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationItem.title =  NSLocalizedString(@"设置", @"");
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor  whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNavImageName:@"back" selectedImageName:@"back" target:self action:@selector(dimiiss)];
    
    self.TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight) style:UITableViewStylePlain];
    self.TableView.delegate =self;
    self.TableView.dataSource = self;
    
    [self.view addSubview:self.TableView];
    self.TableView.separatorColor = [SWKit colorWithHexString:@"#D5D2D2"];
    self.TableView.tableFooterView = [UIView new];
    self.TableView.rowHeight = 146/3;
    
    self.view.backgroundColor = self.TableView.backgroundColor =  [SWKit colorWithHexString:@"#F5F5F5"];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
 
    cell.textLabel.text = @[@"意见反馈",@"关于我们",@"当前版本",@"给我们评分吧～",][indexPath.row];
    cell.accessoryView  = [SWKit getAccessoryImage];
    cell.imageView.image = @[kImageName(@"反馈"),kImageName(@"关于我们"),kImageName(@"版本"),kImageName(@"评分")][indexPath.row];
    [SWKit setupCellSystemImageSize:CGSizeMake(15, 15) tableViewCell:cell];
 
    cell.textLabel.textColor =   [SWKit colorWithHexString:@"#222222"];
    cell.textLabel.font = kFontWithSize(16);
    
    cell.accessoryView = [SWKit getAccessoryImage];
 
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[SWFeedbackViewController new] animated:YES];
    }else if (indexPath.row == 1){
        [self.navigationController pushViewController:[ATAboutUsViewController new] animated:YES];
    }else if (indexPath.row == 3){
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", @"1494875118"];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
        
    }
    else{
        [SWAlertViewController showInController:self title:@"提示" message:[NSString stringWithFormat:@"当前版本 %@",GETSYSTEM] cancelButton:@"确定" other:@"" completionHandler:^(SWAlertButtonStyle buttonStyle) {
            
        }];
    }
 
    
}

- (void)dimiiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end


