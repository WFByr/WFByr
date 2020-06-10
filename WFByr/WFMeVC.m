//
//  WFMeVC.m
//  WFByr
//
//  Created by Andy on 2017/6/1.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFMeVC.h"
#import "WFManagementTableViewAdapter.h"
#import "WFManagementTableViewHandler.h"

#import "WFManagementTableViewProtocal.h"
#import "WFManagementTableViewHelperProtocal.h"
#import "WFManagementUtils.h"

#import "WFManagementSection.h"
#import "WFManagementRow.h"

#import "WFToken.h"
#import "WFUserApi.h"

@interface WFMeVC ()<UITableViewDelegate,UITableViewDataSource,WFManagementTableViewHelperProtocal,WFUserResponseDelegate>

@property (nonatomic, strong) id<WFManagementTableViewAdapterProtocal> managementAdapter;
@property (nonatomic, strong) WFManagementTableViewHandler* managementHandler;
@property (nonatomic, copy) NSArray * dataSource;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) WFUser * user;
@property (nonatomic, assign) WFManagementRoleType managementRoleType;
@property (nonatomic, strong) WFUserApi *userApi;

@end

@implementation WFMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"我"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpDataSource];
    [self.userApi fetchUserInfo];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.managementAdapter tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.managementAdapter tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.managementAdapter numberOfSectionsInTableView:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self.managementAdapter tableView:tableView viewForHeaderInSection:section];
}

#pragma mark -- tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WFManagementSection * sectionItem = [self.dataSource objectAtIndex:indexPath.section];
    WFManagementRow * rowItem = [sectionItem.rows objectAtIndex:indexPath.row];
    return rowItem.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_managementRoleType == WFManagementRoleManager && section == 0) {
        return 157*WFHeightScale;
    }else {
        return 13;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [tableView reloadData];
    WFManagementSection * sectionItem = [self.dataSource objectAtIndex:indexPath.section];
    WFManagementRow * rowItem = [sectionItem.rows objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.managementHandler cellSelectWithTableView:tableView cell:cell rowItem:rowItem];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- private method
- (void)setUpDataSource{
    self.dataSource = nil;
    self.dataSource = [self.managementHandler createTableViewDataSourceWithType:self.managementRoleType];
}

# pragma mark - WFUserResposeDelegate

- (void)fetchUserResponse:(WFResponse *)response {
    if (response.isSucceeded) {
        _user = response.reformedData;
    }
    [self.tableView reloadData];
}

#pragma mark -- WFManagementTableViewHelperProtocal
- (NSArray *)dataSourceArray{
    return [self.dataSource copy];
}

- (WFManagementRoleType)managementRoleType{
    return _managementRoleType;
}

- (id)getUser{
    return self.user;
}

#pragma mark -- Getter and setters
- (id<WFManagementTableViewAdapterProtocal>)managementAdapter{
    if (!_managementAdapter) {
        _managementAdapter = (id<WFManagementTableViewAdapterProtocal>)[[WFManagementTableViewAdapter alloc]init];
        _managementAdapter.ownerController = self;
    }
    return _managementAdapter;
}

- (WFManagementTableViewHandler *)managementHandler{
    if (!_managementHandler) {
        _managementHandler = [[WFManagementTableViewHandler alloc]init];
        _managementHandler.ownerController = self;
    }
    return _managementHandler;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        UIView * backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
        backgroundView.backgroundColor = WFMAIN_BACKGROUND_COLOR;
        [_tableView setBackgroundView:backgroundView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _managementRoleType = WFManagementRoleManager;
    }
    return _tableView;
}

- (WFUserApi*)userApi {
    if (_userApi == nil) {
        _userApi = [[WFUserApi alloc] init];
        _userApi.responseDelegate = self;
    }
    return _userApi;
}

@end
