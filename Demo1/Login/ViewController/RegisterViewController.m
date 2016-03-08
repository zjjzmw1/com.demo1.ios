//
//  RegisterViewController.m
//  Demo1
//
//  Created by xiaoming on 16/2/24.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "RegisterViewController.h"
#import "GlobalDefinition.h"
#import "UIView+Utils.h"
#import "LoginViewController.h"

@interface RegisterViewController ()

@property (strong, nonatomic) UIScrollView *scrollV;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"注册";// 尽量不用self.title 否则 配合tabbar用的时候会有bug
    __weak typeof(self) wSelf = self;
    [self leftButtonWithName:@"返回" image:nil block:^(UIButton *btn) {
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self rightButtonWithName:@"右边" image:nil block:^(UIButton *btn) {
        
    }];
    
    [self initScrollView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 需要隐藏的时候，在viewWillAppear里面写。
    self.navigationController.navigationBarHidden = YES;

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

-(void)initScrollView{
    self.scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.scrollV.backgroundColor = [UIColor redColor];
    self.scrollV.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 200);
    [self.view addSubview:self.scrollV];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollV.height)];
    imageV.backgroundColor = [UIColor grayColor];
    [self.scrollV addSubview:imageV];
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollV.height)];
    imageV2.backgroundColor = [UIColor blueColor];
    [self.scrollV addSubview:imageV2];
    
    imageV.userInteractionEnabled = YES;
    self.scrollV.userInteractionEnabled = YES;
    __weak typeof(self) wSelf = self;
    [imageV setTapActionWithBlock:^{
        LoginViewController *detailVC = [[LoginViewController alloc]init];
        [wSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    
}

@end
