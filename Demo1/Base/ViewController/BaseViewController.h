//
//  BaseViewController.h
//  Demo1
//
//  Created by xiaoming on 16/2/22.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyView.h"                                           // 空页面
#import <UINavigationController+FDFullscreenPopGesture.h>       // 导航栏
#import "Tooles.h"                                              // 工具类
#import "GlobalDefinition.h"                                    // 常用的宏

@interface BaseViewController : UIViewController
/// 没有内容的时候的view.
@property (strong, nonatomic) EmptyView *emptyView;

/**
 *  导航栏左边按钮
 *
 *  @param name        按钮名称
 *  @param imageString 按钮图片
 *  @param block       返回导航栏左边按钮
 */
- (void)leftButtonWithName:(NSString *)name image:(NSString *)imageString block:(void(^)(UIButton *btn))block;

/**
 *  导航栏右边按钮
 *
 *  @param name        按钮名称
 *  @param imageString 按钮图片
 *  @param block       返回导航栏右边按钮
 */
- (void)rightButtonWithName:(NSString *)name image:(NSString *)imageString block:(void(^)(UIButton *btn))block;

/**
 *  下个页面的返回按钮的文字
 *
 *  @param title 按钮的文字（nil是返回，空格是没有）
 */
-(void)nextBackTitle:(NSString *)title;

@end