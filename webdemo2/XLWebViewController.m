//
//  IBWebViewController.m
//  O2
//
//  Created by qilongTan on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "XLWebViewController.h"
#import "XLJSHandler.h"
#import <UIKit/UIKit.h>
#import <YYKit/YYKit.h>

@interface XLWebViewController () <WKNavigationDelegate>
@property (nonatomic,strong) XLJSHandler * jsHandler;
@property (nonatomic,assign) double lastProgress;//上次进度条位置
@end

@implementation XLWebViewController

-(instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        self.url = url;
        _progressViewColor = [UIColor redColor];
    }
    return self;
}

-(void)setUrl:(NSString *)url
{
    if (_url != url) {
        _url = url;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        //加密header部分
        //        NSString *headerContentStr = [[HeaderModel new] modelToJSONString];
        //        NSString *headerAESStr = aesEncrypt(headerContentStr);
        //        [request setValue:headerAESStr forHTTPHeaderField:@"header-encrypt-code"];
        [self.webView loadRequest:request];
        
        //测试加载本地html
        //NSURL *url = [[NSBundle mainBundle] URLForResource:@"JSToOC" withExtension:@"html"];
        //NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //[_webView loadRequest:request];
        
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWKWebView];
    //适配iOS11
    if (@available(iOS 11.0, *)){
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithImage:[self reSizeImage:[UIImage
                                                                                     imageWithColor:[UIColor redColor]] toSize:CGSizeMake(100, 30)] style:UIBarButtonItemStyleDone target:self action:@selector(left)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"aaa" style:UIBarButtonItemStyleDone target:self action:@selector(left)];
   // item.title = @"aaaa";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:(self) action:@selector(left)];
    //UIView *item = []
    NSArray * items = [[NSArray alloc]initWithObjects:item1,item2, nil];
    self.navigationItem.leftBarButtonItems = items;
    //self.navigationItem.leftBarButtonItem.image =  [UIImage imageWithColor:[UI]];
//    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
//    returnButtonItem.title = @"返回";
//    returnButtonItem.tintColor = [UIColor redColor];
//    self.navigationItem.backBarButtonItem = returnButtonItem;
    
    //UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    // 设置导航条前景色
    //[bar setTintColor:[UIColor blueColor]];
    
    // 获取导航条按钮的标识
    //UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    // 修改返回按钮标题的位置
    //[item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -1000) forBarMetrics:UIBarMetricsDefault];

    
}
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


-(void)left{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 初始化webview
-(void)initWKWebView
{
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    configuration.preferences.javaScriptEnabled = YES;//打开js交互
    _webConfiguration = configuration;
    _jsHandler = [[XLJSHandler alloc]initWithViewController:self configuration:configuration];
    
    CGRect f = self.view.bounds;
    if (self.navigationController && self.isHidenNaviBar == NO) {
        f = CGRectMake(0, 0, self.view.bounds.size.width, kScreenHeight - 20);
    }
    
    self.webView = [[WKWebView alloc]initWithFrame:f configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.allowsBackForwardNavigationGestures =YES;//打开网页间的 滑动返回
    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    //监控进度
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    //[_webView setHeight:300];
    [self.view addSubview:_webView];
    //进度条
    _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.progressTintColor = _progressViewColor;
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3.0);
    [_webView addSubview:_progressView];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    //加密header部分
    //    NSString *headerContentStr = [[HeaderModel new] modelToJSONString];
    //    NSString *headerAESStr = aesEncrypt(headerContentStr);
    //    [request setValue:headerAESStr forHTTPHeaderField:@"header-encrypt-code"];
    [_webView loadRequest:request];
    
    //! 测试按钮
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftButton.frame = CGRectMake(0, 350, 44, 44);
//    leftButton.backgroundColor = [UIColor redColor];
//    [leftButton addTarget:self action:@selector(sender:) forControlEvents:UIControlEventTouchUpInside];
//    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    [self.view addSubview:leftButton];
    
//    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_webView.bottom);
//        make.left.mas_equalTo(self.view).offset(10);
//        make.right.mas_equalTo(self.view).offset(-10);
//        make.height.mas_equalTo(kRealValue(50));
//    }];
}

- (void)setProgressViewColor:(UIColor *)progressViewColor {
    _progressViewColor =  progressViewColor;
    _progressView.progressTintColor = progressViewColor;
}


-(void)backButtonClicked
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    else {
        [super backBtnClicked];
    }
}

#pragma mark --进度条
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    [self updateProgress:_webView.estimatedProgress];
}

#pragma mark -  更新进度条
-(void)updateProgress:(double)progress{
    self.progressView.alpha = 1;
    if(progress > _lastProgress){
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
    }else{
        [self.progressView setProgress:self.webView.estimatedProgress];
    }
    _lastProgress = progress;
    
    if (progress >= 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressView.alpha = 0;
            [self.progressView setProgress:0];
            _lastProgress = 0;
        });
    }
}

#pragma mark --navigation delegate
//加载完毕
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.title = webView.title;
    [self updateProgress:webView.estimatedProgress];
    
    [self updateNavigationItems];
    
}

//! 回调
- (void)sender:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView evaluateJavaScript:@"ocToJs('loginSucceed', 'oc_tokenString')" completionHandler:^(id response, NSError *error) {}];
    });
}
-(void)updateNavigationItems{
    
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if(webView != self.webView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    //更新返回按钮
    [self updateNavigationItems];
    
    NSURL * url = webView.URL;
    //打开wkwebview禁用了电话和跳转appstore 通过这个方法打开
    UIApplication *app = [UIApplication sharedApplication];
    if ([url.scheme isEqualToString:@"tel"])
    {
        if ([app canOpenURL:url])
        {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if ([url.absoluteString containsString:@"itunes.apple.com"])
    {
        if ([app canOpenURL:url])
        {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)backBtnClicked{
    [self.webView stopLoading];
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [super backBtnClicked];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [_jsHandler cancelHandler];
    self.webView.navigationDelegate = nil;
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end

