//
//  ShowBigImageBrowerViewController.m
//  Demo1
//
//  Created by xiaoming on 16/3/28.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "ShowBigImageBrowerViewController.h"
#import "STPhotoBrowserController.h"
#import "STConfig.h"
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>

@interface ShowBigImageBrowerViewController ()<UITableViewDataSource, UITableViewDelegate, STPhotoBrowserDelegate>
@property (nonatomic, strong, nullable)UITableView *tableView; //

@property (nonatomic, strong, nullable)UIView *currentView; //
//@property (nonatomic, strong, nullable)NSArray *currentArray; //
/// 图片url数组
@property (strong, nonatomic) NSArray *urlArray;
@end

@implementation ShowBigImageBrowerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.urlArray = [NSArray arrayWithObjects:@"http://img5.duitang.com/uploads/item/201406/11/20140611041659_jjNvG.thumb.700_0.jpeg",@"http://img2.mtime.com/mg/2009/36/2998bcfa-95b7-42a0-b353-5d2997b12ef2.jpg",@"http://www.qqpk.cn/Article/UploadFiles/201201/20120109144324964.jpg",@"http://img4.duitang.com/uploads/item/201409/13/20140913140903_xKGFa.thumb.700_0.jpeg",@"http://img.61gequ.com/allimg/2011-4/201142614314278502.jpg",@"http://img5.duitang.com/uploads/item/201406/11/20140611041659_jjNvG.thumb.700_0.jpeg",@"http://img2.mtime.com/mg/2009/36/2998bcfa-95b7-42a0-b353-5d2997b12ef2.jpg",@"http://www.qqpk.cn/Article/UploadFiles/201201/20120109144324964.jpg",@"http://img4.duitang.com/uploads/item/201409/13/20140913140903_xKGFa.thumb.700_0.jpeg",@"http://img.61gequ.com/allimg/2011-4/201142614314278502.jpg", nil];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    
    
}
#pragma mark - --- delegate 视图委托 ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.urlArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageV.backgroundColor = [UIColor redColor];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.urlArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"1"]];
    
//    [cell.contentView addSubview:imageV];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //启动图片浏览器
    STPhotoBrowserController *browserVc = [[STPhotoBrowserController alloc] init];
    self.currentView = cell.contentView;
    browserVc.sourceImagesContainerView = cell.contentView; // 原图的父控件
    browserVc.topTable = tableView;// 返回的时候回到当前图片的位置的属性。
    
    browserVc.countImage = self.urlArray.count; // 图片总数
    browserVc.currentPage = indexPath.row;
    browserVc.delegate = self;
    // 放大的效果展示的。
    [browserVc show];
    // 普通的push
//    browserVc.isPush = YES;
//    [self.navigationController pushViewController:browserVc animated:YES];
    
}

#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(STPhotoBrowserController *)browser placeholderImageForIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    return cell.imageView.image;
}

- (NSURL *)photoBrowser:(STPhotoBrowserController *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = self.urlArray[index];
    return [NSURL URLWithString:urlStr];
}

- (NSURL *_Nullable)photoBrowser:(STPhotoBrowserController *_Nullable)browser
     lowImageURLForIndex:(NSInteger)index {
    NSString *urlStr = self.urlArray[index];
    return [NSURL URLWithString:urlStr];
}

@end
