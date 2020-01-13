//
//  YYFeedbackViewController.m
//  YouYou Metu
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWFeedbackViewController.h"
#import "UITextView+WZB.h"
#import "SVProgressHUD.h"
#import <SWKit/SWKit.h>

@interface SWFeedbackViewController ()
<UITextViewDelegate>{
    UIButton *_btn;
    UITextView *_textView;
}

@end

@implementation SWFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:17],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent:NO];
 
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNavImageName:@"back" selectedImageName:@"back" target:self action:@selector(dimiiss)];
//    self.title = NSLocalizedString(@"Feedback", @"");
    self.title = @"您的反馈是我们最大的支持";
    self.view.backgroundColor = [SWKit colorWithHexString:@"#F5F5F5"];
    UIView *bgView= [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(13,24, SCREEN_WIDTH -26, 200);
    [self.view addSubview:bgView];
    ATViewRadius(bgView, 3);
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(21, 15, bgView.width - 21*2, bgView.height - 15*2)];
    textView.font = kFontWithSize(16);
    textView.delegate = self;
    textView.backgroundColor = [UIColor whiteColor];
    textView.wzb_placeholder = @"请输入您要反馈的内容";
    textView.wzb_placeholderColor = [[UIColor grayColor]colorWithAlphaComponent:.5];
    textView.wzb_minHeight = bgView.height - 17*2;
    [bgView addSubview:textView];
    _textView = textView;
    ATViewBorderRadius(bgView, 8, 0.3, [SWKit colorWithHexString:@"#111111"]);
    
    UIButton *btn = [SWKit buttonWithTitle:@"提交" titleColor:[UIColor whiteColor] hilightedColor:[UIColor whiteColor] fontSize:17 frame:CGRectMake(65, bgView.maxY + 28, SCREEN_WIDTH - 65*2, 35)];
    btn.frame = CGRectMake(14,  bgView.maxY+24, SCREEN_WIDTH - 28, 44);
    [self.view addSubview:btn];
    [btn setBackgroundColor: [SWKit colorWithHexString:@"#00DD98"]];
    [btn addTarget:self action:@selector(didbtn) forControlEvents:UIControlEventTouchUpInside];
    
    _btn = btn;
    ATViewRadius(_btn, 5);
}

- (void)dimiiss{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didbtn{
    if (_textView.text.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"Input Feedback Content"];
          [SVProgressHUD showErrorWithStatus:@"请输入您要反馈的内容"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"稍等.."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD showSuccessWithStatus:@"Success"];
        [SVProgressHUD showSuccessWithStatus:@"感谢您的反馈"];
        [self.navigationController popViewControllerAnimated:YES];
    });
    
    
}
 
@end

