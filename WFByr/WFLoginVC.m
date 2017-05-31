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
    self.webview = [[UIWebView alloc] init];
    self.webview.delegate = self;
    
    
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:[self.oath oathUrl]]];
    [self.view addSubview:self.webview];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.trailing.equalTo(self.view.mas_trailing);
        make.bottom.equalTo(self.view.mas_bottom);
        make.leading.equalTo(self.view.mas_leading);
    }];
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
