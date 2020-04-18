//
//  WFUserVC.m
//  WFByr
//
//  Created by Andy on 2017/6/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFUserVC.h"
#import "WFToken.h"
#import "WFUserApi.h"
#import "WFModels.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

const CGFloat WFNavigationBarAnimationDuration = 0.5;

const CGFloat WFFaceCoverHeight = 200.0;
const CGFloat WFFaceImgWidth    = 75.0;

const NSInteger WFUserPropertyCount = 13;

typedef NS_ENUM(NSUInteger, WFUserProperty) {
    WFUserPropertyGender = 0,
    WFUserPropertyAstro,
    WFUserPropertyLife,
    WFUserPropertyQq,
    WFUserPropertyLevel,
    WFUserPropertyIsOnline,
    WFUserPropertyPostCount,
    WFUserPropertyLastLoginTime,
    WFUserPropertyLastLoginIp,
    WFUserPropertyFirstLoginTime,
    WFUserPropertyLoginCount,
    WFUserPropertyIsAdmin,
    WFUserPropertyStayCount
};

@interface WFUserVC () <UITableViewDelegate, UITableViewDataSource, WFUserResponseDelegate>

@property (nonatomic, strong) UIImageView *faceCover;
@property (nonatomic, strong) UIImageView *faceImg;
@property (nonatomic, strong) UILabel *nameLabel;
//@property (nonatomic, strong) UILabel *
@property (nonatomic, weak) MASConstraint *faceHeight;
@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, assign) NSString *uid;

@property (nonatomic, strong) WFUser *user;

@property (nonatomic, strong) WFUserApi *userApi;

@end

@implementation WFUserVC {
    BOOL _isNavigationBarShow;
}

- (instancetype)initWithParams:(NSDictionary*)params {
    self = [super init];
    if (self != nil) {
        self.uid = params[@"uid"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self.tableview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self wf_hideNavigationBar];
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_uid && ![_uid isEqualToString:@""]) {
        [self.userApi fetchUserInfoWithUid:_uid];
    } else {
       [self.userApi fetchUserInfo];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self wf_showNavigationBar];
}

- (void)updateViewConstraints {
    [self.faceImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.faceCover).centerOffset(CGPointMake(0, -20));
        make.width.height.equalTo(@(WFFaceImgWidth));
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.faceImg);
        make.top.equalTo(self.faceImg.mas_bottom).offset(8);
    }];
    
    [self.faceCover mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        _faceHeight = make.height.equalTo(@(WFFaceCoverHeight));
    }];
    
    [self.tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint offset = ((NSValue*)[change objectForKey:NSKeyValueChangeNewKey]).CGPointValue;
        if (offset.y < 0) {
            _faceHeight.equalTo(@(-offset.y));
        }
        if (offset.y > -WFFaceCoverHeight * 0.75 && !_isNavigationBarShow) {
            [UIView animateWithDuration:WFNavigationBarAnimationDuration animations:^{
               [self wf_showNavigationBar];
            }];
        } else if (offset.y < -WFFaceCoverHeight * 0.75 && _isNavigationBarShow) {
            [UIView animateWithDuration:WFNavigationBarAnimationDuration animations:^{
               [self wf_hideNavigationBar];
            }];
        }
    }
}

- (void)dealloc {
    [self.tableview removeObserver:self forKeyPath:@"contentOffset"];
}

# pragma mark - Private Method

