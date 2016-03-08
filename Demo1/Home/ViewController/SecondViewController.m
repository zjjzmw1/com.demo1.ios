//
//  SecondViewController.m
//  Demo1
//
//  Created by xiaoming on 16/2/26.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"
#import "Tooles.h"
#import "UIImage+IOSUtils.h"
#import "ListViewController.h"


@interface SecondViewController ()<UIScrollViewDelegate>
{
    UIScrollView *scrollV;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二页";
    self.navigationItem.title = @"第二页";

    self.view.backgroundColor = [UIColor lightGrayColor];

    UIButton *button = [Tooles getButton:CGRectMake(100, 200, 60, 50) title:@"push" titleColor:[UIColor redColor] titleSize:16];
    [self.view addSubview:button];
//    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//        SecondViewController *detailVC = [[SecondViewController alloc]init];
//        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:detailVC];
//        [self presentViewController:navi animated:YES completion:^{
//            
//        }];
//    }];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        ListViewController *detailVC = [[ListViewController alloc]init];
        [self.navigationController pushViewController:detailVC animated:YES];
    }];
    
//    scrollV = [[UIScrollView alloc]initWithFrame:self.view.frame];
//    scrollV.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:scrollV];
//    scrollV.delegate = self;
//    scrollV.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    
    UILabel *testLabel = [Tooles getLabel:CGRectMake(0, 0, 60, 80) fontSize:18 alignment:NSTextAlignmentLeft textColor:[UIColor blueColor]];
    [self.view addSubview:testLabel];
    testLabel.text = @"test";
    testLabel.backgroundColor = [UIColor yellowColor];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//
//{
//    
////    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:scrollV.contentOffset.y / 100]] forBarMetrics:UIBarMetricsDefault];
//    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:scrollV.contentOffset.y / 100] size:CGSizeMake(SCREEN_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
//    
//}

@end
