//
//  DrawTool.m
//  Vodka
//
//  Created by fusunlang on 8/30/14.
//  Copyright (c) 2014 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "DrawTool.h"

@implementation DrawTool

+ (void)drawCurve:(CGContextRef)context pointArray:(CGPoint*)points arrayCount:(int)count lineColor:(CGColorRef)color
{
    if(points == NULL || count <= 0)
    {
        return;
    }
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context,color);
    //draw curve line
    CGContextMoveToPoint(context, points[0].x, points[0].y);
    for(int i = 1; i < count; i++)
    {
        CGContextAddLineToPoint(context, points[i].x, points[i].y);
    }
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

+ (void)drawCurve:(CGContextRef)context pointArray:(NSArray*)points lineColor:(CGColorRef)color
{
    if(points == nil)
    {
        return;
    }
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context,color);
    //draw curve line
    NSString *str = [points objectAtIndex:0];
    NSArray *arr = [str componentsSeparatedByString:@":"];
    CGContextMoveToPoint(context, [[arr objectAtIndex:0] doubleValue], [[arr objectAtIndex:1] doubleValue]);
    for(int i = 1; i < [points count]; i++)
    {
        NSString *str = [points objectAtIndex:i];
        NSArray *arr = [str componentsSeparatedByString:@":"];
        CGContextAddLineToPoint(context, [[arr objectAtIndex:0] doubleValue], [[arr objectAtIndex:1] doubleValue]);
    }
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

+ (void)drawCurveWithoutIvnalidPoints:(CGContextRef)context pointArray:(CGPoint*)points arrayCount:(int)count lineColor:(CGColorRef)color
{
    if(points == NULL || count <= 0)
    {
        return;
    }
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context,color);
    CGMutablePathRef path = CGPathCreateMutable();
    if (path == nil) {
        return;
    }
    //draw curve line
    int i;
    for(i = 0; i < count; i++)
    {
        if(points[i].x != FLOAT_MIN && points[i].y != FLOAT_MIN)
        {
            if (isnan(points[i].x) || isnan(points[i].y)) {
                continue;
            }
            CGPathMoveToPoint(path, &CGAffineTransformIdentity, points[i].x, points[i].y);
            //			CGContextMoveToPoint(context, points[i].x, points[i].y);
            break;
        }
    }
    
    for(i++ ; i < count; i++)
    {
        if(points[i].x != FLOAT_MIN && points[i].y != FLOAT_MIN)
        {
            if (isnan(points[i].x) || isnan(points[i].y)) {
                continue;
            }
            
            CGPathAddLineToPoint(path, &CGAffineTransformIdentity, points[i].x, points[i].y);
            //			CGContextAddLineToPoint(context, points[i].x, points[i].y);
        }
    }
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGPathRelease(path);
}

