//
//  WFFavoriteDataCenter.m
//  WFByr
//
//  Created by lixiangqian on 17/6/3.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFFavoriteDataCenter.h"
#import "WFCollectionApi.h"

#import "WFPagination.h"
#import "WFCollection.h"
#import "WFToken.h"

#import <YYModel/YYModel.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation WFFavoriteDataCenter{
    NSInteger _count;
}

- (instancetype)init{
    if (self = [super init]) {
        _collectionList = [NSMutableArray array];
        _collectionApi = [[WFCollectionApi alloc]initWithAccessToken:[WFToken shareToken].accessToken];
        _page = 0;
        _count = 10;
        _maxPage = 0;
        [self setUp];
    }
    return self;
}

- (void)setUp{
    @weakify(self);
    [RACObserve(self, page) subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionApi fetchCollectionsWithCount:_count page:_page SuccessBlock:^(NSInteger statusCode, id response) {
            NSMutableArray<WFCollection*> * reformedArticles = [NSMutableArray array];
            for(NSDictionary * article in response[@"article"]){
                @autoreleasepool {
                    WFCollection * collection = [WFCollection yy_modelWithJSON:article];
                    [reformedArticles addObject:collection];
                }
            }
            if ([reformedArticles count] > 0) {
                self.collectionList = reformedArticles;
                //self.databaseArrayList = reformedArticles;
            }
            WFPagination * pagination = [WFPagination yy_modelWithDictionary:response[@"pagination"]];
            _maxPage = [NSNumber numberWithInteger:pagination.page_all_count];
        } failureBlock:nil];
    }];

}

@end
