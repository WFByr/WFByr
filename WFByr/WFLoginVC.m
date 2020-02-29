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

@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *reloadBtn;

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
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(20));
        make.top.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-32);
    }];
    
    _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reloadBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [_reloadBtn addTarget:self action:@selector(reloadBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_reloadBtn];
    [_reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_closeBtn);
        make.top.equalTo(_closeBtn);
        make.right.equalTo(_closeBtn.mas_left).offset(-16);
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
        WFLogInfo(@"success");
    } else {
        WFErrorInfo(@"fail");
    }
}







@end
