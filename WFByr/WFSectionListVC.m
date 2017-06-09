//
//  WFSectionListVCTableViewController.m
//  WFByr
//
//  Created by Andy on 2017/6/8.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFBoardPicker.h"
#import "WFSectionListVC.h"
#import "WFSectionCell.h"
#import "WFBoardApi.h"
#import "WFModels.h"
#import "MJRefresh.h"

@interface WFSectionListVC () <WFBoardResponseDelegate, WFBoardResponseReformer>

@property (nonatomic, strong) WFBoardApi *boardApi;

@property (nonatomic, strong) NSString *sectionName;

@property (nonatomic, strong) NSMutableArray<WFSection*> *sections;

@property (nonatomic, strong) NSMutableArray<WFBoard*> *boards;

@end

@implementation WFSectionListVC

- (instancetype)initWithSectionName:(NSString*)sectionName {
    self = [super init];
    if (self != nil) {
        _sectionName = sectionName;
        _sections = [NSMutableArray array];
        _boards = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WFSectionCell" bundle:nil] forCellReuseIdentifier:@"WFSectionCell"];
    UIBarButtonItem *dismissBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = dismissBtn;
    //MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    //self.tableView.mj_header = header;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_sections.count == 0 && _boards.count == 0) {
        [self loadData];
        //[self.tableView.mj_header beginRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadData {
    if (!_sectionName) {
        [self.boardApi fetchRootSections];
    } else {
        [self.boardApi fetchSectionInfoWithName:self.sectionName];
    }
}


- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - WFBoardResponseDelegate

- (void)fetchRootSectionsResponse:(WFResponse*)response {
    if (response.isSucceeded) {
        [_sections removeAllObjects];
        [_sections addObjectsFromArray:response.reformedData];
    }
    [self.tableView reloadData];
    //[self.tableView.mj_header endRefreshing];
    self.tableView.hidden = NO;
}

- (void)fetchSectionsResponse:(WFResponse*)response {
    if (response.isSucceeded) {
        [_sections removeAllObjects];
        [_boards removeAllObjects];
        [_sections addObjectsFromArray:response.reformedData[@"section"]];
        [_boards addObjectsFromArray:response.reformedData[@"board"]];
    }
    [self.tableView reloadData];
    //[self.tableView.mj_header endRefreshing];
    self.tableView.hidden = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections.count + self.boards.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row < _sections.count) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = _sections[indexPath.row].desc ?: _sections[indexPath.row].name;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = _boards[indexPath.row - _sections.count].desc;
    }
    return cell;
}

- (WFBoardApi*)boardApi {
    if (_boardApi == nil) {
        _boardApi = [[WFBoardApi alloc] initWithAccessToken:[WFToken shareToken].accessToken];
        _boardApi.responseDelegate = self;
    }
    return _boardApi;
}

# pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.sections.count) {
        WFSectionListVC *vc = [[WFSectionListVC alloc] initWithSectionName:self.sections[indexPath.row].name];
        vc.pickerDelegate = _pickerDelegate;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSMutableDictionary<NSString *, id> *info = [NSMutableDictionary dictionary];
        [info setObject:_boards[indexPath.row - _sections.count] forKey:WFBoardPickerBoardKey];
        if ([self.pickerDelegate respondsToSelector:@selector(boardPicker:didFinishPickingWithInfo:)]) {
            [self.pickerDelegate boardPicker:nil didFinishPickingWithInfo:info];
        }
        [self dismiss];
    }
}

@end
