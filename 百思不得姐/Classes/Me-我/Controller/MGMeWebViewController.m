//
//  MGMeWebViewController.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/13.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGMeWebViewController.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>

@interface MGMeWebViewController () <UIWebViewDelegate, NJKWebViewProgressDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;

/** 进度条控件 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 底部工具条 */
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

/** 进度条控件 */
//@property (nonatomic, strong) NJKWebViewProgressView *progressView;

/** 进度代理对象 */
@property (nonatomic, strong) NJKWebViewProgress *progress;
@end

@implementation MGMeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 进度条控件
//    self.progressView = [[NJKWebViewProgressView alloc] init];
//    self.progressView.frame = CGRectMake(0, 64, MGScreenW, 2);
//    [self.view addSubview:self.progressView];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    self.progress.webViewProxyDelegate = self;
    
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress) {
//        MGLog(@"----%f", progress);
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress == 1);
    };
    
    self.progress.progressDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];

//    self.goBackItem.enabled = NO;
//    self.goForwardItem.enabled = NO;
    
    [self.toolbar layoutIfNeeded];
    
}

- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.webView reload];
}


- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled = self.webView.canGoBack;
    self.goForwardItem.enabled = self.webView.canGoForward;
    [self.toolbar layoutIfNeeded];
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    
}

@end
