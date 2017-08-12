//
//  WFOfficialLoginVC.m
//  WFByr
//
//  Created by Andy on 2017/8/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFOfficialLoginVC.h"
#import "Masonry.h"
#import "WFLoginApi.h"

@interface WFOfficialLoginVC ()

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
    _userNameInput = [UITextField new];
    [self.view addSubview:_userNameInput];
    _userNameInput.placeholder = @"用户名";
    [_userNameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(8);
        make.right.equalTo(self.view).offset(-8);
        make.height.equalTo(@(50));
    }];
    
    _pwdInput = [UITextField new];
    [self.view addSubview:_pwdInput];
    _pwdInput.placeholder = @"密码";
    [_pwdInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNameInput.mas_bottom).offset(50);
        make.left.right.height.equalTo(_userNameInput);
    }];
    
     _loginBtn = [UIButton new];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:MAIN_BLUE forState:UIControlStateNormal];
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
    [[WFLoginApi alloc] loginWithUserName:_userNameInput.text password:_pwdInput.text success:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } fail:^{
        
    }];
}

@end
