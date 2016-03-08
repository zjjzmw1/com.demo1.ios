//
//  BaseViewController.m
//  Demo1
//
//  Created by xiaoming on 16/2/22.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "BaseViewController.h"
#import "IOSUtilsConfig.h"
#import "UIColor+IOSUtils.h"
#import "UIView+Utils.h"
#import "NSString+IOSUtils.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BaseColorDefinition.h"
#import "ProgressHUD.h"
#import "UIImage+IOSUtils.h"
#import "UIView+Utils.h"

@interface BaseViewController () {
    
}

@end

@implementation BaseViewController


-(instancetype)init {
    self = [super init];
    if (self) {
        // 子类不重写这个方法，也会调用。
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"注册";// 尽量不用self.title 否则 配合tabbar用的时候会有bug

    [ProgressHUD dismiss];// 进入下个页面首先把hud消失。
    self.view.backgroundColor = kBase_Color_View_Color_Bg;// 页面默认的背景页面
    [self navigationBarTitleColor];// 设置导航栏的字体颜色
    [self nextBackTitle:self.title];// 不加这句的话，默认返回按钮是有文字的。
    // 隐藏导航栏(子类需要的话，在子类的viewDidLoad里面加入这句)
//    self.fd_prefersNavigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //尽量在后面加加入，不容易被子视图的view覆盖了
    if (_emptyView == nil) {
        self.emptyView = [[EmptyView alloc]initWithFrame:CGRectMake(0, self.view.top, kScreenWidth, kScreenHeight - kNavigationBarHeight)];
        [self.view addSubview:self.emptyView];
        self.emptyView.backgroundColor = [UIColor colorFromHexString:@"#181818"];
        self.emptyView.hidden = YES;///暂时隐藏。
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

/**
 *  导航栏左边按钮
 *
 *  @param name        按钮名称
 *  @param imageString 按钮图片
 *  @param block       返回导航栏左边按钮
 */
- (void)leftButtonWithName:(NSString *)name image:(NSString *)imageString block:(void(^)(UIButton *btn))block{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 100, 44)];
    // 左边按钮  左对齐
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    if (![imageString isEmptyString]) {
        [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateHighlighted];
    }
    
    [button setTitle:name forState:UIControlStateNormal];
    [button setTitle:name forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button.titleLabel sizeToFit];
    [button setFrame:CGRectMake(0, 0, button.titleLabel.width, 44)];
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;//值越大，越靠右
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftItem];
    /// block 回调方法。
    if (block == nil) {
        return;
    }
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *btn) {
        block(button);
    }];
}

/**
 *  导航栏右边按钮
 *
 *  @param name        按钮名称
 *  @param imageString 按钮图片
 *  @param block       返回导航栏右边按钮
 */
- (void)rightButtonWithName:(NSString *)name image:(NSString *)imageString block:(void(^)(UIButton *btn))block{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 100, 44)];
    // 右边按钮  右对齐
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    if (![imageString isEmptyString]) {
        [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateHighlighted];
    }
    
    [button setTitle:name forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button.titleLabel sizeToFit];
    [button setFrame:CGRectMake(0, 0, button.titleLabel.width, 44)];
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;// 值越大越靠左边
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
    
    /// block 回调方法。
    if (block == nil) {
        return;
    }
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *btn) {
        block(button);
    }];
}

/**
 *  下个页面的返回按钮的文字
 *
 *  @param title 按钮的文字（nil是返回，空格是没有）
 */
-(void)nextBackTitle:(NSString *)title{
    UIBarButtonItem *nextPageButtonItem = [[UIBarButtonItem alloc] init];
    nextPageButtonItem.title = title;
    [nextPageButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 0) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = nextPageButtonItem;
}

#pragma mark - 导航栏的字体颜色
-(void)navigationBarTitleColor{
    // 导航栏 左右 按钮的文字颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:17]};
    // 导航栏的颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kBase_Color_Navigation_Bg size:CGSizeMake(kScreenWidth, kNavigationBarHeight)] forBarMetrics:UIBarMetricsDefault];
}

@end
