//
//  UserInfoRequestManager.m
//  Vodka
//
//  Created by jinyu on 15/11/2.
//  Copyright © 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "UserInfoRequestManager.h"
#import "ProgressHUD.h"
#import "NSString+IOSUtils.h"

@implementation UserInfoRequestManager

#pragma mark - 用户登陆注册相关

/**
 *  通过手机号找回密码
 *
 *  @param mobilephone 手机号
 *  @param vcode       验证码
 *  @param password    新密码
 *  @param response    返回
 */
+ (void)resetPasswordByMobile:(NSString*)mobilephone vcode:(NSString *)vcode password:(NSString *)password response:(RequestResponseBlock)response {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    if(![NSString isEmptyString:mobilephone]){
        [params setObject:mobilephone forKey:@"mobilephone"];
    }
    if(![NSString isEmptyString:vcode]){
        [params setObject:vcode forKey:@"vcode"];
    }
    if(![NSString isEmptyString:password]){
        [params setObject:password forKey:@"password"];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@", CLIENT_HTTP_API, CLIENT_API_VERSION, kReset_Password_By_Mobile];
    [self createRequest:urlString params:params response:response];
}


@end
