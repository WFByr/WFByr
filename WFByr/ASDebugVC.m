//
//  DebugVC.m
//  WFByr
//
//  Created by Andy on 2017/7/28.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "ASDebugVC.h"

#import "ASUserDefaultListVC.h"
#import <CPDataDrivenLayout/UITableView+CPDataDrivenLayout.h>

@interface ASDebugVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ASDebugVC

+ (UINavigationController*)debugVCEmbedInNavigationController {
    return [[UINavigationController alloc] initWithRootViewController:[ASDebugVC new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupTableView];
    // Do any additional setup after loading the view.
    
}

- (void)setupNavi {
    if (self.navigationController) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    }
}

- (void)setupTableView {
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    _tableView.frame = self.view.bounds;
    _tableView.dataDrivenLayoutEnabled = YES;
    CPDataDrivenLayoutCellInfo *cellInfo = [[CPDataDrivenLayoutCellInfo alloc] initWithCellClass:[UITableViewCell class] nib:nil cellReuseIdentifier:@"cell" data:@"User Default"];
    
    __weak typeof(self) weakSelf = self;
    cellInfo.cellDidReuseCallback = ^(__kindof UITableView * _Nonnull tableView, __kindof UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, __kindof NSObject * _Nullable data) {
        cell.textLabel.text = data;
    };
    cellInfo.cellDidSelectCallback = ^(__kindof UITableView * _Nonnull tableView, __kindof UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, __kindof NSObject * _Nullable data) {
        [weakSelf.navigationController pushViewController:[ASUserDefaultListVC new] animated:YES];
    };
    
    [_tableView cp_reloadSections:@[[[CPDataDrivenLayoutSectionInfo alloc] initWithCellInfos:@[cellInfo]]]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
