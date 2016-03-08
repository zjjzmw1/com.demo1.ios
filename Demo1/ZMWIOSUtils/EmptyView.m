//
//  EmptyView.m
//  Vodka
//
//  Created by xiaoming on 15/11/30.
//  Copyright © 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "EmptyView.h"
#import "UIView+Utils.h"
#import "UIColor+IOSUtils.h"

@interface EmptyView()


@end


@implementation EmptyView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //默认图。
        _imageV = [[UIImageView alloc]init];
        [self addSubview:_imageV];
        _imageV.frame = CGRectMake(0, 0, 65.5, 55.5);
        _imageV.center = CGPointMake(self.centerX, self.centerY - 50);
        _imageV.backgroundColor = [UIColor clearColor];
        
        //默认文字。
        _label = [[UILabel alloc]init];
        [self addSubview:_label];
        _label.backgroundColor = [UIColor clearColor];
        _label.frame = CGRectMake(80, 50, self.width - 80*2, 20);
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:12];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor colorFromHexString:@"#333333"];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
#pragma mark - 常用的方法
- (void)imageString:(NSString *)imageString labelString:(NSString *)labelString {
    self.imageV.image = [UIImage imageNamed:imageString];
    self.label.text = labelString;
    [self.label sizeToFit];

}
#pragma mark - 不常用的、自定义很多属性的.
- (void)imageString:(NSString *)imageString labelString:(NSString *)labelString font:(UIFont *)font fontColor:(UIColor *)color{
    self.imageV.image = [UIImage imageNamed:imageString];
    self.label.text = labelString;
    self.label.font = font;
    self.label.textColor = color;
    [self.label sizeToFit];
    
}
@end
