//
//  ASByrSearch.m
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrSearch.h"
#import "ASByrConfig.h"

@implementation ASByrSearch

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    return self;
}

- (void)searchBoardWithBoard:(NSString*)board
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASSuccessCallback)failure {
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:board forKey:@"board"];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@", BYR_SEARCH_URL, BYR_BOARD_URL] method:HTTP_GET parameters:parameters success:success failure:failure];
}


- (void)searchArticlesWithBoard:(NSString*)board
                         title1:(NSString*)title1
                         title2:(NSString*)title2
                         titlen:(NSString*)titlen
                         author:(NSString*)author
                            day:(NSInteger)day
                              m:(NSInteger)m
                              a:(NSInteger)a
                              o:(NSInteger)o
                          count:(NSInteger)count
                           page:(NSInteger)page
                   successBlock:(ASSuccessCallback)success
                   failureBlock:(ASSuccessCallback)failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:board forKey:@"board"];
    if (title1) {
        [parameters setObject:title1 forKey:@"title1"];
    }
    if (title2) {
        [parameters setObject:title2 forKey:@"title2"];
    }
    if (titlen) {
        [parameters setObject:titlen forKey:@"titlen"];
    }
    if (author) {
        [parameters setObject:author forKey:@"author"];
    }
    if (day > 0) {
        [parameters setObject:[@(day) stringValue] forKey:@"day"];
    } else {
        [parameters setObject:@"7" forKey:@"day"];
    }
    if (m >= 0) {
        [parameters setObject:[@(m) stringValue] forKey:@"m"];
    }
    if (a >= 0) {
        [parameters setObject:[@(a) stringValue] forKey:@"a"];
    }
    if (o >= 0) {
        [parameters setObject:[@(o) stringValue] forKey:@"o"];
    }
    if (count > 0) {
        [parameters setObject:[@(count) stringValue] forKey:@"count"];
    } else {
        [parameters setObject:@"30" forKey:@"count"];
    }
    if (page > 0) {
        [parameters setObject:[@(page) stringValue] forKey:@"page"];
    }
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@", BYR_SEARCH_URL, BYR_ARTICLE_URL] method:HTTP_GET parameters:parameters success:success failure:failure];
}


- (void)searchThreadsWithBoard:(NSString*)board
                        title1:(NSString*)title1
                        title2:(NSString*)title2
                        titlen:(NSString*)titlen
                        author:(NSString*)author
                           day:(NSInteger)day
                             m:(NSInteger)m
                             a:(NSInteger)a
                         count:(NSInteger)count
                          page:(NSInteger)page
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASSuccessCallback)failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:board forKey:@"board"];
    if (title1) {
        [parameters setObject:title1 forKey:@"title1"];
    }
    if (title2) {
        [parameters setObject:title2 forKey:@"title2"];
    }
    if (titlen) {
        [parameters setObject:titlen forKey:@"titlen"];
    }
    if (author) {
        [parameters setObject:author forKey:@"author"];
    }
    if (day > 0) {
        [parameters setObject:[@(day) stringValue] forKey:@"day"];
    } else {
        [parameters setObject:@"7" forKey:@"day"];
    }
    if (m >= 0) {
        [parameters setObject:[@(m) stringValue] forKey:@"m"];
    }
    if (a >= 0) {
        [parameters setObject:[@(a) stringValue] forKey:@"a"];
    }
    if (count > 0) {
        [parameters setObject:[@(count) stringValue] forKey:@"count"];
    } else {
        [parameters setObject:@"30" forKey:@"count"];
    }
    if (page > 0) {
        [parameters setObject:[@(page) stringValue] forKey:@"page"];
    }
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@", BYR_SEARCH_URL, BYR_THREADS_URL] method:HTTP_GET parameters:parameters success:success failure:failure];
}
@end
