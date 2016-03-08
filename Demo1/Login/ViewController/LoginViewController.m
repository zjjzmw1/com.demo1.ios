//
//  LoginViewController.m
//  Demo1
//
//  Created by xiaoming on 16/2/23.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";// 尽量不用self.title 否则 配合tabbar用的时候会有bug
    __weak typeof(self) wSelf = self;
    [self rightButtonWithName:@"注册" image:nil block:^(UIButton *btn) {
        RegisterViewController *detailVC = [[RegisterViewController alloc]init];
        [wSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

@end
