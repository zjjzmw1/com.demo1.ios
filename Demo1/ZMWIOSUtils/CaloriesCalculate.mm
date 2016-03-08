//
//  CaloriesCalculate.m
//  Vodka
//
//  Created by fusunlang on 9/1/14.
//  Copyright (c) 2014 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "CaloriesCalculate.h"

//跑步热量（kcal）＝体重（kg）×运动时间（小时）×指数K
//指数K＝75÷速度（分钟/1000米） 例如：速度是 2米每秒的话    speed =  ((1.0f/60.0)/(2/1000.0f));

@implementation CaloriesCalculate

/*!
 @brief 计算卡路里消耗指数
 @param type    运动类型
 @param speed   速度,单位 分钟/1000米   例如：速度是 2米每秒的话    speed =  ((1.0f/60.0)/(2/1000.0f));
 @return 指数
 */
+ (double)calculateValueKWithSportType:(SportType)type andSpeed:(double)speed
{
    if (speed == 0) {
        return 0.0;
    }
    switch (type) {
        case SportType_Running:
        {
            return 75.0/speed;
        }
            break;
        case SportType_Cycling:
        {
            return 35.0/speed;
        }
            break;
            
        default:
        {
            return 75.0/speed;
        }
            break;
    }
}

/*!
 @brief 计算卡路里消耗
 @param weight  体重，单位KG
 @param hour    运动时间 单位小时
 @param K       指数
 @return 运动热量   单位千卡
 */
+ (double)calculate:(double)weight time:(double)hour index:(double)K
{
    return weight*hour*K;
}

@end
