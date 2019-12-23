//
//  UIView+SWView.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "UIView+SWView.h"
 
static NSString *styModelKey = @"styModelKey";
static NSString *nameWithSetterGetterKey = @"nameWithSetterGetterKey";

@implementation UIView (SWView)


//运行时实现setter方法
- (void)setFontModel:(SWViewFontModel *)fontModel{
    objc_setAssociatedObject(self, &styModelKey, fontModel, OBJC_ASSOCIATION_RETAIN);
}
//运行时实现getter方法
- (SWViewFontModel *)fontModel{
    return objc_getAssociatedObject(self, &styModelKey);
}


-(void)setNameWithSetterGetter:(NSString *)nameWithSetterGetter{
    objc_setAssociatedObject(self, &nameWithSetterGetterKey, nameWithSetterGetter, OBJC_ASSOCIATION_COPY);
}

- (NSString *)nameWithSetterGetter{
    return objc_getAssociatedObject(self, &nameWithSetterGetterKey);
    
}
@end
