//
//  Tooles.m
//  Vodka
//
//  Created by 小明 on 15-12-26.
//  Copyright (c) 2014年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "Tooles.h"
#import "UIColor+IOSUtils.h"
#import "NSString+IOSUtils.h"

#define SYSTEM_LIBIARY_PATH      NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0]

@implementation Tooles

#pragma mark - 下面两个方法可以存储自定义的对象---TMCache就不行。
+(BOOL)saveFileToLoc:(NSString *) fileName theFile:(id) file{
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *CachePath = [fileName stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    NSString *filename=[Path stringByAppendingPathComponent:CachePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filename]) {
        if (! [fileManager createFileAtPath:filename contents:nil attributes:nil]) {
            NSLog(@"createFile error occurred");
        }
    }
    return  [file writeToFile:filename atomically:YES];
}

+(BOOL) getFileFromLoc:(NSString*)filePath into:(id)file {
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *CachePath = [filePath stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    NSString *filename=[Path stringByAppendingPathComponent:CachePath];
    
    if ([file isKindOfClass:[NSMutableDictionary class]]) {
        [file setDictionary: [NSMutableDictionary dictionaryWithContentsOfFile:filename]];
        if ([file count]==0) {
            return NO;
        }
    }else if ([file isKindOfClass:[NSMutableArray class]]) {
        [file addObjectsFromArray: [NSMutableArray arrayWithContentsOfFile:filename]];
        if ([file count]==0) {
            return NO;
        }
    }else if ([file isKindOfClass:[NSData class]]) {
        file = [NSData dataWithContentsOfFile:filename];
        if ([file length] ==0) {
            return NO;
        }
    }
    
    return YES;
}

+(NSData *) getDataFileFromLoc:(NSString*)filePath into:(id)file {
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *CachePath = [filePath stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    NSString *filename=[Path stringByAppendingPathComponent:CachePath];
    
    if ([file isKindOfClass:[NSData class]]) {
        file = [NSData dataWithContentsOfFile:filename];
        if ([file length] ==0) {
            return nil;
        }
        return file;
    }
    return nil;
    
}

+(BOOL)removeLoc:(NSString *)fileName{
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *CachePath = [fileName stringByReplacingOccurrencesOfString: @"/" withString: @"_"];
    NSString *filename=[Path stringByAppendingPathComponent:CachePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filename]) {
        if ([fileManager removeItemAtPath:filename error:nil]) {
            return YES;
        }
        return NO;
    }
    return NO;
    
}

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
#pragma mark - 获取UILabel 、UIButton 、UIImageView的类方法汇总
+(UILabel *)getLabel:(CGRect)frame fontSize:(float)fontSize alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:16];//默认是16
    if (fontSize > 0) {
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    label.textAlignment = alignment;
    
    label.textColor = textColor;//例如：@"ffffff"
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}

+(UIButton *)getButton:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(float)titleSize{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    if (titleSize > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:titleSize];
    }
    return button;
}
+(UIImageView *)getImageView:(CGRect)frame cornerRadius:(float)cornerRadius {
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = frame;
    imageView.layer.cornerRadius = cornerRadius;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;     ///这个是取中间的一部分。。不压缩的。
    imageView.backgroundColor = [UIColor clearColor];
    return imageView;
}

