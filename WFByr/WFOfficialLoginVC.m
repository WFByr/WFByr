//
//  WFOfficialLoginVC.m
//  WFByr
//
//  Created by Andy on 2017/8/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFOfficialLoginVC.h"
#import "Masonry.h"
#import "WFLoginService.h"
#import "WFToken.h"

@interface WFOfficialLoginVC ()

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UITextField *userNameInput;
@property (nonatomic, strong) UITextField *pwdInput;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation WFOfficialLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor wf_mainBlue];
    _logoView = [UIImageView new];
    [self.view addSubview:_logoView];
    _logoView.contentMode = UIViewContentModeScaleAspectFit;
    _logoView.image = [UIImage imageNamed:@"logo"];
    [_logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(70));
        make.top.equalTo(self.view).offset(70);
        make.centerX.equalTo(self.view);
    }];
    
    _userNameInput = [UITextField new];
    [self.view addSubview:_userNameInput];
    _userNameInput.layer.cornerRadius = 5;
    _userNameInput.tintColor = [UIColor blackColor];
    _userNameInput.backgroundColor = [UIColor whiteColor];
    _userNameInput.placeholder = @"用户名";
    _userNameInput.font = [UIFont wf_bigFont];
    [_userNameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoView.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.height.equalTo(@(50));
    }];
    
    _pwdInput = [UITextField new];
    _pwdInput.layer.cornerRadius = 5;
    _pwdInput.tintColor = [UIColor blackColor];
    _pwdInput.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pwdInput];
    _pwdInput.placeholder = @"密码";
    _pwdInput.font = [UIFont wf_bigFont];
    [_pwdInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNameInput.mas_bottom).offset(20);
        make.left.right.height.equalTo(_userNameInput);
    }];
    
     _loginBtn = [UIButton new];
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.clipsToBounds = YES;
    _loginBtn.backgroundColor = [UIColor wf_darkerBlue];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont wf_hugeFont];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwdInput.mas_bottom).offset(50);
        make.left.right.height.equalTo(_pwdInput);

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginBtnClicked {
    __weak typeof(self) weakSelf = self;
    [WFLoginService loginWithUserName:_userNameInput.text password:_pwdInput.text success:^(NSURLResponse *response, WFToken *token) {
        
        // WFToken will be rewrited
        [[NSUserDefaults standardUserDefaults] setObject:token.accessToken forKey:@"access_token"];
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } fail:^(NSURLResponse *response, NSError *error) {
        wf_showHud(self.view, error.localizedDescription, 1);
    }];
}
@end
