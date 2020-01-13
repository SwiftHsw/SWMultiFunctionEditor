//
//  ATAboutUsViewController.m
//  ATPaintingClip
//
//  Created by 艾腾软件 on 17/8/7.
//  Copyright © 2017年 ZhouXiaobin. All rights reserved.
//

#import "ATAboutUsViewController.h"
#import "SWKit.h"
#import "UIBarButtonItem+SWExtension.h"
@interface ATAboutUsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLab;

@property (weak, nonatomic) IBOutlet UIImageView *imgeIcon;
@end

@implementation ATAboutUsViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNavImageName:@"back" selectedImageName:@"back" target:self action:@selector(dimiiss)];
    self.title = NSLocalizedString(@"关于本印助手", @"");
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.versionLab.text = [NSString stringWithFormat:@"版本号:V%@",appCurVersion];
    ATViewRadius(_imgeIcon, 8);
}
- (void)dimiiss{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
