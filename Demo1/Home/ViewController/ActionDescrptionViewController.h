//
//  ActionDescrptionViewController.h
//  Demo1
//
//  Created by xiaoming on 16/3/9.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "BaseViewController.h"
#import "FastTextView.h"

@interface ActionDescrptionViewController : BaseViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIScrollViewDelegate>

/// 键盘上面的toolBar
@property (strong, nonatomic) UIView *topview;
/// 图文混排的textView
@property (strong, nonatomic) FastTextView *fastTextView;

@end
