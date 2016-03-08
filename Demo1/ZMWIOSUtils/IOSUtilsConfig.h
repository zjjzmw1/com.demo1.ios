//
//  IOSUtilsConfig.h
//  zhangmingwei
//
//  Created by xiaoming on 14-3-11.
//  Copyright (c) 2014年 zhangmingwei. All rights reserved.


#if DEBUG
///debug模式下-------------------------------------------
#define DJLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define kBaseURL @"https://www.baidu.com/testApi"

#else
///release模式下-----------------------------------------
#define DJLog(tmt, ...)
#define kBaseURL @"https://www.baidu.com.api"


#endif

/*-----------------------------------统计，分享，推送--------------------------------------*/
#define UMENG_APPKEY @"55a3296b67e58e18c2001bab"

///微信的key和Secret--->已经添加我们的了。
#define kWeChatAppId @"wx395729da73fced79"
#define kWeChatSecret @"597411833937d43adbc3a506502202c8"
#define kQQAppId @"100735284"
#define kQQKey @"00dd0b2eb427d530654ae59aaaca338b"

#define kBaiduApiKey @"2qoGQfsfg5CcB9cU9PXHNBGX"
/*-----------------------------------常用的方法--------------------------------------------*/
#define kAnimationTime 0.3f
#define kCurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CLEARCOLOR [UIColor clearColor]
#define kUserDefault [NSUserDefaults standardUserDefaults]
#define kApplication [UIApplication sharedApplication]
#define kDataEnv [DataEnvironment sharedDataEnvironment]
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)
#define kRadianToDegrees(radian) (radian*180.0)/(M_PI)

#define kDefaultSmallImageString @"defaultAllImage"
//#define kBigImageString @"defaultAllImage"


#define kRgbColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define kRgbColor2(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
/* 根据名称加载有缓存图片 */
#define kImageNamed(name) [UIImage imageNamed:name]
/* 获取程序代理 */
#define kAppdelegate        ((AppDelegate *)[[UIApplication sharedApplication] delegate])
/* 获取USERDEFAULTS对象 */
#define kNotificactionCenter [NSNotificationCenter defaultCenter]
/* 获取系统信息 */
#define kSystemVersion   [[UIDevice currentDevice] systemVersion]
/* 获取当前APP版本 */
#define kAppVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
/* 获取系统目录 */
#define kGetDirectory(NSSearchPathDirectory) [NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory, NSUserDomainMask, YES)lastObject]
/* 获取NSFILEMANAGER对象 */
#define kFileManager [NSFileManager defaultManager]
/* 获取任意WINDOW对象 */
#define kWindow             [[[UIApplication sharedApplication] windows] lastObject]
/* 获取KEYWINDOW对象 */
#define kKeyWindow          [[UIApplication sharedApplication] keyWindow]
/* 获取当前控制器的navigationBar */
#define kNavigationBar      [[self navigationController] navigationBar]
/* 简单提示框 */
#define kAlert(title, msg)  [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show]
/*------------------------------------加载图片---------------------------------------*/
/* 根据名称加载无缓存图片 */
#define kNoCacheImagewithName(name, ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:ext]]
/* 根据路径加载无缓存图片 */
#define kNoCacheImagewithPath(path) [UIImage imageWithContentsOfFile:path]
/*------------------------------------视图------------------------------------------*/
/* 根据TAG获取视图 */
#define kViewWithTag(PARENTVIEW, TAG, CLASS) ((CLASS *)[PARENTVIEW viewWithTag:TAG])
/* 加载NIB文件 */
#define kLOADNIBWITHNAME(CLASS, OWNER) [[[NSBundle mainBundle] loadNibNamed:CLASS owner:OWNER options:nil] lastObject]
/* 异步 */
#define kGCDAsync(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
/* 同步 */
#define kGCDMain(block) dispatch_async(dispatch_get_main_queue(),block)
/* 获取当前语言环境 */
#define kCurrentLanguage [[NSLocale preferredLanguages] objectAtIndex:0]

#ifndef SCREENBOUND
#define SCREENBOUND [UIScreen mainScreen].bounds
#endif
#ifndef APPBOUND
#define APPBOUND [UIScreen mainScreen].applicationFrame
#endif

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kTabbarHeight                       49.0f
#define SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define IOS7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)?YES:NO
#define IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0)?YES:NO
#define kNavigationBarHeight ((IS_IOS_7) ? 64.0f : 44.0f)
#define kIsIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIsIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIsRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kIsIphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define kiPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)



