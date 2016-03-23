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

#import "TextParagraph.h"
#import "NSString+IOSUtils.h"

#define TOP_VIEW_HEIGHT 35
#define kSpacing 20
#define kColorViewWidth 180

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
    /// 颜色的view
    UIView *colorView;
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
        view.placeHolderColor = [UIColor lightGrayColor];
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
            colorView.frame = CGRectMake(SCREEN_WIDTH - kColorViewWidth - 30, self.topview.top - 40, kColorViewWidth, 35);
            colorView.hidden = NO;
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
        
        colorView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - kColorViewWidth - 50, self.topview.top - 40, kColorViewWidth, 35)];
        colorView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:colorView];
        colorView.hidden = YES;
        for (int i = 0; i < 6; i++) {
            UIButton *colorBtn = [Tooles getButton:CGRectMake(10 + i*26, 6.5, 22, 22) title:nil titleColor:[UIColor clearColor] titleSize:12];
            colorBtn.layer.cornerRadius = 11;
            colorBtn.layer.masksToBounds = YES;
            switch (i) {
                case 0:
                {
                    colorBtn.backgroundColor = [UIColor redColor];
                }
                    break;
                case 1:
                {
                    colorBtn.backgroundColor = [UIColor greenColor];
                }
                    break;
                case 2:
                {
                    colorBtn.backgroundColor = [UIColor blueColor];
                }
                    break;
                case 3:
                {
                    colorBtn.backgroundColor = [UIColor redColor];
                }
                    break;
                case 4:
                {
                    colorBtn.backgroundColor = [UIColor whiteColor];
                }
                    break;
                case 5:
                {
                    colorBtn.backgroundColor = [UIColor blackColor];
                }
                    break;
                    
                default:
                    break;
            }
            colorBtn.tag = 100 + i;
            [colorView addSubview:colorBtn];
            [[colorBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                colorView.hidden = YES;
                
                switch (colorBtn.tag - 100) {
                    case 0:
                    {
                        colorBtn.backgroundColor = [UIColor redColor];
                    }
                        break;
                    case 1:
                    {
                        colorBtn.backgroundColor = [UIColor greenColor];
                    }
                        break;
                    case 2:
                    {
                        colorBtn.backgroundColor = [UIColor blueColor];
                    }
                        break;
                    case 3:
                    {
                        colorBtn.backgroundColor = [UIColor redColor];
                    }
                        break;
                    case 4:
                    {
                        colorBtn.backgroundColor = [UIColor whiteColor];
                    }
                        break;
                    case 5:
                    {
                        colorBtn.backgroundColor = [UIColor blackColor];
                    }
                        break;
                        
                    default:
                        break;
                }
                fontColor = colorBtn.backgroundColor;
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
                wSelf.fastTextView.attributeConfig=[TextConfig editorAttributeConfig:fontSize isBold:isBold color:fontColor];
            }];
        }
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

