//
//  CaloriesCalculate.h
//  Vodka
//
//  Created by fusunlang on 9/1/14.
//  Copyright (c) 2014 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaloriesCalculate : NSObject

#pragma mark - 骑行相关
typedef enum
{
    SportType_Running,
    SportType_Cycling
} SportType;

/*!
 @brief 计算卡路里消耗指数
 @param type    运动类型
 @param speed   速度,单位 分钟/1000米
 @return 指数
 */
+ (double)calculateValueKWithSportType:(SportType)type andSpeed:(double)speed;

/*!
 @brief 计算卡路里消耗
 @param weight  体重，单位KG
 @param hour    运动时间 单位小时
 @param K       指数
 @return 运动热量   单位千卡
 */
+ (double)calculate:(double)weight time:(double)hour index:(double)K;

@end
