//
//  DeviceUtility.h
//  Vodka
//
//  Created by Mark C.J. on 15-3-25.
//  Copyright (c) 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceUtility : NSObject

/// 获取设备系统版本
+ (NSString *) getDeviceOSVersion;

///获得设备型号
+ (NSString *) getDeviceModel;

/**
 *  @brief  获取设备的mac地址
 *
 *  @return mac地址的16为 MD5编码
 */
+ (NSString*)deviceMACAddress;


/**
 *  @brief  获取设备 IDFA
 *
 *  @return IDFA
 */
+ (NSString *)idfaString;
    
/**
 *  @brief  获取设备 IDFV
 *
 *  @return IDFV
 */
+ (NSString *)idfvString;

@end
