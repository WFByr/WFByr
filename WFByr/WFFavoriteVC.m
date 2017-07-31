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

#import "ReactiveCocoa.h"

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
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
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
    self.dataCenter.page = 1;
}

- (void)moreData{
    if (!self.dataCenter.maxPage ||self.dataCenter.maxPage == (id)[NSNull null] || self.dataCenter.page < [self.dataCenter.maxPage integerValue]) {
        self.dataCenter.page = self.dataCenter.page + 1;
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

# pragma mark - TableView delegate



# pragma mark - Table view data source

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    return @[[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        WFCollection *collection = _collectionList[indexPath.row];
        [weakSelf.dataCenter deleteCollection:collection.gid successBlk:^(NSInteger statusCode, id response){
            wf_showHud(weakSelf.view, @"删除成功", 1);
        } failureBlk:^(NSInteger statusCode, id reponse) {
            wf_showHud(weakSelf.view, @"删除失败", 1);
        }];
        [_collectionList removeObjectAtIndex:indexPath.row];
        [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        WFFavoriteCell *cell = (WFFavoriteCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
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
    [self.dataCenter.collectionApi addCollectionWithBoard:article.board_name aid:[NSString stringWithFormat:@"%ld", article.group_id] successBlock:^(NSInteger statusCode, id response) {
        NSLog(@"添加收藏请求成功");
    } failureBlock:^(NSInteger statusCode, id response) {
        NSLog(@"添加收藏请求失败");
    }];
}

- (void)deleteCollectArticle:(NSNotification *)notis{
    NSLog(@"删除通知激活！");
    WFArticle * article = notis.userInfo[@"article"];
    [self.dataCenter.collectionApi deleteCollectionWithAid:[NSString stringWithFormat:@"%ld", article.group_id] successBlock:^(NSInteger statusCode, id response) {
        NSLog(@"删除收藏请求成功.");
        
    } failureBlock:^(NSInteger statusCode, id response) {
        NSLog(@"删除收藏请求失败. statusCode:%ld",(long)statusCode);
    }];
}

#pragma mark getter and setter

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:addCollectArcNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:deleteCollectArcNotification object:nil];
}

@end
