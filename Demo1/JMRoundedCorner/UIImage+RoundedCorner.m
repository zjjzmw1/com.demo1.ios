//
//  UIImage+RoundedCorner.m
//  SelectTags
//
//  Created by jm on 16/2/22.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import "UIImage+RoundedCorner.h"

@implementation UIImage (RoundedCorner)

- (UIImage *)jm_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius {
    
    return [UIImage jm_imageWithRoundedCornersAndSize:sizeToFit CornerRadius:radius borderColor:nil borderWidth:0 backgroundColor:nil backgroundImage:self withContentMode:UIViewContentModeScaleAspectFill];
}

- (UIImage *)jm_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius withContentMode:(UIViewContentMode)contentMode {
    
    return [UIImage jm_imageWithRoundedCornersAndSize:sizeToFit CornerRadius:radius borderColor:nil borderWidth:0 backgroundColor:nil backgroundImage:self withContentMode:contentMode];
}

+ (UIImage *)jm_imageWithRoundedCornersAndSize:(CGSize)sizeToFit CornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    return [UIImage jm_imageWithRoundedCornersAndSize:sizeToFit CornerRadius:radius borderColor:borderColor borderWidth:borderWidth backgroundColor:nil backgroundImage:nil withContentMode:UIViewContentModeScaleToFill];
}

+ (UIImage *)jm_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius andColor:(UIColor *)color {
    
    return [UIImage jm_imageWithRoundedCornersAndSize:sizeToFit CornerRadius:radius borderColor:nil borderWidth:0 backgroundColor:color backgroundImage:nil withContentMode:UIViewContentModeScaleToFill];
}

+ (UIImage *)jm_imageWithRoundedCornersAndSize:(CGSize)sizeToFit CornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage withContentMode:(UIViewContentMode)contentMode {
    
    return [UIImage jm_imageWithRoundedCornersAndSize:sizeToFit JMRadius:JMRadiusMake(radius, radius, radius, radius) borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor backgroundImage:backgroundImage withContentMode:contentMode];
}

+ (UIImage *)jm_imageWithRoundedCornersAndSize:(CGSize)sizeToFit JMRadius:(JMRadius)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage withContentMode:(UIViewContentMode)contentMode {
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
    CGFloat halfBorderWidth = borderWidth / 2;
    //设置上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //边框大小
    CGContextSetLineWidth(context, borderWidth);
    //去锯齿处理
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    //边框颜色
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    //矩形填充颜色
    if (backgroundImage) {
        backgroundImage = [backgroundImage scaleToSize:CGSizeMake(sizeToFit.width, sizeToFit.height) withContentMode:contentMode];
        backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    } else {
        backgroundColor = [UIColor whiteColor];
    }
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGFloat height = sizeToFit.height;
    CGFloat width = sizeToFit.width;
    
    CGContextMoveToPoint(context, width - halfBorderWidth, radius.topRightRadius + halfBorderWidth);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius.bottomRightRadius  - halfBorderWidth, height - halfBorderWidth, radius.bottomRightRadius);  // 右下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius.bottomLeftRadius - halfBorderWidth, radius.bottomLeftRadius); // 左下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius.topLeftRadius); // 左上角
    CGContextAddArcToPoint(context, width , halfBorderWidth, width - halfBorderWidth, radius.topRightRadius + halfBorderWidth, radius.topRightRadius); // 右上角
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    UIImage *outImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outImage;
}


- (UIImage *)scaleToSize:(CGSize)size withContentMode:(UIViewContentMode)contentMode {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    
    [self drawInRect:[self convertRect:CGRectMake(0.0f, 0.0f, size.width, size.height) withContentMode:contentMode]];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (CGRect)convertRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode {
    if (self.size.width != rect.size.width || self.size.height != rect.size.height) {
        if (contentMode == UIViewContentModeLeft) {
            return CGRectMake(rect.origin.x,
                              rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                              self.size.width, self.size.height);
            
        } else if (contentMode == UIViewContentModeRight) {
            return CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                              rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                              self.size.width, self.size.height);
            
        } else if (contentMode == UIViewContentModeTop) {
            return CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                              rect.origin.y,
                              self.size.width, self.size.height);
            
        } else if (contentMode == UIViewContentModeBottom) {
            return CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                              rect.origin.y + floor(rect.size.height - self.size.height),
                              self.size.width, self.size.height);
            
        } else if (contentMode == UIViewContentModeCenter) {
            return CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                              rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                              self.size.width, self.size.height);
            
        } else if (contentMode == UIViewContentModeBottomLeft) {
            return CGRectMake(rect.origin.x,
                              rect.origin.y + floor(rect.size.height - self.size.height),
                              self.size.width, self.size.height);
            
        } else if (contentMode == UIViewContentModeBottomRight) {
            return CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                              rect.origin.y + (rect.size.height - self.size.height),
                              self.size.width, self.size.height);
            
        } else if (contentMode == UIViewContentModeTopLeft) {
            return CGRectMake(rect.origin.x,
                              rect.origin.y,
                              self.size.width, self.size.height);
            
        } else if (contentMode == UIViewContentModeTopRight) {
            return CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                              rect.origin.y,
                              self.size.width, self.size.height);
            
        } else if (contentMode == UIViewContentModeScaleAspectFill) {
            CGSize imageSize = self.size;
            if (imageSize.height < imageSize.width) {
                imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
                imageSize.height = rect.size.height;
                
            } else {
                imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
                imageSize.width = rect.size.width;
            }
            return CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
                              rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
                              imageSize.width, imageSize.height);
            
        } else if (contentMode == UIViewContentModeScaleAspectFit) {
            CGSize imageSize = self.size;
            if (imageSize.height < imageSize.width) {
                imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
                imageSize.width = rect.size.width;
                
            } else {
                imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
                imageSize.height = rect.size.height;
            }
            return CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
                              rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
                              imageSize.width, imageSize.height);
        }
    }
    return rect;
}

@end