+ (void)drawColorfulCurveWithoutInvalidPoints:(CGContextRef)context pointArray:(CGPoint*)points arrayCount:(int)count lineColor:(int*)colors
{
    if(points == NULL || count <= 0 || colors == NULL)
    {
        return;
    }
    
    CGContextSaveGState(context);
    //	CGContextSetStrokeColorWithColor(context,color);
    //draw curve line
    CGContextSetLineJoin(context, kCGLineJoinRound);
    int i;
    for(i = 0; i < count; i++)
    {
        if(points[i].x != FLOAT_MIN && points[i].y != FLOAT_MIN)
        {
            CGContextSetStrokeColorWithColor(context,[DrawTool cgcolorWithInt:colors[i]]);
            CGContextMoveToPoint(context, points[i].x, points[i].y);
            break;
        }
    }
    
    for(i++ ; i < count; i++)
    {
        if(points[i].x != FLOAT_MIN && points[i].y != FLOAT_MIN && points[i].y == points[i].y)
        {
            CGContextAddLineToPoint(context, points[i].x, points[i].y);
            if (i > 0 && colors[i] != colors[i-1])
            {
                CGContextStrokePath(context);
                CGContextMoveToPoint(context, points[i].x, points[i].y);
                CGContextSetStrokeColorWithColor(context,[DrawTool cgcolorWithInt:colors[i]]);
            }
        }
    }
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

+ (void)drawSeriesLine:(CGContextRef)context pointArray:(CGPoint*)points arrayCount:(int)count baseY:(int)coordY lineColor:(CGColorRef*)color
{
    if (points == NULL || count <= 0) {
        return;
    }
    
    CGContextSaveGState(context);
    for (int i = 0; i < count; i ++)
    {
        CGContextSetStrokeColorWithColor(context, color[i]);
        CGContextMoveToPoint(context, points[i].x, points[i].y);
        CGContextAddLineToPoint(context, points[i].x, coordY);
        CGContextStrokePath(context);
    }
    CGContextRestoreGState(context);
}

//根据像素值绘制横线
+ (void)drawPixelHorizontal:(CGContextRef)context pointBegin:(CGPoint)point lineLength:(int)length lineWidth:(int)width color:(CGColorRef)color
{
    CGContextSaveGState(context);
    point = [DrawTool adjustPoint:point];
    CGContextSetFillColorWithColor(context,color);
    if (length < 0)
    {
        length *= -1;
        point.x -= length;
    }
    CGRect rc =  CGRectMake(point.x, point.y, length, width);
    CGContextFillRect(context, rc);
    CGContextRestoreGState(context);
}

+(void)drawLineByPoint:(CGContextRef)context startPoint:(CGPoint)pointOne desPoint:(CGPoint)pointTwo lineWidth:(float)width color:(CGColorRef)color
{
    	CGContextSaveGState(context);
        CGContextSetStrokeColorWithColor(context, color);
    	CGContextSetFillColorWithColor(context,color);
    	CGContextMoveToPoint(context, pointOne.x, pointOne.y);
    	CGContextAddLineToPoint(context, pointTwo.x, pointTwo.y);
    	CGContextSetLineWidth(context, width);
    	CGContextStrokePath(context);
    	CGContextRestoreGState(context);
    
//    //此方法先做特殊处理
//    float lineLength =  pointOne.y > pointTwo.y ? pointOne.y - pointTwo.y : pointTwo.y - pointOne.y;
//    //UIColor* lineColor = [UIColor colorWithRed:193/255 green:192/255 blue:192/255 alpha:255/255];
//    //UIColor* lineColor = [UIColor redColor];
//    if (pointOne.y > pointTwo.y)
//    {
//        [self drawPixelVertical:context pointBegin:pointTwo lineLength:lineLength lineWidth:1 color:color];
//    }
//    else
//    {
//        [self drawPixelVertical:context pointBegin:pointOne lineLength:lineLength lineWidth:1 color:color];
//    }
    
    
}

//根据像素值绘制竖线
+ (void)drawPixelVertical:(CGContextRef)context pointBegin:(CGPoint)point lineLength:(int)length lineWidth:(int)width color:(CGColorRef)color
{
    CGContextSaveGState(context);
    point = [DrawTool adjustPoint:point];
    CGContextSetFillColorWithColor(context,color);
    if (length < 0)
    {
        length *= -1;
        point.y -= length;
    }
    CGRect rc =  CGRectMake(point.x, point.y, width, length);
    CGContextFillRect(context, rc);
    CGContextRestoreGState(context);
}

//根据像素绘制矩形
+ (void)drawPixelRect:(CGContextRef)context rectDraw:(CGRect)rect color:(CGColorRef)color
{
    CGPoint ptBegin;
    ptBegin = rect.origin;
    [DrawTool drawPixelHorizontal:context pointBegin:ptBegin lineLength:rect.size.width lineWidth:1 color:color];
    ptBegin.x = rect.origin.x;
    ptBegin.y = rect.origin.y + rect.size.height -1;
    [DrawTool drawPixelHorizontal:context pointBegin:ptBegin lineLength:rect.size.width lineWidth:1 color:color];
    ptBegin = rect.origin;
    [DrawTool drawPixelVertical:context pointBegin:ptBegin lineLength:rect.size.height lineWidth:1 color:color];
    ptBegin.x = rect.origin.x + rect.size.width -1;
    ptBegin.y = rect.origin.y;
    [DrawTool drawPixelVertical:context pointBegin:ptBegin lineLength:rect.size.height lineWidth:1 color:color];
}

//根据像素绘制矩形
+ (void)drawPixelRect:(CGContextRef)context rectDraw:(CGRect)rect color:(CGColorRef)color isFill:(BOOL)isFill
{
    CGPoint ptBegin;
    ptBegin = rect.origin;
    [DrawTool drawPixelHorizontal:context pointBegin:ptBegin lineLength:rect.size.width lineWidth:1 color:color];
    ptBegin.x = rect.origin.x;
    ptBegin.y = rect.origin.y + rect.size.height -1;
    [DrawTool drawPixelHorizontal:context pointBegin:ptBegin lineLength:rect.size.width lineWidth:1 color:color];
    ptBegin = rect.origin;
    [DrawTool drawPixelVertical:context pointBegin:ptBegin lineLength:rect.size.height lineWidth:1 color:color];
    ptBegin.x = rect.origin.x + rect.size.width -1;
    ptBegin.y = rect.origin.y;
    [DrawTool drawPixelVertical:context pointBegin:ptBegin lineLength:rect.size.height lineWidth:1 color:color];
    
    if (isFill) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, color);
        CGContextFillRect(context, CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height));
        CGContextRestoreGState(context);
    }
}

