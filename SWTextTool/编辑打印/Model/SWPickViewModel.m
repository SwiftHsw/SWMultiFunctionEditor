//
//  SWPickViewModel.m
//  SWTextTool
//
//  Created by 帅到不行 on 2019/12/21.
//  Copyright © 2019 sw. All rights reserved.
//

#import "SWPickViewModel.h"

@implementation SWPickViewModel
 
-(id)init{
    if (self=[super init]) {
        self.boderColor =[UIColor blackColor];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{


    SWPickViewModel * model = [[SWPickViewModel allocWithZone:zone] init];

    model.lineWidth = self.lineWidth;//self是被copy的对象

    model.boderColor = self.boderColor;

    model.style = self.style;
    
    model.layout = self.layout;
    
    model.row = self.row;
       
    model.col = self.col;
    
    return model;

}

- (id)mutableCopyWithZone:(NSZone *)zone{

    SWPickViewModel * model = [[SWPickViewModel allocWithZone:zone] init];

    model.lineWidth = self.lineWidth;//self是被copy的对象

    model.boderColor = self.boderColor;
    
    model.style = self.style;
    
    model.layout = self.layout;
    
    model.row = self.row;
       
    model.col = self.col;


    return model;

}


@end
 
