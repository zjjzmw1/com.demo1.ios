//
//  NSDictionary+jsonString.m
//  Toos
//
//  Created by xiaoming on 15/12/24.
//  Copyright © 2015年 shandandan. All rights reserved.
//

#import "NSDictionary+jsonString.h"

@implementation NSDictionary (jsonString)

/**
 *  @brief  把NSDictionary转为JSONString.
 *
 *  @return json string
 */
- (NSString*)jsonString{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if(error){
        NSLog(@"字典转JSON发生错误！");
        return @"";
    }
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

@end
