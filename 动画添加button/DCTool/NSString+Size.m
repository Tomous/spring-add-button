    //
    //  NSString+Size.m
    //  LEkdfd
    //
    //  Created by wenhua on 16/4/20.
    //  Copyright © 2016年 wenhua. All rights reserved.
    //

#import "NSString+Size.h"

@implementation NSString (Size)
-(CGSize )LE_sizeWithFont:(CGFloat)font  MaxWidth :(CGFloat)width
{
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    params[NSFontAttributeName] = [UIFont systemFontOfSize:font];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    style.lineBreakMode = NSLineBreakByCharWrapping;
    params[NSParagraphStyleAttributeName] = style;
    
    
    CGRect rect=   [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:params context:nil];
    
    return rect.size;
    
}

-(CGSize )LE_sizeWithFont:(CGFloat)font
{
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    params[NSFontAttributeName] = [UIFont systemFontOfSize:font];
    CGSize size=  [self sizeWithAttributes:params];
    
    return size;
    
}

/**
 获取字节数
 
 @return <#return value description#>
 */
- (NSUInteger )LE_getByteNum {
    NSData* bytes =   [self dataUsingEncoding:NSUTF8StringEncoding];
       return bytes.length;
}

/**
 <#Description#>
 
 @param index <#index description#>
 @return <#return value description#>
 */
- (NSString *)LE_subStringByByteWithIndex:(NSInteger)index{
    
    NSInteger sum = 0;
    
    NSString *subStr = [[NSString alloc] init];
    
    for(int i = 0; i<[self length]; i++){
        NSRange range=NSMakeRange(i,1);
        NSString *subString=[self substringWithRange:range];
        const char *cString=[subString UTF8String];
        if (strlen(cString)==3) {
            sum+=3;
        }else{
            sum += 1;
        }
        
        
        if (sum >= index) {
            
            subStr = [self substringToIndex:i-1];
            return subStr;
        }else if(sum == index){
            subStr = [self substringToIndex:i];
            return subStr;
        }
        
    }
    
    return subStr;
}

@end
