//
//  ImageSelectViewController.m
//  Demo1
//
//  Created by xiaoming on 16/3/23.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "ImageSelectViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "STPhotoKitController.h"
#import "UIImagePickerController+ST.h"
#import "STConfig.h"
#import "UIView+Utils.h"

typedef NS_ENUM(NSInteger, PhotoType)
{
    PhotoTypeIcon,          // 正方形
    PhotoTypeRectangle,     // 长方形
    PhotoTypeRectangle1
};

@interface ImageSelectViewController()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, STPhotoKitDelegate>

@property (nonatomic, assign) PhotoType type;

@property (strong, nonatomic) UIImageView *imageRectangle;

@end

@implementation ImageSelectViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    __weak typeof(self) wSelf = self;
    self.imageRectangle = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 160, 100)];
    self.imageRectangle.backgroundColor = [UIColor redColor];
    self.imageRectangle.userInteractionEnabled = YES;
    [self.view addSubview:self.imageRectangle];
    [self.imageRectangle setTapActionWithBlock:^{
        wSelf.type = PhotoTypeRectangle;
        [wSelf editImageSelected];
    }];
    
}

#pragma mark - --- delegate 视图委托 ---

#pragma mark - 1.STPhotoKitDelegate的委托

- (void)photoKitController:(STPhotoKitController *)photoKitController resultImage:(UIImage *)resultImage
{
    switch (self.type) {
        case PhotoTypeIcon:
//            self.imageIcon.image = resultImage;
            break;
        case PhotoTypeRectangle:
            self.imageRectangle.image = resultImage;
            break;
        case PhotoTypeRectangle1:
//            self.imageRectangle1.image = resultImage;
            self.imageRectangle.image = resultImage;

            break;
        default:
            break;
    }
}

#pragma mark - 2.UIImagePickerController的委托

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
        STPhotoKitController *photoVC = [STPhotoKitController new];
        [photoVC setDelegate:self];
        [photoVC setImageOriginal:imageOriginal];
        switch (self.type) {
            case PhotoTypeIcon:
//                [photoVC setSizeClip:CGSizeMake(self.imageIcon.width*2, self.imageIcon.height*2)];
                break;
            case PhotoTypeRectangle:
                [photoVC setSizeClip:CGSizeMake(SCREEN_WIDTH, 200)];
                break;
            case PhotoTypeRectangle1:
//                [photoVC setSizeClip:CGSizeMake(self.imageRectangle1.width*2, self.imageRectangle1.height*2)];
                [photoVC setSizeClip:CGSizeMake(self.imageRectangle.width*2, self.imageRectangle.height*2)];

                break;
            default:
                break;
        }
        
        
        [self presentViewController:photoVC animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - --- event response 事件相应 ---
- (void)editImageSelected
{
    UIAlertController *alertController = [[UIAlertController alloc]init];
    
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:NSLocalizedString(@"拍照", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        
        if ([controller isAvailableCamera] && [controller isSupportTakingPhotos]) {
            [controller setDelegate:self];
            [self presentViewController:controller animated:YES completion:nil];
        }else {
            NSLog(@"%s %@", __FUNCTION__, @"相机权限受限");
        }
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [controller setDelegate:self];
        if ([controller isAvailablePhotoLibrary]) {
            [self presentViewController:controller animated:YES completion:nil];
        }    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:action0];
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
