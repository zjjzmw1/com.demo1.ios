//
//  NSArray+jsonString.h
//  Toos
//
//  Created by xiaoming on 15/12/24.
//  Copyright © 2015年 shandandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (jsonString)

/**
 *  @brief  把NSArray转为JSONString.
 *
 *  @return json string
 */
- (NSString*)jsonString;

@end
