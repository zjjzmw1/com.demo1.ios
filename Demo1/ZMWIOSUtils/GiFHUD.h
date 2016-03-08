//
//  GiFHUD.h
//  GiFHUD
//
//  Created by Cem Olcay on 30/10/14.
//  Copyright (c) 2014 Cem Olcay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiFHUD : UIView

+ (void)myLabelAction;

+ (void)showWithLabelString:(NSString *)tempString;
+ (void)show;
+ (void)showWithOverlay;///这个用的话，也需要加一个带文字的。。。用的时候再说。

+ (void)dismiss;

+ (void)setGifWithImages:(NSArray *)images;
+ (void)setGifWithImageName:(NSString *)imageName;
+ (void)setGifWithURL:(NSURL *)gifUrl;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
