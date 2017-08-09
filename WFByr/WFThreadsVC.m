//
//  ASThreadsVC.m
//  ASByrApp
//
//  Created by andy on 16/4/14.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFReplyHeader.h"
#import "WFThreadsVC.h"
#import "WFReplyHeader.h"
#import "WFThreadsTitleCell.h"
#import "WFThreadsBodyCell.h"
#import "WFThreadsReplyCell.h"
#import "WFKeyboard.h"
#import "ASDebugger.h"
#import "MJRefresh.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "UIAlertController+Extension.h"
#import "WFFavoriteModule.h"
#import "WFModuleFactory.h"
#import "WFArticleApi.h"
#import "WFToken.h"
#import "WFThreadsCellDelegate.h"
#import "YYModel.h"
#import "IDMPhotoBrowser.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

const NSUInteger kTitleRow = 0;
const NSUInteger kBodyRow  = 1;
const NSUInteger kReplyRow = 2;


@interface WFThreadsVC ()<UITableViewDelegate, UITableViewDataSource, WFArticleResponseDelegate, WFArticleResponseReformer, WFKeyBoardDelegate, WFThreadsCellDelegate, WFRouterProtocol>

@property (nonatomic, strong) WFThread *thread;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) WFKeyboard * keyboard;
@property (nonatomic, strong) MBProgressHUD * hud;

@property (nonatomic, strong) UIBarButtonItem * moreOpBtn;
@property (nonatomic, strong) UIBarButtonItem * addFavBtn;

@property (nonatomic, strong) MBProgressHUD *endHud;
@property (nonatomic, strong) MBProgressHUD *replyStatusHud;

@property (nonatomic, strong) WFArticleApi * articleApi;
@property (nonatomic, copy)   NSString * board;
@property (nonatomic, assign) NSUInteger aid;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) ASThreadsEnterType threadType;
@property (nonatomic, assign) BOOL isLoadThreads;

@property (nonatomic, strong) NSDictionary * articleData;
@property (nonatomic, strong) NSMutableArray<WFArticle*> * articles;

@property (nonatomic, strong) WFPagination *pagination;

@property (nonatomic, strong) AVPlayer *avplayer;
@end

@implementation WFThreadsVC

#pragma mark - life cycle


- (instancetype)initWithParams:(NSDictionary *)params {
    NSString *board = params[@"board"];
    NSUInteger aid = [params[@"aid"] integerValue];
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
        self.articles = [NSMutableArray array];
        self.articleApi = [[WFArticleApi alloc] initWithAccessToken:[WFToken shareToken].accessToken];
        self.thread = nil;
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
    [self setupNavi];
}

- (void)setupNavi {
    self.navigationItem.title = @"详情";
    self.navigationItem.rightBarButtonItems = @[self.moreOpBtn, self.addFavBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_articles.count == 0) {
        [self.tableView.mj_header beginRefreshing];    
    }
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


#pragma mark - Private Method

- (void)refreshData{
    [self.tableView reloadData];
}

- (void)loadData {
    self.isLoadThreads = YES;

    [self.tableView.mj_footer resetNoMoreData];
    self.thread = nil;
    [self.articles removeAllObjects];
    self.page = 1;
    
    [self.articleApi fetchThreadsWithBoard:self.board aid:self.aid page:self.page];
}

- (void)moreData {
    self.isLoadThreads = NO;
    if (self.thread.pagination.page_all_count == self.page) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    [self.articleApi fetchThreadsWithBoard:self.board aid:self.aid page:++self.page];
}

- (void)moreOpBtnClicked {
    __weak typeof(self) wself = self;
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[@"hehe"] applicationActivities:nil];
        [wself presentViewController:activityVC animated:YES completion:nil];
    }];
    
    UIAlertAction *addFavAction = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(wself) sself = wself;
        if (sself == nil) return;
        id<WFFavoriteModule> favModule = [WFModuleFactory moduleWithProtocol:@"WFFavoriteModule"];
        [favModule addFavoriteWithArticle:sself.articles[0] success:^{
            wf_showHud(sself.view, @"收藏成功", 1);
        } failure:^{
            wf_showHud(sself.view, @"收藏失败", 1);
        }];
    }];
   
    UIAlertAction *replyAction = [UIAlertAction actionWithTitle:@"回复" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"reply");
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVC addAction:shareAction];
    [alertVC addAction:addFavAction];
    [alertVC addAction:replyAction];
    [alertVC addAction:cancleAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)addOrDeleteFav {
    id<WFFavoriteModule> favModule = [WFModuleFactory moduleWithProtocol:@"WFFavoriteModule"];
    __weak typeof(self) wself = self;
    if (_thread.collect) {
        [favModule deleteFavoriteWithArticle:self.articles[0] success:^{
            wf_showHud(wself.view, @"删除收藏成功", 1);
            wself.thread.collect = NO;
            [wself updateAddFavBtn];
        } failure:^{
            wf_showHud(wself.view, @"删除收藏失败", 1);
        }];
    } else {
        [favModule addFavoriteWithArticle:self.articles[0] success:^{
            wf_showHud(wself.view, @"收藏成功", 1);
            wself.thread.collect = YES;
            [wself updateAddFavBtn];
        } failure:^{
            wf_showHud(wself.view, @"收藏失败", 1);
        }];
    }
    
}

