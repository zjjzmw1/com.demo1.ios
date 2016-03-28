//
//  STPhotoBrowserController.h
//  STPhotoBrowser
//
//  Created by https://github.com/STShenZhaoliang/STPhotoBrowser.git on 16/1/15.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STPhotoBrowserController;
@protocol STPhotoBrowserDelegate <NSObject>

- (UIImage *_Nonnull)photoBrowser:(STPhotoBrowserController *_Nullable)browser
          placeholderImageForIndex:(NSInteger)index;

- (NSURL *_Nullable)photoBrowser:(STPhotoBrowserController *_Nullable)browser
     highQualityImageURLForIndex:(NSInteger)index;

- (NSURL *_Nullable)photoBrowser:(STPhotoBrowserController *_Nullable)browser
     lowImageURLForIndex:(NSInteger)index;
@end

@interface STPhotoBrowserController : UIViewController
// 是否是push过来的
@property (assign, nonatomic) BOOL isPush;
/** 1.原图片的容器，即图片来源的父视图 */
@property ( nonatomic, weak, nullable)UIView *sourceImagesContainerView;
/// 返回的时候回的当前图片的位置的。。。。。
@property (weak, nonatomic,nullable) UITableView *topTable;
/** 2.当前的标签 */
@property (nonatomic, assign)NSInteger currentPage;
/** 3.图片的总数目 */
@property (nonatomic, assign)NSInteger countImage;

@property ( nonatomic, weak, nullable) id <STPhotoBrowserDelegate>delegate; //

- (void)show;
@end
