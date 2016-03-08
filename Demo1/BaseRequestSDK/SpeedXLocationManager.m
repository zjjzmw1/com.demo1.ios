//
//  SpeedXLocationManager.m
//  Vodka
//
//  Created by jinyu on 15/11/6.
//  Copyright © 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//


#import "SpeedXLocationManager.h"
#import "UserInfoRequestManager.h"

@interface SpeedXLocationManager ()<CLLocationManagerDelegate>

@property(nonatomic, strong)LocationResponse    locationResponse;

@property(nonatomic, strong)CLLocationManager*  locationManager;

@end

@implementation SpeedXLocationManager

+ (instancetype)defaultManager{
    static id pRet = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        pRet = [[self alloc] init];
    });
    return pRet;
}
- (id)init{
    if(self = [super init]){
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager setDelegate:self];
    }
    return self;
}

+ (void)startLocationManager:(LocationResponse)response{
    [[SpeedXLocationManager defaultManager] setLocationResponse:response];
    [[[SpeedXLocationManager defaultManager] locationManager] setDelegate:[SpeedXLocationManager defaultManager]];
    [[[SpeedXLocationManager defaultManager] locationManager] startUpdatingLocation];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        [[[SpeedXLocationManager defaultManager] locationManager] setAllowsBackgroundLocationUpdates:YES];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [self.locationManager setDelegate:nil];
    CLLocation *loc = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    __weak typeof(self) wSelf = self;
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        
        //省份
        wSelf.locationProvince  = placemark.administrativeArea;
        //城市
        wSelf.locationCity      = placemark.locality;
        //区域
        wSelf.locationArea      = placemark.subLocality;
        
        NSLog(@"%@-%@-%@", wSelf.locationProvince, wSelf.locationCity, wSelf.locationArea);
        
//        // 登录成功、并且用户信息的城市码为空的话
//        if (![NSString isEmptyString:[[UserManager ShareInstance] userModel].sessionId] && [NSString isEmptyString:[UserManager ShareInstance].userModel.geoCode] && ![NSString isEmptyString:wSelf.locationProvince]) {
//            /// 发送城市码的请求
//            [UserInfoRequestManager getGeoCode:wSelf.locationProvince response:^(BOOL successed, NSInteger code, NSString *responseString) {
//                if (successed) {
//                    if (![NSString isEmptyString:responseString]) {
//                        [UserManager ShareInstance].userModel.geoCode = responseString;
//                    }
//                }
//            }];
//        }
        
        [self.locationManager stopUpdatingLocation];
        [self.locationManager stopUpdatingHeading];//todo100-这里需要停止定位。费电
        
        if([NSString isEmptyString:wSelf.locationProvince] && [NSString isEmptyString:wSelf.locationCity] && [NSString isEmptyString:wSelf.locationArea]){
            self.locationResponse(NO, nil);
        }else{
            self.locationResponse(YES, loc);
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    self.locationResponse(NO, nil);
}

@end