//绘制水平虚线
+ (void)drawDashedLineHorizontal:(CGContextRef)context pointBegin:(CGPoint)point lineLength:(int)length color:(CGColorRef)color
{
    for (int i = 0; i < length; i=i+2)
    {
        [DrawTool drawPixelHorizontal:context pointBegin:CGPointMake(point.x + i, point.y) lineLength:1 lineWidth:1 color:color];
    }
}

//绘制垂直虚线
+ (void)drawDashedLineVertical:(CGContextRef)context pointBegin:(CGPoint)point lineLength:(int)length color:(CGColorRef)color
{
    for (int i = 0; i < length; i=i+2)
    {
        [DrawTool drawPixelVertical:context pointBegin:CGPointMake(point.x, point.y + i) lineLength:1 lineWidth:1 color:color];
    }
}
//绘制K线红绿柱
+ (void)drawKLineColumn:(CGContextRef)context ptRectA:(CGPoint)ptRectA ptRectB:(CGPoint)ptRectB ptMax:(CGPoint)ptMax ptMin:(CGPoint)ptMin color:(CGColorRef)color isFill:(BOOL)isFill;
{
    CGPoint ptOrigin;
    CGFloat width,height;
    
    ptRectA = [DrawTool adjustPoint:ptRectA];
    ptRectB = [DrawTool adjustPoint:ptRectB];
    
    
    ptOrigin.x = ptRectA.x;
    ptOrigin.y = ptRectB.y;
    if ((ptRectB.x - ptRectA.x) < 0)
    {
        ptOrigin.x = ptRectB.x;
    }
    if ((ptRectA.y - ptRectB.y) < 0)
    {
        ptOrigin.y = ptRectA.y;
    }
    width = fabs(ptRectB.x - ptRectA.x) +1;
    height = fabs(ptRectA.y - ptRectB.y) +1;
    
    [DrawTool drawPixelRect:context rectDraw:CGRectMake(ptOrigin.x, ptOrigin.y, width, height) color:color];
    
    if (isFill) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, color);
        CGContextFillRect(context, CGRectMake(ptOrigin.x, ptOrigin.y, width, height));
        CGContextRestoreGState(context);
    }
    
    CGPoint ptH,ptL;
    if (ptMax.y >= ptMin.y)
    {
        ptH = ptMin;
        ptL = ptMax;
    }
    else
    {
        ptH = ptMax;
        ptL = ptMin;
    }
    ptH.x = (ptRectA.x + ptRectB.x)/2;
    ptL.x = ptH.x;
    ptH = [DrawTool adjustPoint:ptH];
    ptL = [DrawTool adjustPoint:ptL];
    
    if (ptH.y < ptOrigin.y)
    {
        [DrawTool drawPixelVertical:context pointBegin:ptH lineLength:ptOrigin.y - ptH.y + 1 lineWidth:1 color:color];
    }
    int rectL = ptOrigin.y + height - 1;
    if (ptL.y > rectL)
    {
        [DrawTool drawPixelVertical:context pointBegin:CGPointMake(ptL.x, rectL) lineLength:ptL.y - rectL + 1 lineWidth:1 color:color];
    }
}