//- (NSString *)htmlStringWithAttachmentPath:(NSString *)attachpath ChapterAuthor:(NSString *)chapterAuthor
//{
//    NSString *storeString = @""; //[NSString stringWithCapacity:[self length]];
//    
//    NSAttributedString *newAttrStr=[self copy];
//    NSMutableDictionary *textParagraphMap=[[NSMutableDictionary alloc]init];
//    
//    TextParagraph *textParagraph;
//    //NSDictionary *longeffectiveAttributes;
//    NSRange longRange;
//    unsigned int longPos = 0;
//    while ((longPos < [newAttrStr length]) &&
//           (textParagraph = [newAttrStr attribute:FastTextParagraphAttributeName atIndex:longPos longestEffectiveRange:&longRange inRange:NSMakeRange(0, [newAttrStr length])])){
//        
//        NSLog(@"textParagraph %@",textParagraph);
//        [textParagraphMap setValue:NSStringFromRange(longRange) forKey:textParagraph.key];
//        
//        longPos = longRange.location + longRange.length;
//    }
//    
//    NSDictionary *effectiveAttributes;
//    NSRange range;
//    unsigned int pos = 0;
//    while ((pos < [newAttrStr length]) &&
//           (effectiveAttributes = [newAttrStr attributesAtIndex:pos effectiveRange:&range])) {
//        
//        NSString *plainString=[[newAttrStr attributedSubstringFromRange:range] string];
//        
//        //一下三个替换步骤不可错误！
//        //替换img的魔术占位符
//        unichar attachmentCharacter = FastTextAttachmentCharacter;
//        plainString=[plainString stringByReplacingOccurrencesOfString:[NSString stringWithCharacters:&attachmentCharacter length:1] withString:@""];
//        //编码html标签
//        plainString = [plainString stringByAddingHTMLEntities];
//        //替换\n为<br/>标签
//        plainString=[plainString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
//        
//        
//        NSRange paragraphRange = NSMakeRange(NSNotFound, NSNotFound) ;
//        TextParagraph *textParagraph=[effectiveAttributes objectForKey:FastTextParagraphAttributeName];
//        
//        if (textParagraph!=nil) {
//            NSString *rangstr= [textParagraphMap objectForKey:[NSString md5:[textParagraph description]]];
//            paragraphRange=NSRangeFromString(rangstr);
//        }
//        if (paragraphRange.location!=NSNotFound && paragraphRange.location==range.location) {
//            storeString=[storeString stringByAppendingString:@"<p>"];
//        }
//        
//        //附件处理
//        id<FastTextAttachmentCell> attachmentcell = [effectiveAttributes objectForKey:FastTextAttachmentAttributeName];
//        NSInteger ifile=1;
//        if (attachmentcell && [attachmentcell isKindOfClass:[SlideAttachmentCell class]])
//        {
//            SlideAttachmentCell *slideCell=(SlideAttachmentCell *)attachmentcell;
//            FileWrapperObject  *fileWrapper =slideCell.fileWrapperObject;
//            if (fileWrapper!=nil) {
//                NSString *filepath=fileWrapper.filePath;
//                UIImage *attimg= [UIImage imageWithContentsOfFile:filepath];
//                NSString *newPath=[attachpath stringByAppendingPathComponent:fileWrapper.fileName];
//                NSError *error;
//                [[NSFileManager defaultManager] copyItemAtPath:filepath toPath:newPath error:&error];
//                
//                ifile++;
//                
//                
//                if ([attachmentcell isKindOfClass:[SlideAttachmentCell class]]){
//                    SlideAttachmentCell *cell=(SlideAttachmentCell*) attachmentcell;
//                    NSInteger thumbImageWidth=cell.thumbImageWidth;
//                    NSInteger thumbImageHeight=cell.thumbImageHeight;
//                    /* WQ add this for UIWebView editor 一键排版
//                     NSInteger thumbImageWidth=DEFAULT_thumbImageWidth;
//                     NSInteger thumbImageHeight=DEFAULT_thumbImageHeight;
//                     if (attimg!=nil) {
//                     CGSize size=[attimg sizeByScalingProportionallyToSize:CGSizeMake(thumbImageWidth, thumbImageHeight)];
//                     thumbImageWidth=size.width;
//                     thumbImageHeight=size.height;
//                     }
//                     */
//                    
//                    storeString=[storeString stringByAppendingFormat:@"<img src=\"%@\" height=\"%ld\" width=\"%ld\"" ,fileWrapper.fileName,(long)thumbImageHeight,(long)thumbImageWidth];
//                    if (![NSString isEmptyString:cell.txtdesc]) {
//                        
//                        storeString=[storeString stringByAppendingFormat:@" title=\"%@\" ",cell.txtdesc];
//                    }
//                    
//                    storeString=[storeString stringByAppendingString:@"/>"];
//                }
//            }
//            
//        }else{
//            //文本
//            storeString=[storeString stringByAppendingFormat:@"%@", plainString];
//        }
//        if (paragraphRange.length!=NSNotFound
//            && (paragraphRange.location+paragraphRange.length)==(range.location+range.length)) {
//            storeString=[storeString stringByAppendingString:@"</p>"];
//        }
//        
//        pos = range.location + range.length;
//    }
//    //[storeString appendString:[self closeTags]];
////    NSString *chaptertitle=chapterAuthor.title;
////    if ([NSString isEmptyString:chaptertitle]) {
////        chaptertitle=@"";
////    }
//    storeString=[NSString stringWithFormat:@"<html><head><meta name=\"chapter:timestamp\" content=\"%d\" /><title>%@</title></head><body>%@</body></html>",0,@"",storeString];
//    return storeString;
//}

@end
