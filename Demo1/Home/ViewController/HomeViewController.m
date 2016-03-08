//
//  HomeViewController.m
//  Demo1
//
//  Created by xiaoming on 16/2/26.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "HomeViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

#import "AudioStreamer.h"           // 音乐播放框架

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    __weak typeof(self) wSelf = self;
    [self leftButtonWithName:@"左边" image:nil block:^(UIButton *btn) {
        FirstViewController *detailVC = [[FirstViewController alloc]init];
        [wSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    
    [self rightButtonWithName:@"右边" image:nil block:^(UIButton *btn) {
        SecondViewController *detailVC = [[SecondViewController alloc]init];
        [wSelf.navigationController pushViewController:detailVC animated:YES];
    }];

    
    UIButton *audioButton = [Tooles getButton:CGRectMake(100, 100, 60, 40) title:@"播放音乐" titleColor:[UIColor redColor] titleSize:18];
    [self.view addSubview:audioButton];

    [[audioButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [wSelf playAction];
    }];
    
}

-(void)playAction{
    NSString *urlString = @"http://77g1mw.com1.z0.glb.clouddn.com/%E7%99%BD%E9%AA%A8%E7%B2%BE%E5%86%99%E7%BB%99%E5%AD%99%E6%82%9F%E7%A9%BA%E7%9A%84%E4%BF%A1.mp3";
    NSString *urlString2 = @"http://77g1mw.com1.z0.glb.clouddn.com/%E8%BF%AA%E5%85%8B%E7%89%9B%E4%BB%94%20-%20%E6%94%BE%E6%89%8B%E5%8E%BB%E7%88%B1(%E8%90%BD%E5%9C%B0%E8%AF%B7%E5%BC%80%E6%89%8B%E6%9C%BA%E6%8F%92%E6%9B%B2).mp3";
    NSString *urlString3 = @"http://77g1mw.com1.z0.glb.clouddn.com/%E9%99%88%E5%A5%95%E8%BF%85%E3%80%81%E7%8E%8B%E8%8F%B2%20-%20%E5%9B%A0%E4%B8%BA%E7%88%B1%E6%83%85.mp3";
    NSString *urlString4 = @"http://77g1mw.com1.z0.glb.clouddn.com/%E9%9F%A9%E7%BA%A2%20-%20%E4%BC%97%E9%87%8C%E5%AF%BB%E4%BD%A0(live%E7%89%88).mp3";
    
    AudioStreamer *audioStreamer = [[AudioStreamer alloc]initWithURL:[NSURL URLWithString:urlString]];
    [audioStreamer start];
    
    
    
}

@end
