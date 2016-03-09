//
//  TextConfig.h
//  tangyuanReader
//
//  Created by 王 强 on 13-6-8.
//  Copyright (c) 2013年 中文在线. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttributeConfig.h"
@interface TextConfig : NSObject
/// 字体大小，是否是粗体、字体颜色
+(AttributeConfig *)editorAttributeConfig:(CGFloat)fontSize isBold:(BOOL)isBold color:(UIColor *)color;
+(AttributeConfig *)readerAttributeConfig:(CGFloat)fontSize isBold:(BOOL)isBold color:(UIColor *)color;
+(AttributeConfig *)readerTitleAttributeConfig:(CGFloat)fontSize isBold:(BOOL)isBold color:(UIColor *)color;

@end