- (void)setupData {
    [self.faceCover sd_setImageWithURL:[NSURL URLWithString:_user.face_url]];
    [self.faceImg sd_setImageWithURL:[NSURL URLWithString:_user.face_url]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@(%@)", _user.user_name, _user.uid];
    [self.tableview reloadData];
}

- (void)setupUI {
    [self.faceCover addSubview:self.faceImg];
    [self.faceCover addSubview:self.nameLabel];
    [self.view addSubview:self.faceCover];
    [self.view addSubview:self.tableview];
    [self updateViewConstraints];
}

- (void)wf_hideNavigationBar {
    _isNavigationBarShow = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //self.navigationController.navigationBar.translucent = YES;
}

- (void)wf_showNavigationBar {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _isNavigationBarShow = YES;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    //self.navigationController.navigationBar.translucent = NO;
}

# pragma mark - WFUserResposeDelegate

- (void)fetchUserResponse:(WFResponse *)response {
    if (response.isSucceeded) {
        _user = response.reformedData;
    }
    [self setupData];
}

# pragma mark - UITableViewDataSourece

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _user ? WFUserPropertyCount : 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableString *properityStr = [NSMutableString string];
    switch (indexPath.row) {
        case WFUserPropertyGender:
            [properityStr appendString:[NSString stringWithFormat:@"性别:%@", _user.gender]];
            break;
        case WFUserPropertyAstro:
            [properityStr appendString:[NSString stringWithFormat:@"星座:%@", _user.astro]];
            break;
        case WFUserPropertyLife:
            [properityStr appendString:[NSString stringWithFormat:@"生命值:%ld", _user.life]];
            break;
        case WFUserPropertyQq:
            [properityStr appendString:[NSString stringWithFormat:@"QQ:%@", _user.qq]];
            break;
        case WFUserPropertyLevel:
            [properityStr appendString:[NSString stringWithFormat:@"身份:%@", _user.level]];
            break;
        case WFUserPropertyIsOnline:
            [properityStr appendString:[NSString stringWithFormat:@"是否在线:%d", _user.is_online]];
            break;
        case WFUserPropertyPostCount:
            [properityStr appendString:[NSString stringWithFormat:@"发文数量:%ld", _user.post_count]];
            break;
        case WFUserPropertyLastLoginIp:
           [properityStr appendString:[NSString stringWithFormat:@"上次登录IP:%@", _user.last_login_ip]];
            break;
        case WFUserPropertyLastLoginTime:
            [properityStr appendString:[NSString stringWithFormat:@"上次登录时间:%@", [NSDate dateWithTimeIntervalSince1970:_user.last_login_time]]];
            break;
        case WFUserPropertyFirstLoginTime:
            [properityStr appendString:[NSString stringWithFormat:@"注册时间:%@", [NSDate dateWithTimeIntervalSince1970:_user.first_login_time]]];
            break;
        case WFUserPropertyLoginCount:
            [properityStr appendString:[NSString stringWithFormat:@"登陆次数:%ld", _user.login_count]];
            break;
        case WFUserPropertyIsAdmin:
            [properityStr appendString:[NSString stringWithFormat:@"是否为管理员:%d", _user.is_admin]];
            break;
        case WFUserPropertyStayCount:
            [properityStr appendString:[NSString stringWithFormat:@"挂站时间:%ld天", _user.stay_count / (24 * 3600)]];
            break;
        default:
            break;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    cell.textLabel.text = properityStr.copy;
    cell.textLabel.font = [UIFont fontWithName:WFFontName size:14];
    return cell;
}

- (UIImageView*)faceCover {
    if (_faceCover == nil) {
        _faceCover = [UIImageView new];
        [_faceCover setImage:[UIImage imageNamed:@"haha"]];
        _faceCover.contentMode = UIViewContentModeScaleToFill; //UIViewContentModeScaleAspectFit;
        UIVisualEffectView *effectMask = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        [_faceCover addSubview:effectMask];
        [effectMask mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_faceCover);
        }];
        
    }
    return _faceCover;
}

- (UIImageView*)faceImg {
    if (_faceImg == nil) {
        _faceImg = [UIImageView new];
        [_faceImg setImage:[UIImage imageNamed:@"haha"]];
    }
    return _faceImg;
}

- (UILabel*)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont fontWithName:WFFontName size:14];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UITableView*)tableview {
    if (_tableview == nil) {
        _tableview = [UITableView new];
        _tableview.contentInset = UIEdgeInsetsMake(WFFaceCoverHeight, 0, 0, 0);
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
        _tableview.allowsSelection = NO;
        _tableview.backgroundColor = [UIColor clearColor];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

- (WFUserApi*)userApi {
    if (_userApi == nil) {
        _userApi = [[WFUserApi alloc] init];
        _userApi.responseDelegate = self;
    }
    return _userApi;
}

@end
