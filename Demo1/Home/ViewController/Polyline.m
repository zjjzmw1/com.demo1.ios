//
//  Polyline.m
//  Demo1
//
//  Created by speedx on 16/4/8.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "Polyline.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@implementation Polyline

//enum PolylineError: ErrorType {
//    
//case SingleCoordinateDecodingError
//case ChunkExtractingError
//    
//}

// Decode google maps polyline string to coordinate

//-(double)decodeSingleCoordinate(byteArray byteArray: UnsafePointer<Int8>, length: Int, inout position: Int, precision: Double = 1e5) throws -> Double {
-(double)decodeSingleCoordinate:(const char *)byteArray length:(int)length position:(inout int)position precision:(double)precision {

    precision = 100*1000.0;
    if (position < length) {
        
    } else{
        // 错误异常
        return 0;
    }
    
//    int bitMask = Int8(0x1F);
    int bitMask = 0x1F;
    
    int coordinate = 0;
    
    int currentChar;
    int componentCounter = 0;
    int component = 0;
    
    
    
    do {
        currentChar = byteArray[position] - 63;
        component = (currentChar & bitMask);
        coordinate |= (component << (5*componentCounter));
        position++;
        componentCounter++;
        NSLog(@"position====%d",position);
        
    } while (((currentChar & 0x20) == 0x20) && (position < length) && (componentCounter < 6)) ;
    
    
    if((componentCounter == 6) && ((currentChar & 0x20) == 0x20)){
        // 报错
        return 0.0f;
    }

    
    if ((coordinate & 0x01) == 0x01) {
        coordinate = ~(coordinate >> 1);
    }
    else {
        coordinate = coordinate >> 1;
    }
    
    return (double)coordinate / precision;
}

// Decode array of google maps polyline string to an array of coordinates




-(NSArray *)decodePolyline:(NSString *)encodedPolyline precision:(double)precision{
    
    
    NSData *data = [encodedPolyline dataUsingEncoding:NSUTF8StringEncoding];

    void* b=malloc(100);
    b = data.bytes;
    
    
    char* byteArray=(char*)b;
    
    int length = (int)data.length;
    int  position = 0;
    
    NSMutableArray *result = [NSMutableArray array];
    
    double lat = 0.0;
    double lon = 0.0;
    
   
//        do{
//            double resultingLat = [self decodeSingleCoordinate:byteArray length:length position:position precision:precision];
//            
//            lat += resultingLat;
//            NSLog(@"resultingLat====%f",resultingLat);
//            double resultingLon = [self decodeSingleCoordinate:byteArray length:length position:position precision:precision];
//            
//            lon += resultingLon;
//            
//            NSLog(@"resultingLon====%f",resultingLon);
//            
//            CLLocationCoordinate2D cl = CLLocationCoordinate2DMake(lat, lon);
//            
//            [result addObject:[NSValue valueWithMKCoordinate:cl]];
//
//        }
    while (position < length){
        double resultingLat = [self decodeSingleCoordinate:byteArray length:length position:position precision:1e5];
        
        lat += resultingLat;
        NSLog(@"resultingLat====%f",resultingLat);
        double resultingLon = [self decodeSingleCoordinate:byteArray length:length position:position precision:1e5];
        
        lon += resultingLon;
        
        NSLog(@"resultingLon====%f",resultingLon);
        
        CLLocationCoordinate2D cl = CLLocationCoordinate2DMake(lat, lon);
        
        [result addObject:[NSValue valueWithMKCoordinate:cl]];

    }

    return result;
    
}


@end
