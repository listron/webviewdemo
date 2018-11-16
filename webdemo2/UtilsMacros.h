//
//  define.h
//  MiAiApp
//
//  Created by zhangqiang on 2017/5/18.
//  Copyright © 2017年 zhangqiang. All rights reserved.
//

// 全局工具类宏定义

#ifndef define_h
#define define_h

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//获取屏幕宽高
#define KScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define KScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define kScreenBounds [UIScreen mainScreen].bounds

#define Iphone6ScaleWidth KScreenWidth/375.0
#define Iphone6ScaleHeight KScreenHeight/667.0

//根据ip6的屏幕来拉伸
#define kRealValue(value) ((value)*(KScreenWidth/375.0f))
#define kRealFont(font)  [UIFont systemFontOfSize:((font)*(kScreenWidth)/375)]
#define kRealBoldFont(font)  [UIFont boldSystemFontOfSize:((font)*(kScreenWidth)/375)]

//强弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

//由角度获取弧度 由弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//View 边框
#define ViewBorder(View, Width, Color)\
\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//property 属性快速声明 别用宏定义了，使用代码块+快捷键实现吧

// 当前系统版本
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
//当前语言
#define CurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//颜色
#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]
#define kMagentaColor [UIColor magentaColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBCOLORA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kHexColor(hex)      [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1]
#define kRandomColor    KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)

//字体
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

//图片
#define LOAD_IMAGE(file,ext) [UIImage imageWithContentsOfFile:[NSBundle mainBundle]pathForResource:file ofType:ext］
#define IMAGE(A) [UIImage imageWithContentsOfFile:[NSBundle mainBundle] pathForResource:A ofType:nil］
#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]
#define IMAGE_NAMED(name) [UIImage imageNamed:name]

//数据验证
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")
#define HasString(str,key) ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)
//打印当前方法名
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)


//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

// ---------- 适配相关 ----------
//机型
//判断是否是ipad
#define kIPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !kIPad : NO)
//判断iPhone5系列
#define kIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !kIPad : NO)
//判断iPhone6系列
#define kIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !kIPad : NO)
//判断iphone6+系列
#define kIPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !kIPad : NO)
//判断iPhoneX
#define kIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !kIPad : NO)
//判断iPHoneXr
#define kIPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !kIPad : NO)
//判断iPhoneXs
#define kIPhoneXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !kIPad : NO)
//判断iPhoneXs Max
#define kIPhoneXs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !kIPad : NO)

//适配iphoneX
#define kStatusBarHeight ((kIPhoneX==YES || kIPhoneXr ==YES || kIPhoneXs== YES || kIPhoneXs_Max== YES) ? 44.0 : 20.0)
#define kNavBarHeight 44.0
#define kTabBarHeight 49.0
#define kTabBarHeightSafeBottomMargin ((kIPhoneX==YES || kIPhoneXr ==YES || kIPhoneXs== YES || kIPhoneXs_Max== YES) ? 34.f : 0.f)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define kBottomHeight (kTabBarHeight + kTabBarHeightSafeBottomMargin)
#define kTableViewMaxH (kScreenHeight - kTopHeight)

//仅保留导航栏
#define kNormalFrame CGRectMake(0, 0, KScreenWidth, (KScreenHeight-kTopHeight))
//保留导航栏和底部安全域
#define kSafeFrame CGRectMake(0, 0, KScreenWidth, (KScreenHeight-kTopHeight-kTabbarSafeBottomMargin))
//仅保留状态栏(隐藏导航栏)
#define kHideNavNormalFrame CGRectMake(0, kStatusBarHeight, kScreenWidth, (kScreenHeight-kStatusBarHeight))
//保留状态栏和底部安全域（隐藏导航栏）
#define kHideNavSafeFrame CGRectMake(0, kStatusBarHeight, KScreenWidth, (KScreenHeight-kStatusBarHeight-kTabbarSafeBottomMargin))

//计算方法耗时
#define TICK  CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    // { 这里放需要计算的代码 }
#define TOCK  NSLog(@"方法耗时: %f ms", (CFAbsoluteTimeGetCurrent() - start) * 1000.0);


#endif /* define_h */
