//
//  BKTextView.m
//  Vodka
//
//  Created by xiaoming on 15/10/20.
//  Copyright © 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "BKTextView.h"

@interface BKTextView(){
    BOOL _shouldDrawPlaceholder;
}
- (void)_initialize;
- (void)_updateShouldDrawPlaceholder;
- (void)_textChanged:(NSNotification *)notification;

@end

@implementation BKTextView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        _placeholerFontSize = 16;
        [self _initialize];
    }
    return self;
}
- (void)setText:(NSString *)string {
    [super setText:string];
    [self _updateShouldDrawPlaceholder];
}


- (void)setPlaceholder:(NSString *)string {
    if ([string isEqual:_placeholder]) {
        return;
    }
    
    _placeholder = string;
    
    [self _updateShouldDrawPlaceholder];
    [self setNeedsDisplay];
}
///9.1系统的个别机型没有下面这个方法的话，会出现汉字被上下拉高了。
- (void)layoutSubviews{
    [self setNeedsDisplay];
}

#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self _initialize];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_shouldDrawPlaceholder) {
        if(self.placeholderColor){
            if (self.placeholerFontSize <= 1) {
                self.placeholerFontSize = 16;
            }
            CGSize size = [_placeholder boundingRectWithSize:CGSizeMake(rect.size.width, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.placeholerFontSize]} context:nil].size;
            
            [_placeholder drawInRect:CGRectMake(0.0f, 8.0, size.width, size.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.placeholerFontSize], NSForegroundColorAttributeName:self.placeholderColor}];
        }
    }
}


#pragma mark - Private

- (void)_initialize {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textChanged:) name:UITextViewTextDidChangeNotification object:self];
    ///默认的文字的颜色。。。也可以自己设定。
    self.placeholderColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
    _shouldDrawPlaceholder = NO;
}


- (void)_updateShouldDrawPlaceholder {
    BOOL prev = _shouldDrawPlaceholder;
    _shouldDrawPlaceholder = self.placeholder && self.placeholderColor && self.text.length == 0;
    
    if (prev != _shouldDrawPlaceholder) {
        [self setNeedsDisplay];
    }
}


- (void)_textChanged:(NSNotification *)notificaiton {
    [self _updateShouldDrawPlaceholder];
}

@end
