//
//  ASUserDefaultVC.m
//  WFByr
//
//  Created by Andy on 2017/7/28.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "ASUserDefaultListVC.h"
#import "ASUserDefaultDetailVC.h"
#import <CPDataDrivenLayout/UITableView+CPDataDrivenLayout.h>

@interface ASUserDefaultListVC ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ASUserDefaultListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
    [self setupNavi];
}

- (void)setupTableView {
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    _tableView.frame = self.view.bounds;
    _tableView.dataDrivenLayoutEnabled = YES;
    
    __weak typeof(self) weakSelf = self;
    CPDataDrivenLayoutSectionInfo *sectionInfo = [[CPDataDrivenLayoutSectionInfo alloc] init];
    [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        CPDataDrivenLayoutCellInfo *cellInfo = [[CPDataDrivenLayoutCellInfo alloc] initWithCellClass:[UITableViewCell class] nib:nil cellReuseIdentifier:@"cell" data:key];
        cellInfo.cellDidReuseCallback = ^(__kindof UITableView * _Nonnull tableView, __kindof UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, __kindof NSObject * _Nullable data) {
            cell.textLabel.text = data;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        };
        cellInfo.cellDidSelectCallback = ^(__kindof UITableView * _Nonnull tableView, __kindof UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, __kindof NSObject * _Nullable data) {
            [weakSelf.navigationController pushViewController:[[ASUserDefaultDetailVC alloc] initWithKey:key] animated:YES];
        };
        [sectionInfo appendCellInfos:@[cellInfo]];
    }];
    [_tableView cp_reloadSections:@[sectionInfo]];
}

- (void)setupNavi {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"add" style:UIBarButtonItemStyleDone target:self action:@selector(add)];
}

- (void)add {
    [self.navigationController pushViewController:[[ASUserDefaultDetailVC alloc] initWithKey:nil] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
