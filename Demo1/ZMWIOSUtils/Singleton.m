//
//  Singleton.m
//  Toos
//
//  Created by xiaoming on 15/12/27.
//  Copyright © 2015年 shandandan. All rights reserved.
//

#import "Singleton.h"

Singleton *singleton = nil;
@implementation Singleton

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc]init];
    });
    
    return singleton;
}

@end


//Daojia2 *daojia2 = nil;
//
//@implementation Daojia2
//
//+(id)allocWithZone:(struct _NSZone *)zone{
//    static Daojia2 *instance;
//    //dispatch_once 是线程安全的。，能保证块代码中的指令只被执行一次。
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        //这里面的代码永远只会被执行一次。
//        instance = [super allocWithZone:zone];
//    });
//    return instance;
//}
//
//+(instancetype)shareInstance{
//    return [[self alloc]init];
//}
//
//@end

//static ViewControllerFactory *classA = nil;//静态的该类的实例
//+ (ViewControllerFactory *)sharedManager
//{
//    @synchronized(self) {
//        if (!classA) {
//            classA = [[super allocWithZone:NULL]init];
//        }
//        return classA;
//    }
//}
//
//- (id)copyWithZone:(NSZone *)zone {
//    return self;
//}