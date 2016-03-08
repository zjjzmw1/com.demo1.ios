//
//  LoginCell.h
//  Demo1
//
//  Created by xiaoming on 16/2/22.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "BaseCell.h"

@interface HomeCell : BaseCell

#pragma mark - 初始化的cell.
+ (id)homeCellWithReuseIdentifier:(NSString *)reuseIdentifier andType:(NSString *)type;

#pragma mark - 自定义的cell赋值方法.
- (void)drawCellWithData:(NSDictionary *)dict row:(NSInteger)row count:(NSInteger)count;

@end