//绘制布林线的布林带
//开盘价　收盘价　最高价　最低价　颜色
+ (void)drawBollLine:(CGContextRef)context ptRectA:(CGPoint)ptRectA ptRectB:(CGPoint)ptRectB ptMax:(CGPoint)ptMax ptMin:(CGPoint)ptMin color:(CGColorRef)color
{
    //绘制布林带，分别需要绘制最高点到最低点的一条直线，收盘价、开盘价的两条直线
    
    ptRectA = [DrawTool adjustPoint:ptRectA];
    ptRectB = [DrawTool adjustPoint:ptRectB];
    
    
    //画竖线,最高价的ｙ->最低价的ｙ
    if (ptMax.y < ptMin.y)
    {
        [DrawTool drawPixelVertical:context pointBegin:ptMax lineLength:ptMin.y - ptMax.y + 1.0 lineWidth:1 color:color];
    }
    
    //画收盘价的横线
    if (ptRectB.x - ptMax.x > 0)
    {
        //修改收盘价的ｘ坐标
        CGPoint closePoint = CGPointMake(ptMax.x, ptRectB.y);
        [DrawTool drawPixelHorizontal:context pointBegin:closePoint lineLength:ptRectB.x - ptMax.x + 1.0 lineWidth:1 color:color];
    }
    
    //画开盘价的横线
    if (ptRectA.x - ptMax.x < 0)
    {
        [DrawTool drawPixelHorizontal:context pointBegin:ptRectA lineLength:ptMax.x - ptRectA.x + 1.0 lineWidth:1 color:color];
    }
    
}

//绘制乾坤线（大盘晴雨表）
//起始点　终点　　颜色
+ (void)drawDPQYB:(CGContextRef)context ptRectA:(CGPoint)ptRectA ptRectB:(CGPoint)ptRectB color:(CGColorRef)color
{
    ptRectA = [DrawTool adjustPoint:ptRectA];
    ptRectB = [DrawTool adjustPoint:ptRectB];
    
    if (ptRectA.x > ptRectB.x || ptRectA.y > ptRectB.y)
    {
        return;
    }
    
    //把起点和终点组成一个rect
    
    CGRect rect = CGRectMake(ptRectA.x, ptRectA.y, ptRectB.x - ptRectA.x, ptRectB.y - ptRectA.y);
    
    [DrawTool drawPixelRect:context rectDraw:rect color:color];
    //填充颜色
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, color);
    CGContextFillRect(context, rect);
    CGContextRestoreGState(context);
    
}

//绘制红绿柱
+ (void)drawColumn:(CGContextRef)context ptRectA:(CGPoint)ptRectA ptRectB:(CGPoint)ptRectB color:(CGColorRef)color isFill:(BOOL)isFill
{
    CGPoint ptOrigin;
    CGFloat width,height;
    
    ptRectA = [DrawTool adjustPoint:ptRectA];
    ptRectB = [DrawTool adjustPoint:ptRectB];
    
    ptOrigin.x = ptRectA.x;
    ptOrigin.y = ptRectB.y;
    if ((ptRectB.x - ptRectA.x) < 0) {
        ptOrigin.x = ptRectB.x;
    }
    if ((ptRectA.y - ptRectB.y) < 0) {
        ptOrigin.y = ptRectA.y;
    }
    width = fabs(ptRectB.x - ptRectA.x) +1;
    height = fabs(ptRectA.y - ptRectB.y) +1;
    
    [DrawTool drawPixelRect:context rectDraw:CGRectMake(ptOrigin.x, ptOrigin.y, width, height) color:color];
    
    if (isFill) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, color);
        CGContextFillRect(context, CGRectMake(ptOrigin.x, ptOrigin.y, width, height));
        CGContextRestoreGState(context);
    }
}

