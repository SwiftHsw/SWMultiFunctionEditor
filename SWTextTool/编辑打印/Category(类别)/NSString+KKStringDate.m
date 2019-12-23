//
//  NSString+KKStringDate.m
//  QuicklyGo_Driver
//
//  Created by xxf on 16/9/21.
//  Copyright © 2016年 lk06. All rights reserved.
//

#import "NSString+KKStringDate.h"

@implementation NSString (KKStringDate)

+(NSString *)lfstringDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

//只显示时分
+(NSString *)kHourAndMminuteDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

//字典转json格式字符串
+ (NSString *)dictionaryToJson:(id)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return str;
}

- (NSInteger)getStringLenthOfBytes
{
    NSInteger length = 0;
    for (int i = 0; i<[self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self validateChineseChar:s]) {
            
//            NSLog(@" s 打印信息:%@",s);
            
            length +=1;
        }else{
            length +=1;
        }
        
//        NSLog(@" 打印信息:%@  %ld",s,(long)length);
    }
    return length;
}

- (NSString *)subBytesOfstringToIndex:(NSInteger)index
{
    NSInteger length = 0;
    
    NSInteger chineseNum = 0;
    NSInteger zifuNum = 0;
    
    for (int i = 0; i<[self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self validateChineseChar:s])
        {
            if (length + 1 > index)
            {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            
            length +=1;
            
            chineseNum +=1;
        }
        else
        {
            if (length +1 >index)
            {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            length+=1;
            
            zifuNum +=1;
        }
    }
    return [self substringToIndex:index];
}

//检测中文或者中文符号
- (BOOL)validateChineseChar:(NSString *)string
{
    NSString *nameRegEx = @"[\\u0391-\\uFFE5]";
    if (![string isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

//检测中文
- (BOOL)validateChinese:(NSString*)string
{
    NSString *nameRegEx = @"[\u4e00-\u9fa5]";
    if (![string isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

- (BOOL)isMatchesRegularExp:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

//价格去除后面的00.00
+(NSString*)removeFloatAllZero:(CGFloat)price
{
    NSString *stringFloat = [NSString stringWithFormat:@"%.2f",price];
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    int i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
//    NSString * testNumber = [NSString stringWithFormat:@"%.2f",price];
//    KKLog(@"%@",@(testNumber.floatValue));
//    double dou = testNumber.doubleValue;
//    dou = floor(dou * 100);
//    CGFloat number = dou /100;
//    NSString * outNumber = [NSString stringWithFormat:@"%@",@(number)];
//    return outNumber;
}

//价格去除后面的00.00
+(NSString*)removeStrAllZero:(NSString*)stringFloat
{
//    const char *floatChars = [stringFloat UTF8String];
//    NSUInteger length = [stringFloat length];
//    NSUInteger zeroLength = 0;
//    int i = length-1;
//    for(; i>=0; i--)
//    {
//        if(floatChars[i] == '0'/*0x30*/) {
//            zeroLength++;
//        } else {
//            if(floatChars[i] == '.')
//                i--;
//            break;
//        }
//    }
//    NSString *returnString;
//    if(i == -1) {
//        returnString = @"0";
//    } else {
//        returnString = [stringFloat substringToIndex:i+1];
//    }
//    return returnString;
    NSString * testNumber = [NSString stringWithFormat:@"%.2f",[stringFloat floatValue]];
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}

@end
