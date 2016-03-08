//
//  FirstViewController.m
//  Demo1
//
//  Created by xiaoming on 16/2/26.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第一页";
    // 隐藏导航栏
    self.fd_prefersNavigationBarHidden = YES;

    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *button = [Tooles getButton:CGRectMake(100, 200, 60, 50) title:@"push" titleColor:[UIColor redColor] titleSize:16];
    [self.view addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        SecondViewController *detailVC = [[SecondViewController alloc]init];
        [self.navigationController pushViewController:detailVC animated:YES];
    }];
    
}

@end
