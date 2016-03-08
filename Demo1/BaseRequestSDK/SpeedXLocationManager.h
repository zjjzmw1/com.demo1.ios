//
//  SpeedXLocationManager.h
//  Vodka
//
//  Created by jinyu on 15/11/6.
//  Copyright © 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^LocationResponse) (BOOL locationSuccessed, CLLocation* location);

@interface SpeedXLocationManager : NSObject

@property(nonatomic, strong)NSString*   locationProvince;
@property(nonatomic, strong)NSString*   locationCity;
@property(nonatomic, strong)NSString*   locationArea;
@property(nonatomic, strong)NSString*   locationIdentifier;

+ (instancetype)defaultManager;
+ (void)startLocationManager:(LocationResponse)response;

@end
