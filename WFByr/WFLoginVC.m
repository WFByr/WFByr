//
//  ASLoginController.m
//  ASByrApp
//
//  Created by andy on 16/4/8.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFLoginVC.h"
#import "WFLoginModuleConst.h"
#import "WFOAth2.h"
#import "WFToken.h"
#import "Masonry.h"

@interface WFLoginVC()<UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *webview;

@property(nonatomic, strong) WFOAth2 * oath;

@end

@implementation WFLoginVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.oath = [[WFOAth2 alloc] initWithAppkey:WFAppKey
                                           redirectUri:[NSURL URLWithString:WFRedirectUrl]
                                              state:WFState
                                               appleId:WFAppleId
                                              bundleId:WFBundleId];
    }
    return self;
}

# pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebview];
    [self setupBtns];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)setupWebview {
    self.webview = [[UIWebView alloc] init];
    self.webview.delegate = self;
    [self.webview loadRequest:[NSURLRequest requestWithURL:[self.oath oathUrl]]];
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.trailing.equalTo(self.view.mas_trailing);
        make.bottom.equalTo(self.view.mas_bottom);
        make.leading.equalTo(self.view.mas_leading);
    }];
}

- (void)setupBtns {
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitle:@"close" forState:UIControlStateNormal];
    [closeBtn setTitleColor:MAIN_BLUE forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.height.width.equalTo(@(40));
        make.top.equalTo(self.view).offset(8);
        make.right.equalTo(self.view).offset(-8);
    }];
    
    UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reloadBtn setTitle:@"refresh" forState:UIControlStateNormal];
    [reloadBtn setTitleColor:MAIN_BLUE forState:UIControlStateNormal];
    [reloadBtn addTarget:self action:@selector(reloadBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reloadBtn];
    [reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(closeBtn);
        make.right.equalTo(closeBtn.mas_left).offset(-8);
    }];
    
}

#pragma mark - Private Methods

- (void)closeBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reloadBtnClicked {
    [self.webview reload];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([self.oath parseRedirectUri:webView.request.URL.absoluteString]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"success");
    } else {
        NSLog(@"fail");
    }
}







@end
