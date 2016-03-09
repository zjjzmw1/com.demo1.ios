//
//  TextConfig.m
//  tangyuanReader
//
//  Created by 王 强 on 13-6-8.
//  Copyright (c) 2013年 中文在线. All rights reserved.
//

#import "TextConfig.h"
#import <CoreText/CoreText.h>

#define ARRSIZE(a)      (sizeof(a) / sizeof(a[0]))


static AttributeConfig *editorAttributeConfig = nil;
static AttributeConfig *readerAttributeConfig = nil;
static AttributeConfig *readerTitleAttributeConfig = nil;

@implementation TextConfig


+(AttributeConfig *)editorAttributeConfig:(CGFloat)fontSize isBold:(BOOL)isBold color:(UIColor *)color{

    @synchronized (self)
    {
        if (editorAttributeConfig == nil)
        {
            editorAttributeConfig= [[AttributeConfig alloc] init];
            //TODO load from config
            editorAttributeConfig.attributes=[self defaultAttributes:fontSize isBold:isBold color:color];
            
        }else{
            editorAttributeConfig.attributes=[self defaultAttributes:fontSize isBold:isBold color:color];

        }
    }
    return editorAttributeConfig;

}

+(AttributeConfig *)readerAttributeConfig:(CGFloat)fontSize isBold:(BOOL)isBold color:(UIColor *)color{

    @synchronized (self)
    {
        if (readerAttributeConfig == nil)
        {
            readerAttributeConfig= [[AttributeConfig alloc] init];
            readerAttributeConfig.attributes=[self defaultReaderAttributes:fontSize isBold:isBold color:color];
            //TODO load from config
        }
        
    }
    return readerAttributeConfig;
}






+(AttributeConfig *)readerTitleAttributeConfig:(CGFloat)fontSize isBold:(BOOL)isBold color:(UIColor *)color{
    
    @synchronized (self)
    {
        if (readerTitleAttributeConfig == nil)
        {
            readerTitleAttributeConfig= [[AttributeConfig alloc] init];
            readerTitleAttributeConfig.attributes=[self defaultReaderTitleAttributes:fontSize isBold:isBold color:color];
            //TODO load from config
        }
        
    }
    return readerTitleAttributeConfig;
}



+(NSDictionary *)defaultAttributes:(CGFloat)fontSize isBold:(BOOL)isBold color:(UIColor *)color{

    NSString *fontName =[[UIFont systemFontOfSize:fontSize]fontName];
    if (isBold) {
        fontName = [[UIFont boldSystemFontOfSize:fontSize]fontName];
    }
    
    UIColor *strokeColor = [UIColor whiteColor];
    CGFloat strokeWidth = 0.0;
    CGFloat paragraphSpacing = 20.0;
    CGFloat paragraphSpacingBefore = 20.0;
    CGFloat lineSpacing = 5.0;
    CGFloat minimumLineHeight=0.0f;
    
    
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)fontName,
                                             fontSize, NULL);
    
    CTParagraphStyleSetting settings[] = {
        { kCTParagraphStyleSpecifierParagraphSpacingBefore, sizeof(CGFloat), &paragraphSpacingBefore },        
        { kCTParagraphStyleSpecifierParagraphSpacing, sizeof(CGFloat), &paragraphSpacing },
        { kCTParagraphStyleSpecifierLineSpacing, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(CGFloat), &minimumLineHeight },
        //{ kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(CGFloat), &headIndent },
    };
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, ARRSIZE(settings));
    
    //apply the current text style //2
   /* NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (id)color.CGColor, kCTForegroundColorAttributeName,
                           (__bridge id)fontRef, kCTFontAttributeName,
                           (id)strokeColor.CGColor, (NSString *) kCTStrokeColorAttributeName,
                           (id)[NSNumber numberWithFloat: strokeWidth], (NSString *)kCTStrokeWidthAttributeName,
                           (__bridge id) paragraphStyle, (NSString *) kCTParagraphStyleAttributeName,
                           nil];
    */
    NSMutableDictionary* attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           (id)color.CGColor, kCTForegroundColorAttributeName,
                           (__bridge id)fontRef, kCTFontAttributeName,
                           (id)strokeColor.CGColor, (NSString *) kCTStrokeColorAttributeName,
                           (id)[NSNumber numberWithFloat: strokeWidth], (NSString *)kCTStrokeWidthAttributeName,
                           (__bridge id) paragraphStyle, (NSString *) kCTParagraphStyleAttributeName,
                           nil];
    if (isBold) {
        [attrs setValue:(id)[NSNumber numberWithInt:kCTUnderlineStyleThick] forKey:(id)kCTUnderlineStyleAttributeName];
        [attrs setValue:(id)[UIColor blackColor].CGColor forKey:(id)kCTUnderlineColorAttributeName];
    }
    
    CFRelease(fontRef);
    return attrs;
}


//modify by yangzongming
+(NSDictionary *)defaultReaderAttributes:(CGFloat)fontSize isBold:(BOOL)isBold color:(UIColor *)color{
    return  [self defaultAttributes:fontSize isBold:isBold color:color];
    
}

/*
+(NSDictionary *)defaultImageDescAttributes{
    
    NSString *fontName =[[UIFont systemFontOfSize:12]fontName];//@"Hiragino Sans GB";
    CGFloat fontSize= 12.0f;
    UIColor *color = [UIColor blackColor];
    UIColor *strokeColor = [UIColor whiteColor];
    CGFloat strokeWidth = 0.0;    
    
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)fontName,
                                             fontSize, NULL);  
    
    NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (id)color.CGColor, kCTForegroundColorAttributeName,
                           (__bridge id)fontRef, kCTFontAttributeName,
                           (id)strokeColor.CGColor, (NSString *) kCTStrokeColorAttributeName,
                           (id)[NSNumber numberWithFloat: strokeWidth], (NSString *)kCTStrokeWidthAttributeName,
                           nil];
    
    CFRelease(fontRef);
    return attrs;
}
 */



+(NSDictionary *)defaultReaderTitleAttributes:(CGFloat)fontSize isBold:(BOOL)isBold color:(UIColor *)color{
    return  [self defaultAttributes:fontSize isBold:isBold color:color];
}




@end

