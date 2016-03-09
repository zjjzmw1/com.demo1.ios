//
//  ActionDescriptionViewController.m
//  FastTextViewDemo
//
//  Created by xiaoming on 16/3/9.
//  Copyright © 2016年 wangqiang. All rights reserved.
//

#import "ActionDescrptionViewController.h"
#import "UIColor+IOSUtils.h"
#import "UIView+Utils.h"

#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreText/CoreText.h>
//#import "UIImage-Extensions.h"
#import "NSAttributedString+TextUtil.h"
#import "TextConfig.h"
#import "UIImage-Extensions.h"
#import "SlideAttachmentCell.h"

#define TOP_VIEW_HEIGHT 35
#define kSpacing 20

#define ARRSIZE(a)      (sizeof(a) / sizeof(a[0]))

@interface ActionDescrptionViewController()
{
    /// 字体大小
    float fontSize;
    /// 是否是粗体
    BOOL isBold;
    /// 字体颜色
    UIColor *fontColor;
    // 添加五个按钮：图片、粗体、大字、颜色 完成
    UIButton *imageButton;
    UIButton *boldButton;
    UIButton *bigButton;
    UIButton *colorButton;
    UIButton *downButton;
    
}

@end

@implementation ActionDescrptionViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"活动说明", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    fontSize = 16;
    isBold = NO;
    fontColor = [UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if (_fastTextView==nil) {
        
        FastTextView *view = [[FastTextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-0)];
        
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        view.delegate = (id<FastTextViewDelegate>)self;
        view.attributeConfig=[TextConfig editorAttributeConfig:fontSize isBold:isBold color:fontColor];
        view.delegate = (id<FastTextViewDelegate>)self;
        view.placeHolder=@"编辑活动说明，您最多可以添加3张图片";
        view.pragraghSpaceHeight=15;
        [self.view addSubview:view];
        self.fastTextView = view;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if (!self.topview) {
        // 初始化一个位置。
        self.topview = [[UIView alloc]init];
        self.topview.backgroundColor = [UIColor colorFromHexString:@"#FAFAFA"];
        self.topview.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.fastTextView.frame.size.width, TOP_VIEW_HEIGHT);
        [self.view addSubview:self.topview];
        ///添加五个按钮：图片、粗体、大字、颜色 完成
        imageButton = [Tooles getButton:CGRectMake(20, 5, 30, 25) title:nil titleColor:[UIColor clearColor] titleSize:15];
        [imageButton setBackgroundImage:[UIImage imageNamed:@"account_highlight"] forState:UIControlStateNormal];
        imageButton.tag = 10;
        __weak typeof(self) wSelf = self;
        [[imageButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            NSLog(@"imageTag===%ld",(long)imageButton.tag);
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = wSelf;
//            [wSelf presentModalViewController:picker animated:YES];
            [wSelf presentViewController:picker animated:YES completion:^{
                
            }];
        }];
        [self.topview addSubview:imageButton];
        // 粗体
        boldButton = [Tooles getButton:CGRectMake(imageButton.right + kSpacing, 5, 30, 25) title:nil titleColor:[UIColor clearColor] titleSize:15];
        [boldButton setBackgroundImage:[UIImage imageNamed:@"account_highlight"] forState:UIControlStateNormal];
        boldButton.tag = 11;
        [[boldButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            NSLog(@"boldButton===%ld",(long)boldButton.tag);
            if (_fastTextView.selectedRange.length>0) {
                CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:17].fontName, 17, NULL);
                [_fastTextView.attributedString beginStorageEditing];
                [_fastTextView.attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:_fastTextView.selectedRange];
                [_fastTextView.attributedString refreshParagraghInRange:_fastTextView.selectedRange];
                [_fastTextView.attributedString endStorageEditing];
                [_fastTextView refreshAllView];
            }
            if (isBold) {
                isBold = NO;
            }else{
                isBold = YES;
            }
            wSelf.fastTextView.attributeConfig=[TextConfig editorAttributeConfig:fontSize isBold:isBold color:fontColor];
        }];
        [self.topview addSubview:boldButton];
        // 大字
        bigButton = [Tooles getButton:CGRectMake(boldButton.right + kSpacing, 5, 30, 25) title:nil titleColor:[UIColor clearColor] titleSize:15];
        [bigButton setBackgroundImage:[UIImage imageNamed:@"account_highlight"] forState:UIControlStateNormal];
        bigButton.tag = 12;
        [[bigButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            NSLog(@"bigButton===%ld",(long)bigButton.tag);
            if (_fastTextView.selectedRange.length>0) {
                CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:17].fontName, 17, NULL);
                
                [_fastTextView.attributedString beginStorageEditing];
                [_fastTextView.attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:_fastTextView.selectedRange];
                [_fastTextView.attributedString refreshParagraghInRange:_fastTextView.selectedRange];
                [_fastTextView.attributedString endStorageEditing];
                [_fastTextView refreshAllView];
            }
            if (fontSize == 20) {
                fontSize = 16;
            }else{
                fontSize = 20;
            }
            wSelf.fastTextView.attributeConfig=[TextConfig editorAttributeConfig:fontSize isBold:isBold color:fontColor];
        }];
        [self.topview addSubview:bigButton];
        // 颜色
        colorButton = [Tooles getButton:CGRectMake(bigButton.right + kSpacing, 5, 30, 25) title:nil titleColor:[UIColor clearColor] titleSize:15];
        [colorButton setBackgroundImage:[UIImage imageNamed:@"account_highlight"] forState:UIControlStateNormal];
        colorButton.tag = 13;
        [[colorButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            NSLog(@"colorButton===%ld",(long)colorButton.tag);
            if (_fastTextView.selectedRange.length>0) {
                CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont systemFontOfSize:17].fontName, 17, NULL);
                [_fastTextView.attributedString beginStorageEditing];
                [_fastTextView.attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:_fastTextView.selectedRange];
                
                //下划线
                [_fastTextView.attributedString addAttribute:(id)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:kCTUnderlineStyleThick] range:_fastTextView.selectedRange];
                //下划线颜色
                [_fastTextView.attributedString addAttribute:(id)kCTUnderlineColorAttributeName value:(id)[UIColor redColor].CGColor range:_fastTextView.selectedRange];
                
                [_fastTextView.attributedString refreshParagraghInRange:_fastTextView.selectedRange];
                [_fastTextView.attributedString endStorageEditing];
                [_fastTextView refreshAllView];
            }
            
            fontColor = [UIColor redColor];
            
            wSelf.fastTextView.attributeConfig=[TextConfig editorAttributeConfig:fontSize isBold:isBold color:fontColor];
        }];
        [self.topview addSubview:colorButton];
        // 完成
        downButton = [Tooles getButton:CGRectMake(SCREEN_WIDTH - 80, 5, 60, 25) title:NSLocalizedString(@"完成", nil) titleColor:[UIColor redColor] titleSize:16];
        downButton.tag = 14;
        downButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        [[downButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            NSLog(@"downButton===%ld",(long)downButton.tag);
            [wSelf keyboardWillHide:nil];
            [wSelf dismissKeyBoard:nil];
        }];
        [self.topview addSubview:downButton];
    }
}

