//
//  ASThreadsVC.m
//  ASByrApp
//
//  Created by andy on 16/4/14.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFThreadsVC.h"
#import "WFThreadsTitleCell.h"
#import "WFThreadsBodyCell.h"
#import "WFThreadsReplyCell.h"
#import "WFKeyboard.h"
#import "ASDebugger.h"
#import "MJRefresh.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "UIAlertController+Extension.h"
#import "WFArticleApi.h"
#import "WFToken.h"
#import "YYModel.h"

const NSUInteger kTitleRow = 0;
const NSUInteger kBodyRow  = 1;
const NSUInteger kReplyRow = 2;


@interface WFThreadsVC ()<UITableViewDelegate, UITableViewDataSource, WFArticleResponseDelegate, WFArticleResponseReformer, WFKeyBoardDelegate, WFThreadsTitleCellDelegate,WFThreadsBodyCellDelegate, WFThreadsReplyCellDelegate, WFRouterProtocol>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) WFKeyboard * keyboard;
@property (nonatomic, strong) MBProgressHUD * hud;
@property (nonatomic, strong) UIBarButtonItem * moreOperBtn;

@property (nonatomic, strong) MBProgressHUD *endHud;
@property (nonatomic, strong) MBProgressHUD *replyStatusHud;

@property (nonatomic, strong) WFArticleApi * articleApi;
@property (nonatomic, copy)   NSString * board;
@property (nonatomic, assign) NSUInteger aid;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) ASThreadsEnterType threadType;
@property (nonatomic, assign) BOOL isLoadThreads;

@property (nonatomic, strong) NSDictionary * articleData;
@property (nonatomic, strong) NSMutableArray<WFArticle*> * replyArticles;

@property (nonatomic, strong) WFPagination *pagination;
@end

@implementation WFThreadsVC

#pragma mark - life cycle

+ (void)load {
    [WFRouter registerRoute:@"threads" withVC:[WFThreadsVC class]];
}


- (instancetype)initWithParams:(NSDictionary *)params {
    NSString *board = params[@"board"];
    NSUInteger aid = [params[@"aid"] integerValue];
    NSLog(@"%@,%ld", board, aid);
    return [self initWithWithBoard:board aid:aid];
}

- (instancetype)initWithWithBoard:(NSString *)board
                              aid:(NSUInteger)aid {
    
    self = [super init];
    if (self) {
        self.board = board;
        self.aid = aid;
        self.page = 1;
        self.isLoadThreads = YES;
        self.replyArticles = [NSMutableArray array];
        self.articleApi = [[WFArticleApi alloc] initWithAccessToken:[WFToken shareToken].accessToken];
        self.articleApi.responseDelegate = self;
        self.articleApi.responseReformer = self;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.keyboard];
    [self.view setNeedsUpdateConstraints];
    self.navigationItem.title = @"详情";
    
    //self.moreOperBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more.png"] style:UIBarButtonItemStylePlain target:self action:@selector(moreOperation)];
    //self.navigationItem.rightBarButtonItem = self.moreOperBtn;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    
    [self.tableView.mj_header beginRefreshing];
    //NSUInteger length = [self.navigationController.viewControllers count];
  
   // if([[self.navigationController.viewControllers objectAtIndex:(length-2)] isKindOfClass:[WFArticleListVC class]]){
    //    self.threadType = WFThreadsEnterTypeNormal;
    //    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //}else if([[self.navigationController.viewControllers objectAtIndex:(length-2)] isKindOfClass:[XQCollectArticleTVC class]]){
    //    self.threadType = WFThreadsEnterTypeCollection;
    //}
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.trailing.equalTo(self.view.mas_trailing);
        make.bottom.equalTo(self.view.mas_bottom);
        make.leading.equalTo(self.view.mas_leading);
    }];
   
    [super updateViewConstraints];
}

#pragma mark - private function

- (void)refreshData{
    [self.tableView reloadData];
}

- (void)loadData {
    self.isLoadThreads = YES;

    [self.tableView.mj_footer resetNoMoreData];
    [self.replyArticles removeAllObjects];
    self.page = 1;
    
    [self.articleApi fetchThreadsWithBoard:self.board aid:self.aid page:self.page];
}

- (void)moreData {
    self.isLoadThreads = NO;
    if (self.pagination.page_all_count == self.page) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    [self.articleApi fetchThreadsWithBoard:self.board aid:self.aid page:++self.page];
}



