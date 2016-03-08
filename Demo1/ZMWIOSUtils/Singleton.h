//
//  Singleton.h
//  Toos
//
//  Created by xiaoming on 15/12/27.
//  Copyright © 2015年 shandandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

+ (id)sharedInstance;

@property (assign, nonatomic) int   testAge;
@property (strong, nonatomic) NSString *testName;

@end

extern Singleton * singleton;   //用之前 singleton = [Singleton sharedInstance];   以后就可以只有用 singleton.属性了