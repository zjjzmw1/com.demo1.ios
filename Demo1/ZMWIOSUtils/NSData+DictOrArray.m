//
//  NSData+DictOrArray.m
//  Toos
//
//  Created by xiaoming on 15/12/27.
//  Copyright © 2015年 shandandan. All rights reserved.
//

#import "NSData+DictOrArray.h"

@implementation NSData (DictOrArray)

#pragma mark ===data --->字典或数组。
+(id)data2DictOrArray:(NSData *)data{
    return [NSJSONSerialization
            JSONObjectWithData:data
            options:NSJSONReadingMutableLeaves
            error:nil];
}

@end
