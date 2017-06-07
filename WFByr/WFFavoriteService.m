//
//  WFFavoriteService.m
//  WFByr
//
//  Created by Andy on 2017/6/6.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFFavoriteService.h"
#import "WFModels.h"
#import "WFCollectionApi.h"

@interface WFFavoriteService ()

@property (nonatomic, strong)WFCollectionApi *collectionApi;

@end

@implementation WFFavoriteService

+ (instancetype)sharedService {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WFFavoriteService new];
    });
    return instance;
}

- (void)addFavoriteWithAricle:(WFArticle *)article success:(void (^)(void))successBlk failure:(void (^)(void))failureBlk {
    [self.collectionApi addCollectionWithBoard:article.board_name aid:@(article.aid).stringValue successBlock:^(NSInteger statusCode, id response) {
        if (successBlk) successBlk();
    } failureBlock:^(NSInteger statusCode, id response) {
        if (failureBlk) failureBlk();
    }];
}

- (void)deleteFavoriteWithAricle:(WFArticle *)article success:(void (^)(void))successBlk failure:(void (^)(void))failureBlk {
    [self.collectionApi deleteCollectionWithAid:@(article.aid).stringValue successBlock:^(NSInteger statusCode, id response) {
        if (successBlk) successBlk();
    } failureBlock:^(NSInteger statusCode, id response) {
        if (failureBlk) failureBlk();
    }];
}

# pragma mark - Setters and Getters

- (WFCollectionApi*)collectionApi {
    if (_collectionApi == nil) {
        _collectionApi = [[WFCollectionApi alloc] initWithAccessToken:[WFToken shareToken].accessToken];
    }
    return _collectionApi;
}

@end
