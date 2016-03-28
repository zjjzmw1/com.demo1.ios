//
//  AppDelegate.m
//  Demo1
//
//  Created by xiaoming on 16/2/23.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "HomeViewController.h"
#import "ActionDescrptionViewController.h"
#import "ImageSelectViewController.h"
#import "ShowBigImageBrowerViewController.h"

#import "UINavigationController+FDFullscreenPopGesture.h"       // 导航栏
#import <CYLTabBarController/CYLTabBarController.h>             // tabbar
#import "CYLTabBarControllerConfig.h"                           // 自己封装的tabbar的初始化



@interface AppDelegate ()

@property (strong, nonatomic) CYLTabBarController *tabBarController;    // 自定义tabbar

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor lightGrayColor];
    [self.window makeKeyAndVisible];
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    // 登录页面的测试
//    [self homeVC];
    // tabbar测试--规则的
//    [self setupViewControllers];
    // tabar测试--不规则的
//    [self initTabBarNotNomal];
    // 图文混排测试
//    [self fastTextViewVC];
    // 相册选取
//    [self imageSelectVC];

    // 图片大图浏览
    [self showBigImageBrower];
    return YES;
}

#pragma mark - 登录页面
-(void)loginVC {
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = loginNavi;
}
#pragma mark - 首页
-(void)homeVC {
    HomeViewController *loginVC = [[HomeViewController alloc]init];
    UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = loginNavi;
}
#pragma mark - 图文混排
-(void)fastTextViewVC {
    ActionDescrptionViewController *loginVC = [[ActionDescrptionViewController alloc]init];
    UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = loginNavi;
}
#pragma mark - 相册选取测试
-(void)imageSelectVC {
    ImageSelectViewController *loginVC = [[ImageSelectViewController alloc]init];
    UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = loginNavi;
}
#pragma mark - 相册大图浏览
-(void)showBigImageBrower {
    ShowBigImageBrowerViewController *loginVC = [[ShowBigImageBrowerViewController alloc]init];
    UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = loginNavi;
}
#pragma mark - tabbar 相关----规则的

- (void)setupViewControllers {
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:loginVC];
    
    RegisterViewController *regVC = [[RegisterViewController alloc]init];
    UINavigationController *regNavi = [[UINavigationController alloc]initWithRootViewController:regVC];
    
    LoginViewController *loginVC2 = [[LoginViewController alloc]init];
    UINavigationController *loginNavi2 = [[UINavigationController alloc]initWithRootViewController:loginVC2];
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc]init];
    
    [self customizeTabBarForController:tabBarController];
    
    // 最少两个、最多5个
    [tabBarController setViewControllers:@[
                                           loginNavi,
                                           regNavi,
                                           loginNavi2,
                                           ]];
    self.tabBarController = tabBarController;
    [self.window setRootViewController:self.tabBarController];

}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"account_normal",
                            CYLTabBarItemSelectedImage : @"account_highlight",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"同城",
                            CYLTabBarItemImage : @"message_normal",
                            CYLTabBarItemSelectedImage : @"message_highlight",
                            };
    
    NSArray *tabBarItemsAttributes = @[ dict1, dict2,dict1 ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

#pragma mark - tabbar 相关----不规则的
-(void)initTabBarNotNomal{
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
    [self.window setRootViewController:tabBarControllerConfig.tabBarController];
}
/**
 *  tabBarItem 的选中和不选中文字属性、背景图片
 */
- (void)customizeInterface {
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 设置背景图片
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
