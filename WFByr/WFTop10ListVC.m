//
//  ASTop10ListController.m
//  ASByrApp
//
//  Created by andy on 16/4/4.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFTop10ListVC.h"
#import "WFTop10Cell.h"
#import "WFTop10SeperatorCell.h"
//#import "WFThreadsController.h"
#import "WFToken.h"
#import "WFWidgetApi.h"
#import "WFModels.h"
#import "MJRefresh.h"
#import "YYModel.h"
#import "WFRouter.h"
#import "UIView+NoDataDefaultView.h"

static NSString * const WFTop10CellReuseId          = @"WFTop10Cell";
static NSString * const WFTop10SeperatorCellReuseId = @"WFTop10SeperatorCell";

@interface WFTop10ListVC()<WFWidgetResponseDelegate, WFWidgetResponseReformer>

@property(nonatomic, strong) WFWidgetApi *widgerApi;

@property(nonatomic, assign) WFTop10Type top10Type;

@property(nonatomic, strong) NSArray<WFArticle *> * top10;

@property(nonatomic, assign) NSInteger sectionNo;

@end

@implementation WFTop10ListVC {
    BOOL _isLoaded;
}

- (instancetype)initWithTitle:(NSString *)title
                    top10Type:(WFTop10Type)top10Type
                    sectionNo:(NSInteger)section{
    self = [super init];
    if (self) {
        self.sectionNo = section;
        self.top10Type = top10Type;
        self.title = @"十大";
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100.0;
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.tableView setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.96 alpha:1.00]];
        //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerNib:[UINib nibWithNibName:@"WFTop10Cell" bundle:nil] forCellReuseIdentifier:WFTop10CellReuseId];
        [self.tableView registerNib:[UINib nibWithNibName:@"WFTop10SeperatorCell" bundle:nil] forCellReuseIdentifier:WFTop10SeperatorCellReuseId];
        
        _isLoaded = false;
    }
    return self;
}

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreData)];
    self.tableView.mj_footer.hidden = YES;
    
    self.widgerApi = [[WFWidgetApi alloc] initWithAccessToken:[WFToken shareToken].accessToken];
    self.widgerApi.responseDelegate = self;
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_isLoaded) {
        [self.tableView.mj_header beginRefreshing];
    }
}


# pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.top10 count] * 2 - 1;
//    return [self.top10 count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    WFTop10Cell *cell = (WFTop10Cell*)[tableView dequeueReusableCellWithIdentifier:WFTop10CellReuseId];
//    [cell setupWithArticle:self.top10[indexPath.row] num:indexPath.row];
//    return cell;
    if (indexPath.row % 2 == 0) {
        WFTop10Cell *cell = (WFTop10Cell*)[tableView dequeueReusableCellWithIdentifier:WFTop10CellReuseId];
        [cell setupWithArticle:self.top10[indexPath.row / 2] num:indexPath.row / 2 + 1];
        return cell;
    } else {
        WFTop10SeperatorCell *cell = (WFTop10SeperatorCell*)[tableView dequeueReusableCellWithIdentifier:WFTop10SeperatorCellReuseId];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return UITableViewAutomaticDimension;
    } else {
        return 6;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    WFArticle *targetArticle = self.top10[indexPath.row];
    WFArticle *targetArticle = self.top10[indexPath.row / 2];
    [WFRouter go:@"threads" withParams:@{@"aid":@(targetArticle.aid), @"board":targetArticle.board_name} from:self];
}



# pragma mark - private function

- (void)loadData {
    switch (self.top10Type) {
        case ASSectionTop:
            [self.widgerApi fetchSectionTopWithSectionNo:self.sectionNo];
            break;
        case ASRecommend:
            [self.widgerApi fetchRecommend];
            break;
        default:
            [self.widgerApi fetchTop10];
            break;
    }
}

- (void)moreData {
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark - ASByrWidgetResponseDelegate

- (void)fetchTop10Response:(WFResponse *)response {
    [self commonResponseRecv:response];
}

- (void)fetchRecommendResponse:(WFResponse *)response {
    [self commonResponseRecv:response];
}

- (void)fetchSectionTopResponse:(WFResponse *)response {
    [self commonResponseRecv:response];
}

- (void)commonResponseRecv:(WFResponse*)response {
    self.top10 = response.reformedData;
    [self.tableView configNoDataDefaultViewWithViewType:NoDataDefaultViewTypeNoData isHasData:self.top10.count > 0 handle:nil];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    _isLoaded = true;
}


@end