#pragma mark -
#pragma mark fastTextViewDelegate

- (BOOL)fastTextViewShouldBeginEditing:(FastTextView *)textView {
    return YES;
}

- (BOOL)fastTextViewShouldEndEditing:(FastTextView *)textView {
    return YES;
}

- (void)fastTextViewDidBeginEditing:(FastTextView *)textView {
    
    
}

- (void)fastTextViewDidEndEditing:(FastTextView *)textView {
    [_fastTextView refreshAllView];
    
    
}



- (void)fastTextViewDidChange:(FastTextView *)textView {
    
}

- (void)fastTextView:(FastTextView*)textView didSelectURL:(NSURL *)URL {
    
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)_addAttachmentFromAsset:(ALAsset *)asset;
{
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    NSMutableData *data = [NSMutableData dataWithLength:[rep size]];
    
    NSError *error = nil;
    if ([rep getBytes:[data mutableBytes] fromOffset:0 length:[rep size] error:&error] == 0) {
        NSLog(@"error getting asset data %@", [error debugDescription]);
    } else {
        //        NSFileWrapper *wrapper = [[NSFileWrapper alloc] initRegularFileWithContents:data];
        //        wrapper.filename = [[rep url] lastPathComponent];
        UIImage *img=[UIImage imageWithData:data];
        
        NSString *newfilename=[NSAttributedString scanAttachmentsForNewFileName:_fastTextView.attributedString];
        
        
        
        NSArray *_paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * _documentDirectory = [[NSString alloc] initWithString:[_paths objectAtIndex:0]];
        
        
        UIImage *thumbimg=[img imageByScalingProportionallyToSize:CGSizeMake(1024,6000)];
        
        NSString *pngPath=[_documentDirectory stringByAppendingPathComponent:newfilename];
        
        //[[AppDelegate documentDirectory] stringByAppendingPathComponent:@"tmp.jpg"];
        
        
        [UIImageJPEGRepresentation(thumbimg,0.7)writeToFile:pngPath atomically:YES];
        
        UITextRange *selectedTextRange = [_fastTextView selectedTextRange];
        if (!selectedTextRange) {
            UITextPosition *endOfDocument = [_fastTextView endOfDocument];
            selectedTextRange = [_fastTextView textRangeFromPosition:endOfDocument toPosition:endOfDocument];
        }
        UITextPosition *startPosition = [selectedTextRange start] ; // hold onto this since the edit will drop
        
        unichar attachmentCharacter = FastTextAttachmentCharacter;
        [_fastTextView replaceRange:selectedTextRange withText:[NSString stringWithFormat:@"\n%@\n",[NSString stringWithCharacters:&attachmentCharacter length:1]]];
        
        startPosition=[_fastTextView positionFromPosition:startPosition inDirection:UITextLayoutDirectionRight offset:1];
        UITextPosition *endPosition = [_fastTextView positionFromPosition:startPosition offset:1];
        selectedTextRange = [_fastTextView textRangeFromPosition:startPosition toPosition:endPosition];
        
        
        NSMutableAttributedString *mutableAttributedString=[_fastTextView.attributedString mutableCopy];
        
        NSUInteger st = ((FastIndexedPosition *)(selectedTextRange.start)).index;
        NSUInteger en = ((FastIndexedPosition *)(selectedTextRange.end)).index;
        
        if (en < st) {
            return;
        }
        NSUInteger contentLength = [[_fastTextView.attributedString string] length];
        if (en > contentLength) {
            en = contentLength; // but let's not crash
        }
        if (st > en)
            st = en;
        NSRange cr = [[_fastTextView.attributedString string] rangeOfComposedCharacterSequencesForRange:(NSRange){ st, en - st }];
        if (cr.location + cr.length > contentLength) {
            cr.length = ( contentLength - cr.location ); // but let's not crash
        }
        
        FileWrapperObject *fileWp = [[FileWrapperObject alloc] init];
        [fileWp setFileName:newfilename];
        [fileWp setFilePath:pngPath];
        
        SlideAttachmentCell *cell = [[SlideAttachmentCell alloc] initWithFileWrapperObject:fileWp] ;
        //ImageAttachmentCell *cell = [[ImageAttachmentCell alloc] init];
        cell.isNeedThumb=TRUE;
        cell.thumbImageWidth=200.0f;
        cell.thumbImageHeight=200.0f;
        cell.txtdesc=@"幻灯片测试";
        
        [mutableAttributedString addAttribute: FastTextAttachmentAttributeName value:cell  range:cr];
         _fastTextView.attributedString = mutableAttributedString;

        
        //        SlideAttachmentCell *cell = [[SlideAttachmentCell alloc] initWithFileWrapperObject:fileWp] ;
        //        //ImageAttachmentCell *cell = [[ImageAttachmentCell alloc] init];
        //        cell.isNeedThumb=TRUE;
        //        cell.thumbImageWidth=200.0f;
        //        cell.thumbImageHeight=200.0f;
        //        cell.txtdesc=@"幻灯片测试";
        
        //        [mutableAttributedString addAttribute: FastTextAttachmentAttributeName value:cell  range:cr];
        
        //[mutableAttributedString addAttribute:fastTextAttachmentAttributeName value:cell  range:selectedTextRange];
        
        
        //        if (mutableAttributedString) {
        //            _fastTextView.attributedString = mutableAttributedString;
        //        }
        
        //[_editor setValue:attachment forAttribute:OAAttachmentAttributeName inRange:selectedTextRange];
        
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init] ;
    [library assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
             resultBlock:^(ALAsset *asset){
                 // This get called asynchronously (possibly after a permissions question to the user).
                 [self _addAttachmentFromAsset:asset];
             }
            failureBlock:^(NSError *error){
                NSLog(@"error finding asset %@", [error debugDescription]);
            }];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark Removing toolbar

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGSize keyBoardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    self.fastTextView.frame = CGRectMake(self.fastTextView.frame.origin.x, 0, self.fastTextView.frame.size.width,self.view.bounds.size.height -0 - keyBoardSize.height-TOP_VIEW_HEIGHT );
    
    self.topview.frame = CGRectMake(0, self.fastTextView.frame.origin.y+ self.fastTextView.frame.size.height, self.fastTextView.frame.size.width, TOP_VIEW_HEIGHT);
    
    [self.view bringSubviewToFront:self.topview];
    
}

- (void)keyboardWillHide:(NSNotification *)notification{
    self.fastTextView.frame = CGRectMake(self.fastTextView.frame.origin.x, 0, self.fastTextView.frame.size.width, self.view.bounds.size.height-0);
    
    self.topview.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.fastTextView.frame.size.width, TOP_VIEW_HEIGHT);
    
}

-(IBAction)dismissKeyBoard:(id)sender {
    [_fastTextView resignFirstResponder];
}


@end
