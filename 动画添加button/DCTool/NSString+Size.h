//
//  NSString+Size.h
//  LEkdfd
//
//  Created by wenhua on 16/4/20.
//  Copyright © 2016年 wenhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Size)
-(CGSize )LE_sizeWithFont:(CGFloat)font;

-(CGSize )LE_sizeWithFont:(CGFloat)font  MaxWidth :(CGFloat)width;
/**
 根据字节数截取串
 
 @param index <#index description#>
 @return <#return value description#>
 */
- (NSString *)LE_subStringByByteWithIndex:(NSInteger)index;
/**
 获取字节数
 
 @return <#return value description#>
 */
- (NSUInteger )LE_getByteNum;
@end
