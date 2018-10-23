//
//  FTWebViewController.m
//  FTWebView
//
//  Created by wolffy on 2018/10/10.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import "FTWebViewController.h"

@interface FTWebViewController () <WKNavigationDelegate>{
    BOOL _isProgressing;
}

@property (nonatomic,strong) WKWebView * webView;
@property (nonatomic,strong) UIButton * backButton;
@property (nonatomic,strong) UIView * navigationBar;
@property (nonatomic,strong) UIProgressView * progress;
@property (nonatomic,strong) UIView * line;

@end

@implementation FTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self createNavigationBar];
    [self createWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData{
    _isProgressing = NO;
}

#pragma mark -
#pragma mark - 创建view

- (UIView *)navigationBar{
    if(_navigationBar == nil){
        _navigationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, BJNEWS_SCREEN_NAVHEIGHT(64))];
        _navigationBar.backgroundColor = [UIColor whiteColor];
        [_navigationBar addSubview:self.backButton];
        [_navigationBar addSubview:self.progress];
        self.line = [[UIView alloc]initWithFrame:CGRectMake(0, BJNEWS_SCREEN_NAVHEIGHT(63), [UIScreen mainScreen].bounds.size.width, 1)];
        self.line.backgroundColor = [UIColor lightGrayColor];
        self.line.alpha = 0.3;
        [_navigationBar addSubview:self.line];
    }
    return _navigationBar;
}

- (UIButton *)backButton{
    if(_backButton == nil){
        _backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _backButton.frame = CGRectMake(0, BJNEWS_SCREEN_NAVHEIGHT(20), 44, 44);
        [_backButton setTitle:@"<" forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIProgressView *)progress{
    if(_progress == nil){
        _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, BJNEWS_SCREEN_NAVHEIGHT(63), [UIScreen mainScreen].bounds.size.width, 2)];
        _progress.trackTintColor = [UIColor clearColor];
        _progress.hidden = YES;
//        _progress.progressTintColor = [[BJNewsiPhoneThemeManager defaultManager] color_HD];
    }
    return _progress;
}

- (void)createNavigationBar{
    [self.view addSubview:self.navigationBar];
}

/**
 创建webView

 @return webView
 */
- (WKWebView *)webView{
    if(_webView == nil){
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, BJNEWS_SCREEN_NAVHEIGHT(64), [UIScreen mainScreen].bounds.size.width, BJNEWS_SCREEN_HEIGHT - BJNEWS_SCREEN_NAVHEIGHT(64))];
        _webView.navigationDelegate = self;
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            UINavigationController * nc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            UIViewController * vc = nc.visibleViewController;
            if(vc){
                vc.automaticallyAdjustsScrollViewInsets = NO;
            }
        }
    }
    return _webView;
}

/**
 创建webView
 */
- (void)createWebView{
    [self.view addSubview:self.webView];
    [self loadRequestWithUrl:self.url];
}

#pragma mark - 网络加载
/**
 webViwe开始加载数据

 @param url url description
 */
- (void)loadRequestWithUrl:(NSString *)url{
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}

/**
 开始加载网页
 
 @param url 网页地址
 */
- (void)startWithUrl:(NSString *)url title:(NSString *)title{
    self.url = url;
    self.title = title;
}

#pragma mark - webView delegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //  在发送请求之前，决定是否跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"1");
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"2");
    [self startProgress];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"3");
    [self endProgress];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"4");
    [self endProgress];
}

#pragma mark - 事件
- (void)goBack:(UIButton *)button{
    if([self.webView canGoBack]){
        [self.webView goBack];
    }else{
        [self closeButtonClick:button];
    }
}

- (void)closeButtonClick:(UIButton *)button{
    if(self.webView.isLoading == YES){
        [self.webView stopLoading];
    }
    if(self.navigationController != nil){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (void)startProgress{
    if(_isProgressing == YES){
        return;
    }
    _isProgressing = YES;
    self.line.hidden = YES;
    self.progress.hidden = NO;
    [self.progress setProgress:0.85 animated:YES];
}

- (void)endProgress{
    if(_isProgressing == NO){
        return;
    }
    _isProgressing = NO;
    [self.progress setProgress:1.0 animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.progress.hidden = YES;
        [self.progress setProgress:0.0 animated:NO];
        self.line.hidden = NO;
    });
}

@end
