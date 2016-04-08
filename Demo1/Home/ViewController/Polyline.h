//
//  Polyline.h
//  Demo1
//
//  Created by speedx on 16/4/8.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Polyline : NSObject


-(NSArray *)decodePolyline:(NSString *)encodedPolyline precision:(double)precision;

@end
