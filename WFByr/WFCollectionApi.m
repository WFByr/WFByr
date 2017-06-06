//
//  WFCollectionApi.m
//  WFByr
//
//  Created by lixiangqian on 17/6/3.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFCollectionApi.h"
#import "WFByrConst.h"

@implementation WFCollectionApi

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    self.responseDelegate = nil;
    self.responseReformer = nil;
    return self;
}

- (void)fetchCollectionsWithCount:(NSInteger)count page:(NSInteger)page SuccessBlock:(WFSuccessCallback)success
                     failureBlock:(WFFailureCallback)failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[@(count) stringValue] forKey:@"count"];
    [parameters setObject:[@(page) stringValue] forKey:@"page"];
    [self sendRequestWithUrl:WFByrCollectionUrl method:WFHTTPGet parameters:parameters success:success failure:failure];
}

- (void)fetchCollectionsWithCount:(NSInteger)count
                             page:(NSInteger)page{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (count > 0) {
        [parameters setObject:[@(count) stringValue] forKey:@"count"];
    }
    if (page > 0) {
        [parameters setObject:[@(page) stringValue] forKey:@"page"];
    }
    [self sendRequestWithUrl:WFByrCollectionUrl method:WFHTTPGet parameters:parameters delegate:self.responseDelegate callback:@selector(fetchCollectionsResponse:) reformer:self.responseReformer reformFunc:@selector(reformCollectionResponse:)];
}

- (void)addCollectionWithBoard:(NSString *)board
                           aid:(NSString *)aid
                  successBlock:(WFSuccessCallback)success
                  failureBlock:(WFFailureCallback)failure {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:board, @"board", aid, @"id", nil];
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/add", WFByrCollectionUrl] method:WFHTTPGet parameters:parameters success:success failure:failure];
}

- (void)deleteCollectionWithAid:(NSString *)aid
                   successBlock:(WFSuccessCallback)success
                   failureBlock:(WFFailureCallback)failure {
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:aid forKey:@"id"];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/delete", WFByrCollectionUrl] method:WFHTTPPost parameters:parameters success:success failure:failure];
}

@end
