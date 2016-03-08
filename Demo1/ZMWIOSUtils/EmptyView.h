//
//  EmptyView.h
//  Vodka
//
//  Created by xiaoming on 15/11/30.
//  Copyright © 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyView : UIView

@property (nonatomic, strong) UIImageView *imageV;      //默认图。
@property (nonatomic, strong) UILabel *label;           //默认文字。

///常用的
- (void)imageString:(NSString *)imageString labelString:(NSString *)labelString;

/// 不常用的、自定义很多属性的.
- (void)imageString:(NSString *)imageString labelString:(NSString *)labelString font:(UIFont *)font fontColor:(UIColor *)color;
@end
