//
//  Tooles.h
//  Vodka
//
//  Created by 小明 on 15-12-26.
//  Copyright (c) 2014年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>         //各种方便的block封装

@interface Tooles : NSObject

///----------RAC用的-----------------------
@property (assign, nonatomic) NSInteger     count;
@property (strong, nonatomic) RACSignal     *createEnabled;
@property (strong, nonatomic) NSString      *password;
@property (strong, nonatomic) NSString      *passwordConfirm;
@property (strong, nonatomic) UIButton      *button;
@property (strong, nonatomic) UITextField   *textField;
///-----------上面是RAC用的----------------------------
/**
 *  用法：
 
 //获取本地缓存。----一定要先初始化
 NSMutableArray *localArray = [NSMutableArray array];
 [Tooles getFileFromLoc:@"albumHomeArray" into:localArray];

 //本地缓存30张相片。
 [Tooles saveFileToLoc:@"albumHomeArray" theFile:resultArray];//保存本地接口数据。
 //获取NSData数据.-----一定要先初始化
 NSData *imageData  = [NSData data];
 imageData = [Tooles getDataFileFromLoc:@"kAlbumImageDataArray" into:imageData];
 ///删除本地文件
 [Tooles removeLoc:@"kAlbumImageDataArray"];

 */

/**
 *  下面两个方法可以存储自定义的对象---TMCache就不行。
 *
 *  @param fileName 保存的文件的名字
 *  @param file     保存的数组或字典或NSData
 *
 *  @return 是否成功
 */
+(BOOL)saveFileToLoc:(NSString *) fileName theFile:(id) file;

/**
 *  下面两个方法可以获取存储自定义的对象---TMCache就不行。
 *
 *  @param fileName 保存的文件的名字
 *  @param file     保存的数组或字典或NSData
 *
 *  @return 是否成功
 */
+(BOOL) getFileFromLoc:(NSString*)filePath into:(id)dic;

/**
 *  获取本地的NSData数据。
 *
 *  @param fileName 保存的文件的名字
 *  @param file     保存的NSData
 *
 *  @return NSData
 */
+(NSData *) getDataFileFromLoc:(NSString*)filePath into:(id)file;

/**
 *  删除本地保存的文件
 *
 *  @param fileName 文件名字
 *
 *  @return 成功与否
 */
+(BOOL)removeLoc:(NSString *)fileName;

/**
 *  获取UILabel 、UIButton 、UIImageView的类方法汇总
 *
 *  @param frame     控件大小
 *  @param fontSize  字体大小
 *  @param alignment 对齐方式
 *  @param textColor 字体颜色
 *
 *  @return UILabel/UIButton/UIImageView
 */
+(UILabel *)getLabel:(CGRect)frame fontSize:(float)fontSize alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor;
+(UIButton *)getButton:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(float)titleSize;
+(UIImageView *)getImageView:(CGRect)frame cornerRadius:(float)cornerRadius;



///点击textField的时候，上下移动View的通用方法
+(void)animateTextField: (UITextField *)textField up: (BOOL)up viewController:(UIViewController *)tempVC;

@end
