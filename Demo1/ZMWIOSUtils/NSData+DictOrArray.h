//
//  NSData+DictOrArray.h
//  Toos
//
//  Created by xiaoming on 15/12/27.
//  Copyright © 2015年 shandandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DictOrArray)

/**
 *  data --->字典或数组
 *
 *  @param data 原始data
 *
 *  @return 字典或者数组
 */
+(id)data2DictOrArray:(NSData *)data;

@end
