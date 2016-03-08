//
//  DJLabel.m
//  zhangmingwei
//
//  Created by 张 on 14-3-18.
//  Copyright (c) 2014年 zhangmingwei. All rights reserved.
//

#import "DJLabel.h"

@implementation DJLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.insets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect
{
    UIEdgeInsets insets = _insets;
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
