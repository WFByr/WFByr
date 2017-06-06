//
//  WFFavoriteVC.m
//  WFByr
//
//  Created by lixiangqian on 17/6/2.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFFavoriteVC.h"
#import "WFFavoriteCell.h"
#import "WFCollectionApi.h"
#import "WFCollection.h"
#import "WFToken.h"
#import "WFRouter.h"
#import "WFArticle.h"

#import "WFFavoriteDataCenter.h"
#import "MJRefresh.h"
#import "YYModel.h"
#import "WFTop10SeperatorCell.h"

#import <SDWebImage/SDImageCache.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface WFFavoriteVC ()<UITableViewDelegate, UITableViewDataSource, WFCollectionResponseDelegate, WFCollectionResponseReformer>

@property (strong, nonatomic) WFFavoriteDataCenter * dataCenter;

@property (strong, nonatomic) NSMutableArray * collectionList;

@end

@implementation WFFavoriteVC

static NSString * const reuseIdentifier = @"com.BUPT.WFByr.WFFavoriteCell";

static NSString * const seperatorCellReuseIdentifier = @"com.BUPT.WFByr.WFSeperatorCell";

NSString * const addCollectArcNotification = @"com.BUPT.WFByr.WFAddCollection";

NSString * const deleteCollectArcNotification = @"com.BUPT.WFByr.WFDeleteCollection";


- (instancetype)init{
    self = [super init];
    if (self) {
        _collectionList = [NSMutableArray array];
        _dataCenter = [[WFFavoriteDataCenter alloc]init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addCollectArticle:) name:addCollectArcNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteCollectArticle:) name:deleteCollectArcNotification object:nil];
        [self.tableView registerClass:[WFFavoriteCell class] forCellReuseIdentifier:reuseIdentifier];
        [self.tableView registerNib:[UINib nibWithNibName:@"WFTop10SeperatorCell" bundle:nil] forCellReuseIdentifier:seperatorCellReuseIdentifier];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreData)];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        self.tableView.estimatedRowHeight = 110;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.navigationItem setTitle:@"收藏"];
    [RACObserve(self.dataCenter, collectionList) subscribeNext:^(id x) {
        [self updateView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)loadData{
    [self.collectionList removeAllObjects];
    self.dataCenter.page = 0;
}

- (void)moreData{
    if (!self.dataCenter.maxPage ||self.dataCenter.maxPage == (id)[NSNull null] || self.dataCenter.page < [self.dataCenter.maxPage integerValue]) {
        self.dataCenter.page = [[NSNumber numberWithInteger:self.dataCenter.page] integerValue] + 1;
    }else{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)updateView{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self.collectionList addObjectsFromArray:self.dataCenter.collectionList];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        WFFavoriteCell *cell = (WFFavoriteCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[WFFavoriteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        
        [cell setUpParameters:self.collectionList[indexPath.row]];
        
        return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WFCollection * targetArticle = (WFCollection *)self.collectionList[indexPath.row];
    [WFRouter go:@"threads" withParams:@{@"aid":targetArticle.gid, @"board":targetArticle.bname} from:self];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.collectionList count];
}
#pragma mark private method

- (void)addCollectArticle:(NSNotification *)notis{
    NSLog(@"添加通知激活！");
    WFArticle * article = notis.userInfo[@"article"];
    [self.dataCenter.collectionApi addCollectionWithBoard:article.board_name aid:[NSString stringWithFormat:@"%ld",(long)article.group_id] successBlock:^(NSInteger statusCode, id response) {
        NSLog(@"添加收藏请求成功");
    } failureBlock:^(NSInteger statusCode, id response) {
        NSLog(@"添加收藏请求失败");
    }];
}

- (void)deleteCollectArticle:(NSNotification *)notis{
    NSLog(@"删除通知激活！");
    WFArticle * article = notis.userInfo[@"article"];
    [self.dataCenter.collectionApi deleteCollectionWithAid:[NSString stringWithFormat:@"%ld",(long)article.group_id] successBlock:^(NSInteger statusCode, id response) {
        NSLog(@"删除收藏请求成功.");
        
    } failureBlock:^(NSInteger statusCode, id response) {
        NSLog(@"删除收藏请求失败. statusCode:%ld",(long)statusCode);
    }];
}

#pragma mark getter and setter

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addNewCollectedArticle" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"deleteCollectedArticle" object:nil];
}

@end
