//
//  TestVC.m
//  Demo1
//
//  Created by xiaoming on 16/4/2.
//  Copyright © 2016年 shandandan. All rights reserved.
//encoded polyline

#import "TestVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Demo1-Swift.h"


#import "Polyline.h"

@implementation TestVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 预期结果
//    lon= -120.2 lat===38.5
//    lon= -120.95 lat===40.7
//    lon= -126.453 lat===43.252
    // 测试谷歌的polyLine
    NSString *encodedPolyline = @"_p~iF~ps|U_ulLnnqC_mqNvxq`@";
    // 测试---------------------------------------
    Polyline *p = [[Polyline alloc]init];
    NSArray *arry =  [p decodePolyline:encodedPolyline];
    for (int i = 0; i <arry.count; i++) {
        CLLocationCoordinate2D last = [(NSValue *)arry[i] MKCoordinateValue];
        NSLog(@"lat = %f lon = %f",last.latitude,last.longitude);
    }

}

@end
