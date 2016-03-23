//
//  NSAttributedString+TextUtil.m
//  tangyuanReader
//
//  Created by 王 强 on 13-6-8.
//  Copyright (c) 2013年 中文在线. All rights reserved.
//

#import "NSAttributedString+TextUtil.h"
//#import "NSString+TextUtil.h"
#import "TextParagraph.h"
//#import "ImageAttachmentCell.h"
//#import "SlideAttachmentCell.h"
//#import "UIImage-Extensions.h"
#import "NSMutableAttributedString+TextUtil.h"
#import "FileWrapperObject.h"
#import "FastTextView.h"
#import "NSCharacterSet+EmojiAdditions.h"
// MARK: Text attachment helper functions

#define ZERO_WIDTH_SPACE @"\u200B"
#define CHINESE_SPACE @"　"
// MARK: Text attachment helper functions
static void AttachmentRunDelegateDealloc(void *refCon) {
    CFBridgingRelease(refCon);
}

static CGSize AttachmentRunDelegateGetSize(void *refCon) {
    id <FastTextAttachmentCell> cell = (__bridge  id<FastTextAttachmentCell>)(refCon);
    if ([cell respondsToSelector: @selector(attachmentSize)]) {
        return [cell attachmentSize];
    } else {
        return [[cell attachmentView] frame].size;
    }
}

static CGFloat AttachmentRunDelegateGetDescent(void *refCon) {
    return AttachmentRunDelegateGetSize(refCon).height;
}

static CGFloat AttachmentRunDelegateGetWidth(void *refCon) {
    return AttachmentRunDelegateGetSize(refCon).width;
}


@implementation NSAttributedString (TextUtil)


-(NSString *)getUnixTimestamp:(NSDate *)curdate{
    
    //NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[curdate timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}


-(NSInteger)getRandFromOnetoX:(NSInteger)x{
    return  (arc4random() % x) + 1;
}

+ (NSAttributedString *)fromHtmlString:(NSString *)htmlstr withAttachmentPath:(NSString *)attachpath
{
//        OpenEditMarkupParser *markupParser=[[OpenEditMarkupParser alloc]init];
//        NSAttributedString *retstr=[markupParser attrStringFromMarkup:htmlstr withAttachmentPath:attachpath];
//        return retstr;
    return nil;
}

//- (NSString *)htmlStringWithAttachmentPath:(NSString *)attachpath ChapterAuthor:(ChapterAuthor *)chapterAuthor
//{
//    NSString *storeString = @"";
//    
//    NSAttributedString *newAttrStr=[self copy];
//    NSMutableDictionary *textParagraphMap=[[NSMutableDictionary alloc]init];
//    
//    TextParagraph *textParagraph;
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
//                
//                NSString *filepath=fileWrapper.filePath;
//                
//                
//                UIImage *attimg= [UIImage imageWithContentsOfFile:filepath];
//                NSString *newPath=[attachpath stringByAppendingPathComponent:fileWrapper.fileName];
//                NSError *error;
//                [[NSFileManager defaultManager] copyItemAtPath:filepath toPath:newPath error:&error];
//                
//                ifile++;
//                
//                if ([attachmentcell isKindOfClass:[SlideAttachmentCell class]]){
//                    SlideAttachmentCell *cell=(SlideAttachmentCell*) attachmentcell;
//                    NSInteger thumbImageWidth=DEFAULT_thumbImageWidth;
//                    NSInteger thumbImageHeight=DEFAULT_thumbImageHeight;
//                    if (attimg!=nil) {
//                        CGSize size=[attimg sizeByScalingProportionallyToSize:CGSizeMake(thumbImageWidth, thumbImageHeight)];
//                        thumbImageWidth=size.width;
//                        thumbImageHeight=size.height;
//                    }
//                    
//                    storeString=[storeString stringByAppendingFormat:@"<img src=\"%@\" height=\"%d\" width=\"%d\"" ,fileWrapper.fileName,thumbImageHeight,thumbImageWidth];
//                    if (![NSString isEmptyOrNull:cell.txtdesc]) {
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
//    NSString *chaptertitle=chapterAuthor.title;
//    if ([NSString isEmptyOrNull:chaptertitle]) {
//        chaptertitle=@"";
//    }
//    storeString=[NSString stringWithFormat:@"<html><head><meta name=\"chapter:timestamp\" content=\"%d\" /><title>%@</title></head><body>%@</body></html>",chapterAuthor.timestamp,chaptertitle,storeString];
//    return storeString;
//}





-(void)printDesc{
    [self enumerateAttributesInRange:NSMakeRange(0, [self length]) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop){
        NSLog(@"beigin ------ %@ ",NSStringFromRange(range));
        
        NSAttributedString *tmpstr=[self attributedSubstringFromRange:range];
        
        NSLog(@" tmpstr.string %@ ",tmpstr.string);
        NSLog(@"  %@ ",attrs);
        NSLog(@">>>>end ------ %@ ",NSStringFromRange(range));
    }];
    NSLog(@">>>>>%@ ",@"finished");
    
}