#pragma mark ====点击textField的时候，上下移动View的通用方法========
+ (void) animateTextField: (UITextField *)textField up: (BOOL)up viewController:(UIViewController *)tempVC
{
    const int movementDistance = -(int)textField.tag;
    const float movementDuration = 0.3f;
    
    int movement = (up ? movementDistance: -movementDistance);
    
    [UIView beginAnimations:@"animateTextField" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    
    tempVC.view.frame = CGRectOffset(tempVC.view.frame, 0, movement);
    [UIView commitAnimations];
    
}

/**
 *  获取本地路径url 或者 网络url
 *
 *  @param folderName 文件夹名称  本地路径的时候用，否则传 nil
 *  @param fileName   文件名字 本地路径的时候用，否则传 nil
 *  @param urlString  网络urlString
 *
 *  @return NSURL（网络或者本地）
 */
+(NSURL *)getURLWithFolderName:(NSString *)folderName fileName:(NSString *)fileName urlString:(NSString *)urlString {
    if ([folderName isEmptyString]) {
        folderName = @"Cycling_Record_Road_Images";
    }
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* path = [self absolutePath:[NSString stringWithFormat:@"%@/%@.png", folderName,fileName] systemPath:SYSTEM_LIBIARY_PATH];
    
    if([fileManager fileExistsAtPath:path]){
        
        return [NSURL fileURLWithPath:path];
    }else{
        return [NSURL URLWithString:urlString];
    }
}

+ (NSString*)absolutePath:(NSString*)relativePath systemPath:(NSString*)systemPath{
    return [systemPath stringByAppendingPathComponent:relativePath];
}

#pragma mark - 各种方便的block封装  ReactiveCocoa
/*
 概述：
 可以把信号想象成水龙头，只不过里面不是水，而是玻璃球(value)，直径跟水管的内径一样，这样就能保证玻璃球是依次排列，不会出现并排的情况(数据都是线性处理的，不会出现并发情况)。水龙头的开关默认是关的，除非有了接收方(subscriber)，才会打开。这样只要有新的玻璃球进来，就会自动传送给接收方。可以在水龙头上加一个过滤嘴(filter)，不符合的不让通过，也可以加一个改动装置，把球改变成符合自己的需求(map)。也可以把多个水龙头合并成一个新的水龙头(combineLatest:reduce:)，这样只要其中的一个水龙头有玻璃球出来，这个新合并的水龙头就会得到这个球。
 具体使用：
 当一个signal被一个subscriber subscribe后，这个subscriber何时会被移除？答案是当subscriber被sendComplete或sendError时，或者手动调用[disposable dispose]。
 
 当subscriber被dispose后，所有该subscriber相关的工作都会被停止或取消，如http请求，资源也会被释放。
 
 Signal events是线性的，不会出现并发的情况，除非显示地指定Scheduler。所以-subscribeNext:error:completed:里的block不需要锁定或者synchronized等操作，其他的events会依次排队，直到block处理完成。
 
 Errors有优先权，如果有多个signals被同时监听，只要其中一个signal sendError，那么error就会立刻被传送给subscriber，并导致signals终止执行。相当于Exception。
 
 生成Signal时，最好指定Name, -setNameWithFormat: 方便调试。
 
 block代码中不要阻塞。
 
 */
-(void)reactiveCocoaDemoAction{
//    __weak typeof(self) wSelf = self;
//    因为RAC是基于KVO的，而NSMutableArray并不会在调用addObject或removeObject时发送通知
    //------------------------------------通知监听----------------------------------------
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"log_out" object:nil] subscribeNext:^(id x) {
        //        NSNotification* notification = (NSNotification*)x;
        //        int unreadClubMsgCount = 0;
        //        if (notification.object) {
        //            unreadClubMsgCount = [notification.object intValue];
        //        }
        //退出登录的通知。---"log_out"是自定义的
    }];
    
    //退出登录后执行。。。。上面的通知方法就可以触发了。
    [[NSNotificationCenter defaultCenter]postNotificationName:@"log_out" object:nil];
    
    //------------------------------------UITextField输入限制-----------------------------
    UITextField *textField;//自己写初始化
    [textField.rac_textSignal subscribeNext:^(NSString* text) {
        if(text.length > 12){
            textField.text = [text substringToIndex:12];
        }
    }];
    //------------------------------------UIAlertView,UIActionSheet点击方法-----------------------------
    UIAlertView *alertView;//自己写初始化
    [[alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
        if ([x integerValue] == 1) {//alert的按钮
            
        }
    }];
    [alertView show];
    UIActionSheet* actionSheet ;
    [[actionSheet rac_buttonClickedSignal] subscribeNext:^(id x) {
        if ([x integerValue] == 1) {//actionSheet的按钮
            
        }
    }];