//绘制三角形
+ (void)drawTriangle:(CGContextRef)context ptRectA:(CGPoint)ptRectA ptRectB:(CGPoint)ptRectB ptRectC:(CGPoint)ptRectC color:(CGColorRef)color isFill:(BOOL)isFill
{
    if (context == nil)
    {
        return;
    }
    ptRectA = [DrawTool adjustPoint:ptRectA];
    ptRectB = [DrawTool adjustPoint:ptRectB];
    ptRectC = [DrawTool adjustPoint:ptRectC];
    //三点一线
    if(ptRectA.x == ptRectB.x && ptRectA.x == ptRectC.x)
    {
        int minY = ptRectA.y;
        int maxY = ptRectA.y;
        if(ptRectB.y < minY)
        {
            minY = ptRectB.y;
        }
        else if(ptRectB.y > maxY)
        {
            maxY = ptRectB.y;
        }
        if(ptRectC.y < minY)
        {
            minY = ptRectC.y;
        }
        else if(ptRectB.y > maxY)
        {
            maxY = ptRectC.y;
        }
        [DrawTool drawPixelVertical:context pointBegin:CGPointMake(ptRectA.x, minY) lineLength:maxY-minY lineWidth:1 color:color];
        return;
    }
    
    if(ptRectA.y == ptRectB.y && ptRectA.y == ptRectC.y)
    {
        int minX = ptRectA.x;
        int maxX = ptRectA.x;
        if(ptRectB.x < minX)
        {
            minX = ptRectB.x;
        }
        else if(ptRectB.x > maxX)
        {
            maxX = ptRectB.x;
        }
        if(ptRectC.x < minX)
        {
            minX = ptRectC.x;
        }
        else if(ptRectB.x > maxX)
        {
            maxX = ptRectC.x;
        }
        [DrawTool drawPixelHorizontal:context pointBegin:CGPointMake(ptRectA.y, minX) lineLength:maxX-minX lineWidth:1 color:color];
        return;
    }
    
    //开始绘制三角形
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, ptRectA.x, ptRectA.y);
    CGContextAddLineToPoint(context, ptRectB.x, ptRectB.y);
    CGContextAddLineToPoint(context, ptRectC.x, ptRectC.y);
    
    CGContextClosePath(context);
    if (isFill)
    {
        CGContextSetFillColorWithColor(context, color);
        CGContextFillPath(context);
    }
    else
    {
        CGContextSetStrokeColorWithColor(context, color);
        CGContextStrokePath(context);
    }
    CGContextRestoreGState(context);
}
//绘制箭头
+ (void)drawArrow:(CGContextRef)context rectDraw:(CGRect)rect color:(CGColorRef)color bUpOrDown:(BOOL)bUpOrDown isFill:(BOOL)isFill
{
    if(bUpOrDown)    //向上箭头
    {
        //绘制三角形
        CGPoint pointA = CGPointMake(rect.origin.x + rect.size.width / 2,rect.origin.y);
        CGPoint pointB = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height / 3);
        CGPoint pointC = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height / 3);
        [DrawTool drawTriangle:context ptRectA:pointA ptRectB:pointB ptRectC:pointC color:color isFill:isFill];
        //绘制矩形
        CGPoint beginPoint = CGPointMake(pointB.x + rect.size.width / 3, pointB.y);
        [DrawTool drawPixelVertical:context pointBegin:beginPoint lineLength:(rect.size.height * 2 / 3) lineWidth:(rect.size.width / 3) color:color];
    }
    else            //向下箭头
    {
        //绘制矩形
        CGPoint beginPoint = CGPointMake(rect.origin.x + rect.size.width / 3, rect.origin.y);
        [DrawTool drawPixelVertical:context pointBegin:beginPoint lineLength:(rect.size.height * 2 / 3) lineWidth:(rect.size.width / 3) color:color];
        //绘制三角形
        CGPoint pointA = CGPointMake(rect.origin.x + rect.size.width / 2,rect.origin.y + rect.size.height);
        CGPoint pointB = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height * 2 / 3);
        CGPoint pointC = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height * 2 / 3);
        [DrawTool drawTriangle:context ptRectA:pointA ptRectB:pointB ptRectC:pointC color:color isFill:isFill];
    }
}

+ (CGPoint)adjustPoint:(CGPoint)point
{
    int x = point.x + 0.5;
    int y = point.y + 0.5;
    
    return CGPointMake(x, y);
}

+(void) drawRoundedRect:(CGContextRef)context rect:(CGRect)rect ovalWidth:(float)ovalWidth ovalHeight:(float)ovalHeight
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect),CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


//创建uiColor/cgcolor 获取cgColor 不需要自己释放
+(UIColor*) uicolorWithInt:(int)color
{
    int r = color & 0xFF;
    int g = color >> 8 & 0xFF;
    int b = color >> 16 & 0xFF;
    int a = color >> 24 & 0xFF;
    
    UIColor* uiColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
    return uiColor;
}

+(CGColorRef) cgcolorWithInt:(int)color
{
    int r = color & 0xFF;
    int g = color >> 8 & 0xFF;
    int b = color >> 16 & 0xFF;
    int a = color >> 24 & 0xFF;
    
    UIColor* uiColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
    return uiColor.CGColor;
}

//根据16进制颜色参数得到CGColorRef
+(CGColorRef )cgcolorWithlong:(long)color
{
    int r = ((0x00FF0000&color)>>16);
    int g = ((0x0000FF00&color)>>8);
    int b = (0x000000FF&color);
    
    UIColor* uiColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:255/255.0];
    return uiColor.CGColor;
    
}


+(UIColor*)getColorWithlong:(long)color
{
    int r = ((0x00FF0000&color)>>16);
    int g = ((0x0000FF00&color)>>8);
    int b = (0x000000FF&color);
    
    UIColor* uiColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:255/255.0];
    return uiColor;
    
}


