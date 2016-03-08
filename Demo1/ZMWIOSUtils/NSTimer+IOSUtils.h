//
//  NSTimer+IOSUtils.h
//  Toos
//
//  Created by xiaoming on 15/12/24.
//  Copyright © 2015年 shandandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (IOSUtils)

+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;
+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

-(void)pauseTimer;
-(void)resumeTimer;

@end
