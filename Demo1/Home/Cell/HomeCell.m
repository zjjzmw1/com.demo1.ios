//
//  LoginCell.m
//  Demo1
//
//  Created by xiaoming on 16/2/22.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andType:(NSString *)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryNone;// 右箭头
    }
    return self;
}


#pragma mark - 初始化的cell.
+ (id)homeCellWithReuseIdentifier:(NSString *)reuseIdentifier andType:(NSString *)type {
    return [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier andType:type];
}

#pragma mark - 自定义的cell赋值方法.
- (void)drawCellWithData:(NSDictionary *)dict row:(NSInteger)row count:(NSInteger)count {
    
}





@end