- (UIBarButtonItem*)addFavBtn {
    if (!_addFavBtn) {
        _addFavBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bookmark-add"] style:UIBarButtonItemStylePlain target:self action:@selector(addOrDeleteFav)];;
    }
    return _addFavBtn;
}

#pragma mark - TableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.keyboard popWithContext:@{@"replyTo":self.articles[indexPath.row + 1]}];
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
        return 0;
    }else if( section == kBodyRow) {
        return self.articles.count > 0 ? 1 : 0;
    }else{
        return [self.articles count] - 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == kTitleRow) {
        WFThreadsTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threadsTitle" forIndexPath:indexPath];
        cell.delegate = self;
        [cell setupWithTitle:self.articles[0].title];
        return cell;
    }else if(indexPath.section == kBodyRow){
        WFThreadsBodyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"threadsBody"];
        cell.delegate = self;
        [cell setupWithArticle:self.articles[0]];
        return cell;
    }else{
        WFThreadsReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threadsReply" forIndexPath:indexPath];
        cell.delegate = self;
        [cell setupWithArticle:self.articles[indexPath.row + 1] replyNo:indexPath.row + 1];
        
        
        //[[ASDebugger new] debug:self.articles[indexPath.row + 1].content];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.articles.count != 0 && section == kReplyRow) {
        return 30.0;
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == kReplyRow) {
        WFReplyHeader *header = [[NSBundle mainBundle] loadNibNamed:@"WFReplyHeader" owner:nil options:nil][0];;
        [header setupWithThread:self.thread];
        return header;
    }
    return nil;
}
#pragma mark - WFKeyBoardDelegate


- (void)sendAcionWithInput:(NSString *)input context:(id)context {
    NSInteger reid = ((WFArticle*)context[@"replyTo"]).aid;
    NSLog(@"%ld", reid);
    __weak typeof(self) weakSelf = self;
    [self.articleApi postArticleWithBoard:self.board title:@"" content:input reid:reid successBlock:^(NSInteger statusCode, id response) {
        wf_showHud(weakSelf.view, @"回复成功", 1);
    } failureBlock:^(NSInteger statusCode, id response) {
        wf_showHud(weakSelf.view, @"回复失败", 1);
    }];
}

- (void)moreAction:(id)context {
    [WFRouter go:@"post" withParams:@{@"article":context[@"replyTo"], @"input":context[@"currentInput"]} from:self];
}


#pragma mark - WFByrArticleResponseDelegate

- (void)fetchThreadsResponse:(WFResponse *)response {
    if (!response.isSucceeded) {
        [self presentViewController:[UIAlertController alertControllerWithBriefInfo:response.response[@"msg"]] animated:YES completion:nil];
        return;
    }
    [self.articles addObjectsFromArray:response.reformedData];
    self.keyboard.context = @{@"replyTo":self.articles[0], @"input":@""};
    [self.tableView reloadData];
    if (self.isLoadThreads) {
        [self.tableView.mj_header endRefreshing];
        [self addFavBtn];
    } else {
        [self.tableView.mj_footer endRefreshing];
    }
    [self.tableView layoutIfNeeded];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
}

#pragma mark - WFArticleResponseReformer

- (WFResponse*)reformThreadsResponse:(WFResponse *)response {
    if (response.isSucceeded) {
        NSMutableArray *reformedArticles = [NSMutableArray array];
       if (!_thread) _thread = [WFThread yy_modelWithJSON:response.response];
        [self updateAddFavBtn];
        @autoreleasepool {
            for (id article in [response.response objectForKey:@"article"]) {
                
                WFArticle *tmp = [WFArticle yy_modelWithJSON:article];
                [reformedArticles addObject:tmp];
            }
            response.reformedData = [reformedArticles copy];
        }
    }
    return response;
}

- (void)updateAddFavBtn {
    if (_thread.collect) {
        [self.addFavBtn setImage:[UIImage imageNamed:@"bookmark-added"]];
    } else {
        [self.addFavBtn setImage:[UIImage imageNamed:@"bookmark-add"]];
    }
}

#pragma mark - WFThreadsTitleCellDelegate

- (void)linkClicked:(NSURL *)url {
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

- (void)presentImageWithUrls:(NSArray *)urls selected:(NSInteger)index fromView:(UIView *)view {
    IDMPhotoBrowser *browser;
    if (view) {
       browser = [[IDMPhotoBrowser alloc] initWithPhotoURLs:urls animatedFromView:view];
    } else {
    browser = [[IDMPhotoBrowser alloc] initWithPhotoURLs:urls];
    }
    [browser setInitialPageIndex:index];
    [self presentViewController:browser animated:YES completion:nil];
}

- (void)goToUser:(NSString *)uid {
    [WFRouter go:@"/user" withParams:@{@"uid":uid} from:self];
}

- (void)playAudioWithUrl:(NSURL *)url {
    _avplayer = [AVPlayer playerWithURL:url];
    [_avplayer play];
}

#pragma mark - Getters and Setters

- (UIBarButtonItem*)moreOpBtn {
    if (_moreOpBtn == nil) {
        _moreOpBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreOpBtnClicked)];
    }
    return _moreOpBtn;
}


- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50.0;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
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
        _hud.label.text = @"Loading";
    }
    return _hud;
}

- (MBProgressHUD *)endHud {
    if (_endHud == nil) {
        _endHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _endHud.mode = MBProgressHUDModeText;
        _endHud.label.text = @"到底了";
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