//绘制渐变区域，数组colors存放需要渐变的颜色
+(void)DrawGradientArea:(CGContextRef)context setColor:(UIColor	**)colors setCGRect:(CGRect)rect setlocations:(CGFloat *)locations
               setCount:(int)count
{
    
    if (context == nil)
    {
        return;
    }
    int originX = 0;
    int originY = 0;
    CGRect clips = CGRectMake(originX +  rect.origin.x, originY + rect.origin.y, rect.size.width, rect.size.height);
    
    CGContextSaveGState(context);
    CGContextClipToRect(context, clips);
    CGFloat* components=(CGFloat*)malloc(sizeof(CGFloat)*4*count);
    for (int i=0; i<count; ++i) {
        UIColor *color=colors[i];
        size_t n=CGColorGetNumberOfComponents(color.CGColor);
        const CGFloat* rgba= CGColorGetComponents(color.CGColor);
        if (n==2)
        {
            components[i*4]=rgba[0];
            components[i*4+1]=rgba[0];
            components[i*4+2]=rgba[0];
            components[i*4+3]=rgba[1];
            
        }
        else if(n==4)
        {
            components[i*4]=rgba[0];
            components[i*4+1]=rgba[1];
            components[i*4+2]=rgba[2];
            components[i*4+3]=rgba[3];
        }
    }
    CGColorSpaceRef space=CGBitmapContextGetColorSpace(context);
    CGGradientRef gradient=CGGradientCreateWithColorComponents(space, components, locations, count);
    free(components);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.origin.x, rect.origin.y), CGPointMake(rect.origin.x, rect.origin.y+rect.size.height), kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
}


//绘制CGRect区域中的椭圆
+(void)FillEllipse:(CGContextRef)context setRect:(CGRect)rect setFillColor:(CGColorRef)fillColor setPanColor:(CGColorRef)panColor
{
    
    if (context==nil) {
        return;
    }
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, panColor);
    CGContextSetFillColorWithColor(context, fillColor);
    CGContextFillEllipseInRect(context,rect);
    CGContextRestoreGState(context);
    
}

//绘制扇形图
+(BOOL)DrawSector:(CGContextRef)context setRect:(CGRect)rt setDegreeFrom:(int)nDegreeFrom setDegreeTo:(int)nDegreeTo setbFill:(BOOL)bFill setPanColor:(CGColorRef)panColor setFillColor:(CGColorRef)FillColor
{
    if(context == NULL)
    {
        return false;
    }
    CGContextSetStrokeColorWithColor(context, panColor);
    CGContextSetFillColorWithColor(context, FillColor);
    //的到圆心
    int nX = (rt.origin.x + rt.origin.x+rt.size.width) /2 ;
    int nY = (rt.origin.y + rt.origin.y+rt.size.height) /2 ;
    int nRadius = (rt.size.width < rt.size.height  ? rt.size.width:rt.size.height)/2;
    
    CGContextMoveToPoint(context, nX, nY);
    CGContextAddArc(context, nX, nY, nRadius, -nDegreeTo*2*3.1415926/360,-nDegreeFrom*2*3.1415926/360, false);
    CGContextAddLineToPoint(context, nX, nY);	
    if(bFill)
    {
        CGContextFillPath(context);	
        
    }
    else
    {
        CGContextStrokePath(context);
    }
    return true;
}

+ (void)drawText:(CGContextRef)context text:(NSString*)str textRect:(CGRect)rect textColor:(CGColorRef)color withAttributes:(NSDictionary*)attributes
{
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context,color);
    //	CGFloat actrFontSize = 0;
    [str  drawInRect:rect withAttributes:attributes];
    
    //	CGSize used = [str sizeWithFont:font minFontSize:1 actualFontSize:nil forWidth:99999 lineBreakMode:UILineBreakModeTailTruncation];
    //    int drawedlen = used.width;
    CGContextRestoreGState(context);
    //    return drawedlen;
    
}
//画一个圆形
//+(void)drawRoundeByPoint:(CGContextRef)context startPoint:(CGPoint)pointOne desPoint:(CGPoint)pointTwo lineWidth:(int)width color:(CGColorRef)color
//{
//	CGContextSetStrokeColorWithColor(context, panColor);
//	//CGContextSetFillColorWithColor(context, FillColor);
//}


@end
