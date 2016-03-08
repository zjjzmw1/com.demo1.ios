//
//  UserInfoRequestManager.h
//  Vodka
//
//  Created by jinyu on 15/11/2.
//  Copyright © 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "RequestBaseManager.h"

/// 通过手机号重置密码
#define kReset_Password_By_Mobile           @"resetPasswordByMobile"


#define NO_EMAIL_ERROR_CODE             -4000       //注册信息缺少邮箱code定义
#define NO_NICKNAME_ERROR_CODE          -4001       //注册信息缺少用户昵称Code定义
#define NO_PASSWORD_ERROR_CODE          -4002       //注册信息缺少密码Code定义
#define NO_USERID_ERROR_CODE            -4003       //没有UserId的Code定义


@interface UserInfoRequestManager : RequestBaseManager

/**
 *  通过手机号找回密码
 *
 *  @param mobilephone 手机号
 *  @param vcode       验证码
 *  @param password    新密码
 *  @param response    返回
 */
+ (void)resetPasswordByMobile:(NSString*)mobilephone vcode:(NSString *)vcode password:(NSString *)password response:(RequestResponseBlock)response;


@end
