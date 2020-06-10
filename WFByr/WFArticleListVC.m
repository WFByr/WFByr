//
//  ASArticleListVC.m
//  ASByrApp
//
//  Created by andy on 16/4/18.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFArticleListVC.h"
#import "WFBoardPicker.h"
#import "WFArticleCell.h"
#import "WFModels.h"
#import "WFToken.h"
#import "WFBoardApi.h"
#import "MJRefresh.h"
#import "YYModel.h"
#import "Masonry.h"

@interface WFArticleListVC()<UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate,WFBoardResponseDelegate, WFBoardResponseReformer, WFBoardPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<WFArticle*> *articles;

@property(strong, nonatomic) UINavigationController * sectionListVC;
@property(strong, nonatomic) UIBarButtonItem *addPostBtn;
@property(strong, nonatomic) UIBarButtonItem *sectionListBtn;

@property(strong, nonatomic) WFBoard * lastViewBoard;
@property(strong, nonatomic) WFBoardApi * boardApi;
@property(copy, nonatomic) NSString *boardName;
@property (copy, nonatomic) NSString *boardTitle;
@property(assign, nonatomic) NSInteger page;
@property(assign, nonatomic) BOOL firstLoaded;

@end


@implementation WFArticleListVC {
    BOOL _isLoaded;
}

- (instancetype)initWithBoardName:(NSString*)name boardTitle:(NSString *)boardTitle {
    self = [super init];
    if (self != nil) {
        self.boardName = name;
        self.boardTitle = boardTitle;
        self.navigationItem.title = boardTitle;
        _isLoaded = false;
    }
    return self;
}

# pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.sectionListBtn;
    [self.view addSubview:self.tableView];
    [self.view setNeedsUpdateConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_isLoaded) {
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

# pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WFArticle *article = self.articles[indexPath.row];
    NSDictionary *params = @{@"aid":@(article.aid), @"board":article.board_name};
    [WFRouter go:@"threads" withParams:params from:self];
}


# pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WFArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WFArticleCell"];
    WFArticle *article = self.articles[indexPath.row];
    [cell setupWithArticle:article];
    return cell;
}

# pragma mark - WFBoardPickerDelegate

- (void)boardPicker:(id)boardPicker didFinishPickingWithInfo:(NSDictionary<NSString *,id> *)info {
    WFBoard *pickedBoard = [info objectForKey:WFBoardPickerBoardKey];
    self.boardName = pickedBoard.name;
    self.navigationItem.title = pickedBoard.desc;
    [[NSUserDefaults standardUserDefaults] setObject:pickedBoard.name?:@"" forKey:WFByrDefaultShowBoardNameKey];
    [[NSUserDefaults standardUserDefaults] setObject:pickedBoard.desc?:@"" forKey:WFByrDefaultShowBoardTitleKey];
    //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self loadData];
}

# pragma mark - WFBoardResponseDelegate

- (void)fetchBoardResponse:(WFResponse*)response {
    _isLoaded = true;
    [self.articles addObjectsFromArray:response.reformedData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

# pragma mark - WFBoardResponseReform

- (WFResponse *)reformBoardResponse:(WFResponse *)response{
    return [self commonReformer:response];
}

- (WFResponse *)commonReformer:(WFResponse *)response{
    if (response.statusCode >= 200 && response.statusCode < 300) {
        NSMutableArray<WFArticle*> * reformedData = [[NSMutableArray alloc] init];
        for (NSDictionary* article in response.response[@"article"]) {
            [reformedData addObject:[WFArticle yy_modelWithDictionary:article]];
        }
        response.reformedData = [reformedData copy];
        response.isSucceeded = YES;
    } else {
        response.isSucceeded = NO;
    }
    return response;
}

# pragma mark - Private methods

- (void)loadData {
    self.articles = [NSMutableArray array];
    self.page = 1;
    [self.boardApi fetchBoard:self.boardName pageNumber:self.page];
}

- (void)moreData {
    self.page++;
    [self.boardApi fetchBoard:self.boardName pageNumber:self.page];
}

- (void)sectionListBtnClicked {
    WFBoardPicker *vc = [WFBoardPicker new];
    vc.pickerDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

# pragma mark - Setters and Getters

- (NSMutableArray*)articles {
    if (_articles == nil) {
        _articles = [NSMutableArray array];
    }
    return _articles;
}

- (WFBoardApi*)boardApi {
    if (_boardApi == nil) {
        _boardApi = [[WFBoardApi alloc] init];
        _boardApi.responseDelegate = self;
        _boardApi.responseReformer = self;
    }
    return _boardApi;
}

- (UITableView*)tableView {
    if (_tableView == nil) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50.0;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_tableView registerNib:[UINib nibWithNibName:@"WFArticleCell" bundle:nil] forCellReuseIdentifier:@"WFArticleCell"];

        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        _tableView.mj_header = header;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreData)];
        footer.automaticallyHidden = YES;
        _tableView.mj_footer = footer;
    }
    return _tableView;
}

- (UIBarButtonItem*)sectionListBtn {
    if (_sectionListBtn == nil) {
        _sectionListBtn = [[UIBarButtonItem alloc] initWithTitle:@"选择版面" style:UIBarButtonItemStylePlain target:self action:@selector(sectionListBtnClicked)];
    }
    return _sectionListBtn;
}

@end