//    [actionSheet showInView:self.view];
    //------------------------------------UIButton点击方法-----------------------------
    UIButton *button;//自己写初始化
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    //点击事件拦截。
    [[[button rac_signalForControlEvents:UIControlEventTouchUpInside]filter:^BOOL(UIButton *button) {
        if ([button.currentTitle isEqualToString:@"sd"]) {
            return YES;
        }else{
            return NO;
        }
    }]subscribeNext:^(id x) {
        NSLog(@"点击事件");
    }];
    //------------------------------------segmentedControl-----------------------------
    UISegmentedControl *segmentedControl;
    [[segmentedControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        
        
    }];
    
    //---------------------------------------------RAC-------------------------------------------
    //---------------------------------------------RACObserver-------------------------------------------
//    RAC() 可以将Signal发出事件的值赋值给某个对象的某个属性，其参数为对象名和属性名
//    RACObserve() 参数为对象名和属性名，新建一个Signal并对对象的属性的值进行观察，当值变化时Signal会发出事件
    //某个属性一发生变化就执行。
    [RACObserve(self, count) subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            
        }else if ([x integerValue] > 100){
            
        }
    }];
   
    //返回Bool赋值给createEnabled
    RAC(self, createEnabled) = [RACSignal combineLatest:@[RACObserve(self, password),RACObserve(self, passwordConfirm)] reduce:^(NSString *pwd,NSString *pwdConfirm) {
        return @([pwd isEqualToString:pwdConfirm]);
    }];
    
   //--------------------------------------------map 用法 --------------------------------------------
    //map 改变返回的类型 给结果管道。
    [[self.textField.rac_textSignal map:^id(NSString *text) {
        if ([text isEmptyString]) {
            return [UIColor whiteColor];
        }else{
            return [UIColor yellowColor];
        }
    }]subscribeNext:^(UIColor *color) {
        self.textField.backgroundColor = color;
    }];
    
    [[[self.button rac_signalForControlEvents:UIControlEventTouchUpInside]map:^id(UIButton *button) {
        if ([button.currentTitle isEqualToString:@"按钮"]) {
            return [NSString stringWithFormat:@"按钮"];
        }else{
            return [NSString stringWithFormat:@"不是按钮"];
        }
    }]subscribeNext:^(NSString *resultString) {
        NSLog(@"%@",resultString);
    }];
    //--------------------------------------------filter 用法 --------------------------------------------
    //filter某个属性满足一定条件才执行。
    [[RACObserve(self, count) filter:^BOOL(id count) {//返回的是BOOL类型
        if ([count integerValue] == 5) {
            return YES;
        }else{
            return NO;
        }
    }]subscribeNext:^(id count) {//上面return YES 才走这里
        NSLog(@"数量为===%@",count);
    }];
    
    //--------------------------------------------rac_command 用法 --------------------------------------------
    self.button.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"按钮点击了。");
        //        [RACSignal return:@(6)];
        return [RACSignal empty];
    }];
    
    
    //----------------------------------------RACDisposable 用法 --------------------------------------------
    
    RACSignal *backgrountColorSignal = [self.textField.rac_textSignal map:^id(NSString *text) {
        if ([text isEmptyString]) {
            return [UIColor whiteColor];
        }else{
            return [UIColor greenColor];
        }
    }];
    //subscrbeNext: 返回的类型是 RACDisposable
    RACDisposable *subscription = [backgrountColorSignal subscribeNext:^(UIColor *color) {
        self.textField.backgroundColor = color;
    }];
    
    //----------------------------------------combineLaster 用法 --------------------------------------------
    //将self.button.enables 属性 和 右边的signal sendNext 值绑定。
    RAC(self.button,enabled) = [RACSignal combineLatest:@[self.password,self.textField.rac_textSignal,RACObserve(self, passwordConfirm)] reduce:^(NSString *password,NSString *textString,NSString *passwordConfirm){
        if ([password isEqualToString:passwordConfirm] && textString.length > 0) {
            return @(YES);
        }else{
            return @(NO);
        }
    }];
    
    //----------------------------------------RACSignal创建使用--------------------------------------------
