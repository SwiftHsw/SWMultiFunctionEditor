//
//  YZChatInputView.m
//  Printer
//
//  Created by admin on 2019/11/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import "YZChatInputView.h"
#import "ChatView.h"
@implementation YZChatInputView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.textField.delegate = self;
}
- (IBAction)sureClick:(id)sender {
 
    if ([self.delegate respondsToSelector:@selector(sureClick:)]) {
        [self.delegate sureClick:self.textField.text];
    }
}

#pragma mark -监听uitextfield的值得变化
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   NSLog(@"textField4 - 正在编辑, 当前输入框内容为: %@",textField.text);
    if ([self.delegate respondsToSelector:@selector(yz_textChangeCompletion:)]) {
        [self.delegate yz_textChangeCompletion:textField.text];
    }
   return YES;
}




@end
