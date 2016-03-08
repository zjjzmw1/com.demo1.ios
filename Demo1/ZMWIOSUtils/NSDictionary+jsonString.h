//
//  NSDictionary+jsonString.h
//  Toos
//
//  Created by xiaoming on 15/12/24.
//  Copyright © 2015年 shandandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (jsonString)

/**
 *  @brief  把NSDictionary转为JSONString.
 *
 *  @return json string
 */
- (NSString*)jsonString;

@end