+(NSMutableAttributedString *)scanAttachments:(NSMutableAttributedString *)_attributedString {
    
    NSMutableArray *temArray = [_attributedString scanAttachments];
    [temArray removeAllObjects];
    temArray = nil;
    return _attributedString;
    
////    __block NSMutableAttributedString *mutableAttributedString = [_attributedString mutableCopy];
//    
//    [_attributedString enumerateAttribute: FastTextAttachmentAttributeName inRange: NSMakeRange(0, [_attributedString length]) options: 0 usingBlock: ^(id value, NSRange range, BOOL *stop) {
//        // we only care when an attachment is set
//        if (value != nil) {
//            // create the mutable version of the string if it's not already there
//            //            if (mutableAttributedString == nil)
//            //                mutableAttributedString = [_attributedString mutableCopy];
//            
//            CTRunDelegateCallbacks callbacks = {
//                .version = kCTRunDelegateVersion1,
//                .dealloc = AttachmentRunDelegateDealloc,
//                .getAscent = AttachmentRunDelegateGetDescent,
//                //.getDescent = AttachmentRunDelegateGetDescent,
//                .getWidth = AttachmentRunDelegateGetWidth
//            };
//            
//            // the retain here is balanced by the release in the Dealloc function
//            
//            CTRunDelegateRef runDelegate = CTRunDelegateCreate(&callbacks, (__bridge void *)((__bridge id)CFBridgingRetain(value)));
//            
//            id<FastTextAttachmentCell> cell=(id<FastTextAttachmentCell>)value;
//            [cell setRange:range];
//            
//            [_attributedString addAttribute: (NSString *)kCTRunDelegateAttributeName value: (__bridge id)runDelegate range:range];
//            
//            CFRelease(runDelegate);
//        }
//    }];
//    
//    return _attributedString;

}


+(NSString *)scanAttachmentsForNewFileName:(NSAttributedString *)_attributedString {
    __block NSString *newFilename=@"a1.jpg";
    __block int maxfileid=1;
    
    [_attributedString enumerateAttribute: FastTextAttachmentAttributeName inRange: NSMakeRange(0, [_attributedString length]) options: 0 usingBlock: ^(id value, NSRange range, BOOL *stop) {
        if (value != nil) {         
            
            id<FastTextAttachmentCell> cell=(id<FastTextAttachmentCell>)value;
        
            NSString *filename=[cell.fileWrapperObject.fileName lowercaseString];
            if (filename!=nil && [[filename substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"a"]) {
                int nowfileid= [self getObjectIntValue:[[filename stringByDeletingPathExtension] substringFromIndex:1]]+1;
                if (nowfileid>maxfileid) {
                    maxfileid=nowfileid;
                }                
            }           
        }
    }];
    
    newFilename=[NSString stringWithFormat:@"a%d.jpg",maxfileid];    
    
    return newFilename;
    
}

+(NSInteger)getObjectIntValue:(id)obj{
    
    NSNumber *_intvalue= (NSNumber *)obj;
    
    if (_intvalue!=nil && _intvalue!=(NSNumber *)[NSNull null]){
        return _intvalue.intValue;
    } else {
        return 0;
    }
    
}



+ (NSMutableAttributedString *)stripStyle:(NSAttributedString *) attrstring{
    //只保留附件属性
    
    __block NSMutableAttributedString *mutableAttributedString =[[NSMutableAttributedString alloc]initWithString: [attrstring string]];
    
    
    [attrstring enumerateAttribute: FastTextAttachmentAttributeName inRange: NSMakeRange(0, [attrstring length]) options: 0 usingBlock: ^(id value, NSRange range, BOOL *stop) {
        if (value != nil) {
            
            id<FastTextAttachmentCell> cell=(id<FastTextAttachmentCell>)value;
            
           [mutableAttributedString addAttribute: FastTextAttachmentAttributeName value:cell range:range];
        }
    }];

    
    
    if (mutableAttributedString) {
        return mutableAttributedString;
    }
    return nil;
}


//////

- (CGFloat)boundingHeightForWidth:(CGFloat)width {
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFMutableAttributedStringRef) self);
    CGRect box = CGRectMake(0,0, width, CGFLOAT_MAX);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, box);
    
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(width, CGFLOAT_MAX), NULL);
    CFRelease(framesetter);
    CFRelease(path);
    return suggestedSize.height;
    
}

- (NSAttributedString *)stringByAddingZeroWidthSpacesAfterEmojiCharacters {
	__block NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc] init];
    
	[self.string enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
		//[string appendString:substring];
        
		if (substringRange.length == 2) {
			unichar hs = [substring characterAtIndex:0];
			unichar ls = [substring characterAtIndex:1];
			UTF32Char uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
			if ([[NSCharacterSet emojiCharacterSet] longCharacterIsMember:uc]) {
                NSLog(@"[self.string substringWithRange:NSMakeRange(substringRange.location-1, 1)] [%@]",[self.string substringWithRange:NSMakeRange(substringRange.location-1, 1)]);
                if (substringRange.location >0 && [[self.string substringWithRange:NSMakeRange(substringRange.location-1, 1)] isEqualToString:CHINESE_SPACE]) {
                    [attstring appendAttributedString:[[NSAttributedString alloc]initWithString:ZERO_WIDTH_SPACE]];
                }
                [attstring appendAttributedString:[self attributedSubstringFromRange:substringRange]];
                //                if (substringRange.location+substringRange.length <self.length && ![[self.string substringWithRange:NSMakeRange(substringRange.location+substringRange.length, 1)] isEqualToString:ZERO_WIDTH_SPACE]) {
                //                    [attstring appendAttributedString:[[NSAttributedString alloc]initWithString:ZERO_WIDTH_SPACE]];
                //                }
                
			}else{
                [attstring appendAttributedString:[self attributedSubstringFromRange:substringRange]];
            }
		}else{
            [attstring appendAttributedString:[self attributedSubstringFromRange:substringRange]];
        }
	}];
	return [attstring copy];
}

@end