#pragma mark - TableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.keyboard popWithContext:@{@"replyTo":self.replyArticles[indexPath.row + 1]}];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.keyboard hide];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ( section == kTitleRow ){
        return self.replyArticles.count > 0 ? 1 : 0;
    }else if( section == kBodyRow) {
        return self.replyArticles.count > 0 ? 1 : 0;
    }else{
        return [self.replyArticles count] - 1;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == kTitleRow) {
        WFThreadsTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threadsTitle" forIndexPath:indexPath];
        cell.delegate = self;
        [cell setupWithTitle:self.replyArticles[0].title];
        return cell;
    }else if(indexPath.section == kBodyRow){
        WFThreadsBodyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"threadsBody"];
        cell.delegate = self;
        [cell setupWithContent:self.replyArticles[0].content];
        return cell;
    }else{
        WFThreadsReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threadsReply" forIndexPath:indexPath];
        cell.delegate = self;
        [cell setupWithArticle:self.replyArticles[indexPath.row + 1]];
        
        
        //[[ASDebugger new] debug:self.replyArticles[indexPath.row + 1].content];
        return cell;
    }
}

#pragma mark - WFKeyBoardDelegate


- (void)sendAcionWithInput:(NSString *)input context:(id)context {
    NSInteger reid = ((WFArticle*)context[@"replyTo"]).aid;
    NSLog(@"%ld", reid);
    __weak typeof(self) weakSelf = self;
    [self.articleApi postArticleWithBoard:self.board title:@"" content:input reid:reid successBlock:^(NSInteger statusCode, id response) {
        weakSelf.replyStatusHud.labelText = @"回复成功";
        [weakSelf.replyStatusHud show:YES];
        [weakSelf.replyStatusHud hide:YES afterDelay:1];
    } failureBlock:^(NSInteger statusCode, id response) {
        weakSelf.replyStatusHud.labelText = @"回复失败";
        [weakSelf.replyStatusHud show:YES];
        [weakSelf.replyStatusHud hide:YES afterDelay:1];
    }];
}

- (void)moreAction:(id)context {
    //[self.navigationController pushViewController:[[ASInputVC alloc] initWithReplyArticle:context[@"replyTo"] input:context[@"currentInput"]] animated:YES];
}


#pragma mark - WFByrArticleResponseDelegate

- (void)fetchThreadsResponse:(WFResponse *)response {
    if (!response.isSucceeded) {
        [self presentViewController:[UIAlertController alertControllerWithBriefInfo:response.response[@"msg"]] animated:YES completion:nil];
        return;
    }
    [self.replyArticles addObjectsFromArray:response.reformedData];
    [self.tableView reloadData];
    if (self.isLoadThreads) {
        [self.tableView.mj_header endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - ASByrArticleResponseReformer

- (WFResponse*)reformThreadsResponse:(WFResponse *)response {
    if (response.isSucceeded) {
        NSMutableArray *reformedArticles = [NSMutableArray array];
        
        @autoreleasepool {
            self.pagination = [WFPagination yy_modelWithJSON:[response.response objectForKey:@"pagination"]];
            for (id article in [response.response objectForKey:@"article"]) {
                WFArticle *tmp = [WFArticle yy_modelWithJSON:article];
                [reformedArticles addObject:tmp];
            }
            response.reformedData = [reformedArticles copy];
        }
    }
    return response;
}

#pragma mark - ASThreadsTitleCellDelegate

- (void)linkClicked:(NSURL *)url {
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

#pragma mark - ASThreadsBodyCellDelegate


#pragma mark - ASThreadsReplyCellDelegate


#pragma mark - WKWebViewNavigationDelegate

#pragma mark - getter and setter

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50.0;
        [_tableView registerNib:[UINib nibWithNibName:@"WFThreadsTitleCell" bundle:nil] forCellReuseIdentifier:@"threadsTitle"];
        [_tableView registerNib:[UINib nibWithNibName:@"WFThreadsBodyCell" bundle:nil] forCellReuseIdentifier:@"threadsBody"];
        [_tableView registerNib:[UINib nibWithNibName:@"WFThreadsReplyCell" bundle:nil] forCellReuseIdentifier:@"threadsReply"];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        _tableView.mj_header = header;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreData)];
        footer.automaticallyHidden = YES;
        _tableView.mj_footer = footer;
        
    }
    return _tableView;
}

- (WFKeyboard *)keyboard {
    if (_keyboard == nil) {
        _keyboard = [[WFKeyboard alloc] init];
        _keyboard.delegate = self;
    }
    return _keyboard;
}

- (MBProgressHUD *)hud {
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.mode = MBProgressHUDModeAnnularDeterminate;
        _hud.labelText = @"Loading";
    }
    return _hud;
}

- (MBProgressHUD *)endHud {
    if (_endHud == nil) {
        _endHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _endHud.mode = MBProgressHUDModeText;
        _endHud.labelText = @"到底了";
    }
    return _endHud;
}

- (MBProgressHUD *)replyStatusHud {
    if (_replyStatusHud == nil) {
        _replyStatusHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _replyStatusHud.mode = MBProgressHUDModeText;
    }
    return _replyStatusHud;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
