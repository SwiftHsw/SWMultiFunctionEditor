//
//  SWImageViewController.m
//  SWTextTool
//
//  Created by 帅到不行 on 2020/1/13.
//  Copyright © 2020 sw. All rights reserved.
//

#import "SWImageViewController.h"

@interface SWImageViewController ()
@property (nonatomic,strong) UIScrollView *scr;

@end

@implementation SWImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"生成浏览";
    self.scr = [[UIScrollView alloc]initWithFrame:CGRectMake(10, NavBarHeight+10, SCREEN_WIDTH-20, SCREEN_HEIGHT - NavBarHeight - 10)];
    self.scr.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scr];
    CGFloat height = _img.size.height;
    
    UIImageView *imgss = [[UIImageView alloc]initWithImage:_img];
    [self.scr addSubview:imgss];
    imgss.frame = CGRectMake(0, 0, SCREEN_WIDTH - 20, height);
    [self.scr setContentSize:CGSizeMake(0, imgss.maxY)];
    imgss.contentMode = UIViewContentModeScaleAspectFit;
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"保存" selectedImageName:@"保存" target:self action:@selector(save)];
    
    
}

  
- (void)save{
     [self saveImageToPhotos:_img];
}
 - (void)saveImageToPhotos:(UIImage*)savedImage {
     UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
 }

 - (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
     NSString *msg = nil ;
     if(error != NULL){
         msg = @"保存图片失败" ;
     }else{
         msg = @"保存图片成功" ;
     }
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:msg
                                                     message:@"快拿去分享吧～"
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil];
     [alert show];
 }

@end
