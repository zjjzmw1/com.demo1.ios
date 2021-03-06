//
//  RequestBaseManager.m
//  Vodka
//
//  Created by jinyu on 15/10/29.
//  Copyright © 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "RequestBaseManager.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "IOSUtils.h"
#import "NSDictionary+jsonString.h"
#import "APIKey.h"

@interface RequestBaseManager ()
@end

@implementation RequestBaseManager

instance_implementation(RequestBaseManager, defaultManager)

- (id)init {
    if(self = [super init]) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.securityPolicy.allowInvalidCertificates = YES;
        self.sessionManager.securityPolicy.validatesDomainName = NO;
        [[self.sessionManager requestSerializer] setHTTPShouldHandleCookies:YES];
        [[self.sessionManager requestSerializer] setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [self createRequestHeader];
    }
    return self;
}

/**
 *  @brief  创建网络请求的 Cookies, 该方法需要在用户登录成功以后，发起任何一个网络请求之前调用.
 */
- (void)createRequestCookie {
    /// 全局的登录的token
    NSString *loginToken = @"从单例里面取";
    if([NSString isEmptyString:loginToken]) {
        return;
    }
    NSString* sessionToken  = loginToken;
    NSString* domain        = COOKIES_DOMAIN;
    NSString* path          = @"/";
    if(![NSString isEmptyString:sessionToken]){
        NSDictionary* dict = @{NSHTTPCookieName:@"sessionid", NSHTTPCookieValue:sessionToken, NSHTTPCookieDomain:domain, NSHTTPCookiePath:path};
        NSHTTPCookie* cookie = [[NSHTTPCookie alloc] initWithProperties:dict];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        NSLog(@"创建 Cookie 成功: cookie--\n%@", dict);
    }
}

/**
 *  @brief  清除本地Cookie, 该方法需要在退出登录时调用，使新登录的用户使用自己对应的Cookie
 */
- (void)clearRequestCookie {
    NSString* sessionToken  = [[NSUserDefaults standardUserDefaults]objectForKey:@"CurrentUserSessionId"];
    
    NSString* domain        = COOKIES_DOMAIN;
    NSString* path          = @"/";
    if(![NSString isEmptyString:sessionToken]){
        NSDictionary* dict = @{NSHTTPCookieName:@"sessionid", NSHTTPCookieValue:sessionToken, NSHTTPCookieDomain:domain, NSHTTPCookiePath:path};
        NSHTTPCookie* cookie = [[NSHTTPCookie alloc] initWithProperties:dict];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        NSLog(@"清除本地 Cookie: cookie--\n%@", dict);
    }
}

/**
 *  @brief 设置请求头, 当切换系统区域以后，该方法需要重新调用，重新设置请求头
 */
- (void)createRequestHeader{
    NSString* userAgent = [NSString stringWithFormat:@"iOS/%f;%@;beast/%@.%@", [[[UIDevice currentDevice] systemVersion] floatValue], [RequestBaseManager getiPhoneModel], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    
    NSString* lang      = (([[NSLocale preferredLanguages] objectAtIndex:0]) == nil ? @"" : ([[NSLocale preferredLanguages] objectAtIndex:0]));
    
    [[self.sessionManager requestSerializer] setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [[self.sessionManager requestSerializer] setValue:lang forHTTPHeaderField:@"X-Client-Lang"];
}

/**
 *  @brief  get请求方法，父类方法（在AFNetworking的请求的基础上添加网络判断）
 *
 *  @param  URLString         URLString
 *  @param  parameters        请求参数
 *  @param  networkValidBlock 网络状态block
 *  @param  success           请求成功的block
 *  @param  failure           请求失败的block
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters networkStatusBlock:(NetworkInvalidBlock)networkValidBlock success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    BOOL networkValid = [self isNetworkValid];
    if(!networkValid){
        networkValidBlock(NO, NSLocalizedString(@"当前网络连接不可用，请检查您的网络设置", @"没有网络连接的提示信息"));
        return;
    } else {
        [[RequestBaseManager defaultManager].sessionManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(task, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(task, error);
        }];
        
    }
}

/**
 *  @brief  POST请求方法，父类方法（在AFNetworking的请求的基础上添加网络判断）
 *
 *  @param  URLString         URLString
 *  @param  parameters        请求参数
 *  @param  networkValidBlock 网络状态block
 *  @param  success           请求成功的block
 *  @param  failure           请求失败的block
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters networkStatusBlock:(NetworkInvalidBlock)networkValidBlock success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    BOOL networkValid = [self isNetworkValid];
    if(!networkValid){
        networkValidBlock(NO, NSLocalizedString(@"当前网络连接不可用，请检查您的网络设置", @"没有网络连接的提示信息"));
        return;
    } else {
        [[RequestBaseManager defaultManager].sessionManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(task, responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(task, error);
        }];
    }
}

/**
 *  @brief  判断当前是否存在网络连接
 *
 *  @return YES:已经接入网络，NO:未连接网络
 */
+ (BOOL)isNetworkValid
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags){
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

/**
 *  @brief  生成网络请求
 *
 *  @param  urlString url
 *  @param  params    参数
 *  @param  response  block
 */
+ (void)createRequest:(NSString*)urlString params:(NSDictionary*)params response:(RequestResponseBlock)response {
    
    [self POST:urlString parameters:params networkStatusBlock:^(BOOL networkValid, NSString *message) {
        //无网络连接
        response(NO, NETWORK_INVALID_CODE, message);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary* dict = (NSDictionary*)responseObject;
        NSInteger code = [SAFE_GET_NUMBER(dict, RESPONSE_CODE_KEY) integerValue];
        if(code == 0) {
            if([dict[RESPONSE_RESULT_KEY] isKindOfClass:[NSArray class]] || [dict[RESPONSE_RESULT_KEY] isKindOfClass:[NSDictionary class]]){
                response(YES, code, [dict[RESPONSE_RESULT_KEY] jsonString]);
            }else{
                response(YES, code, [NSString stringWithFormat:@"%@", SAFE_GET_NUMBER(dict, RESPONSE_RESULT_KEY)]);
            }
        }else{
            if (code == 1002) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"kReLoginAction" object:nil];
            }
            response(NO, code, dict[RESPONSE_MESSAGE_KEY]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        response(NO, HTTP_ERROE_CODE, NSLocalizedString(@"网络不给力", nil));
    }];
}

/**
 *  @brief  获取设备型号（仅 iPhone）
 *
 *  @return 设备型号
 */
+ (NSString *)getiPhoneModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    return platform;
}

@end
