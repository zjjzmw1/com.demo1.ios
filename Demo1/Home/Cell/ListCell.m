//
//  ListCell.m
//  Demo1
//
//  Created by xiaoming on 16/3/1.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "ListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+RoundedCorner.h"
#import "UIImage+RoundedCorner.h"
@interface ListCell()

/// 头像
@property (strong, nonatomic) UIImageView *headerImageV;

@end

@implementation ListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andType:(NSString *)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        for (int i = 0; i < 10; i++) {
           _headerImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0 + i*30, 0, 30, 30)];
            _headerImageV.layer.cornerRadius = 15;
            [self.contentView addSubview:_headerImageV];
            
//            _headerImageV.layer.masksToBounds = YES;///加上这句，基本维持在 8 。  去掉这句维持在 55以上。瞬间正常了。。。
            // 下面这个方法基本也能维持在 55 以上。不错的图片圆角。
//            UIImage *image = [UIImage imageNamed:@"1"];
//            UIImage *lastImage = [image jm_imageWithRoundedCornersAndSize:CGSizeMake(10, 10) andCornerRadius:5];
//            _headerImageV.image = lastImage;
            
            // 获取网络的图片。
            // 需要在网络图片框架里面加入 变圆角的方法。
            [_headerImageV sd_setImageWithURL:[NSURL URLWithString:@"http://img2.3lian.com/2014/f3/41/d/1.jpg"] placeholderImage:[UIImage imageNamed:@"1"] rounderCorner:15];
            
        }
        self.accessoryType = UITableViewCellAccessoryNone;// 右箭头
    }
    return self;
}

#pragma mark - 初始化的cell.
+ (id)homeCellWithReuseIdentifier:(NSString *)reuseIdentifier andType:(NSString *)type {
    return [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier andType:type];
}

#pragma mark - 自定义的cell赋值方法.
- (void)drawCellWithData:(NSDictionary *)dict row:(NSInteger)row count:(NSInteger)count {
//    [_headerImageV sd_setImageWithURL:[NSURL URLWithString:@"http://img4.imgtn.bdimg.com/it/u=1087979692,2326947228&fm=21&gp=0.jpg"]];

   
}



@end
