//
//  NSArray+jsonString.m
//  Toos
//
//  Created by xiaoming on 15/12/24.
//  Copyright © 2015年 shandandan. All rights reserved.
//

#import "NSArray+jsonString.h"

@implementation NSArray (jsonString)

/**
 *  @brief  把NSArray转为JSONString.
 *
 *  @return json string
 */
- (NSString*)jsonString{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if(error){
        NSLog(@"数组转JSON发生错误！");
        return @"";
    }
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

@end
