//
//  YZChatInputView.h
//  Printer
//
//  Created by admin on 2019/11/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import "SWBaseView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol YZChatInputViewDelegate <NSObject>

-(void)sureClick:(NSString*)text;

-(void)yz_textChangeCompletion:(NSString*)text;

@end
@interface YZChatInputView : SWBaseView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic  ,weak) id<YZChatInputViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