//    当一个signal被一个subscriber subscribe后，这个subscriber何时会被移除？答案是当subscriber被sendComplete或sendError时，或者手动调用[disposable dispose]。
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"当前值");
        [subscriber sendNext:@"下个值"];
        [subscriber sendCompleted];
        return nil;
    }];//创建了一个 signal 但是没有 被subscribe 所有上面都不会发生。
    
    //单独执行这句 会输出  当前值  完成1
    [signal subscribeCompleted:^{
        NSLog(@"完成了1");
    }];
    
    //单独执行这句 会输出  当前值 x2===下个值
    [signal subscribeNext:^(id x) {
        NSLog(@"x2===%@",x);
    }];
    
    //单独执行这句 会输出  当前值 x3===下个值  完成了3
    [signal subscribeNext:^(id x) {
        NSLog(@"x3====%@",x);
    } completed:^{
        NSLog(@"完成了3");
    }];


    //---------------------------------------- RACSignal merge zipWith------------------------------------
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        return nil;
    }];//创建了一个 signal 但是没有 被subscribe 所有上面都不会发生。
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"B"];
        return nil;
    }];
    
    RACSignal *mergeSignal = [signalA merge:signalB];//任何一个信号发出都会执行。
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);  ///会 两个输出： A  B
    }];

    RACSignal *zipSignal = [signalA zipWith:signalB];//两个信号都发出才会执行
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);///会输出一个数组（A ,B） <RACTuple: 0x7fd61c82b1d0>
    }];

    RACSignal *combineSignal = [signalA combineLatestWith:signalB];
    [combineSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);//会输出一个数组（A ,B）  <RACTuple: 0x7fd61c82b1d0>
    }];
    
    RACSignal *reduceSignal = [RACSignal combineLatest:@[signalA,signalB] reduce:^id(NSString *str1,NSString *str2){
        return [NSString stringWithFormat:@"%@ %@",str1,str2];
    }];
    [reduceSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);//合并后的字符串 A B
    }];
    
    //---------------------------------------- RACSubject 是 RACSignal 的子类------------------------------------
    
//    subjects 表现为RACSubject类，可以认为是“可变的（mutable）”信号/自定义信号，它是嫁接非RAC代码到Signals世界的桥梁，很有用。嗯。。。 这样讲还是很抽象，举个例子吧：
    RACSubject *letters = [RACSubject subject];
    [letters sendNext:@"a"];
//    可以看到@"a"只是一个NSString对象，要想在水管里顺利流动，就要借RACSubject的力。
    
    //---------------------------------------- RACSequence有个属性是 RACSignal---------------------------
//    sequence 表现为RACSequence类，可以简单看做是RAC世界的NSArray，RAC增加了-rac_sequence方法，可以使诸如NSArray这些集合类（collection classes）直接转换为RACSequence来使用。
    NSArray *arr = [NSArray arrayWithObjects:@"arr1",@"arr2", nil];
    NSMutableArray *array = [NSMutableArray array];
    RACSequence *sequence = [arr rac_sequence];
    [[[sequence.signal map:^id(id value) {
        [array addObject:value];
        return array;
    }] filter:^BOOL(NSArray *resultArray) {
        if (resultArray.count < 2) {
            return NO;
        }else{
            return YES;
        }
    }] subscribeNext:^(id x) {
        NSLog(@"x===%@",x);
    }];

    
    //---------------------------------------- scheduler 定时器------------------------------------
//    scheduler 表现为RACScheduler类，类似于GCD，but schedulers support cancellationbut schedulers support cancellation, and always execute serially
    
    /**
     *  @brief  创建一个定时器信号，每三秒发出一个当时日期值。一共发5次。
     */
    RACSignal *signalInterval = [RACSignal interval:3.0 onScheduler:[RACScheduler mainThreadScheduler]];
    signalInterval = [signalInterval take:5];//总共5次。
    [signalInterval subscribeNext:^(id x) {
        NSLog(@"x====%@",x);///x====2015-12-30 04:05:50 +0000
    }];
}










@end
