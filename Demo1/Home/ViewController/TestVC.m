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

@implementation TestVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
//    lon= -120.2 lat===38.5
//    lon= -120.95 lat===40.7
//    lon= -126.453 lat===43.252
    // 测试谷歌的polyLine
    NSString *encodedPolyline = @"_p~iF~ps|U_ulLnnqC_mqNvxq`@";
    
//    let coordinates : [CLLocationCoordinate2D]? = Polyline.decodePolyline(encodedPolyline)
//    
//    for  coor:CLLocationCoordinate2D in coordinates! {
//        print("lon= \(coor.longitude) lat===\(coor.latitude) ")
//    }
    
    
    Polyline *p = [[Polyline alloc]init];


//    NSMutableArray *arr =  Polyline.decodePolyline(encodedPolyline);
//    Polyline deco
    
    Test1 *t = [[Test1 alloc]init];
    
//    NSString *res =  [t testAction2:@"sdfdg"];
//   NSString *d = [Polyline dddd:@"ddddsf"];
    CLLocationCoordinate2D cl = CLLocationCoordinate2DMake(11, 12);
    
    NSValue *value = [NSValue valueWithMKCoordinate:cl];
    
    NSMutableArray *ar = [NSMutableArray array];
    [ar addObject:value];

   NSArray *arry = [NSArray arrayWithArray:[Polyline decodePolyline:encodedPolyline precision:100*1000]];
    
    
    for (int i = 0; i <arry.count; i++) {
        CLLocationCoordinate2D last = [(NSValue *)arry[i] MKCoordinateValue];
        NSLog(@"res====%f,,,%f",last.latitude,last.longitude);
    }
   
    
    
}

@end
