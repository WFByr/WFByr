//
//  ASByrArticle.m
//  ASByr
//
//  Created by andy on 16/3/6.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFArticleApi.h"
#import "WFModels.h"
#import "YYModel.h"
#import "WFByrConst.h"

@interface WFArticleReformer : NSObject <WFArticleResponseReformer>

@end

@implementation WFArticleReformer

- (WFResponse*)reformThreadsResponse:(WFResponse *)response {
    if (response.isSucceeded) {
        NSMutableArray *reformedArticles = [NSMutableArray array];
        WFPagination *pagination = [WFPagination yy_modelWithJSON:[response.response objectForKey:@"pagination"]];
        for (id article in [response.response objectForKey:@"article"]) {
            @autoreleasepool {
                WFArticle *tmp = [WFArticle yy_modelWithJSON:article];
                [reformedArticles addObject:tmp];
            }
            response.reformedData = [reformedArticles copy];
        }
    }
    return response;
}

@end


@implementation WFArticleApi {
    WFArticleReformer *_defaultReformer;
}

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    if (self) {
        _defaultReformer = [WFArticleReformer new];
        self.responseDelegate = nil;
        self.responseReformer = nil;
    }
    return self;
}

#pragma mark - fetch article with delegate

- (void)fetchArticleWithBoard:(NSString *)board
                          aid:(NSInteger)aid {
    [self fetchArticleWithBoard:board aid:aid mode:nil];
}

- (void)fetchArticleWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                         mode:(NSString *)mode {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    if (mode) {
        [paramters setObject:mode forKey:@"mode"];
    }
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/%ld", WFByrArticleUrl, board, aid]
                      method:WFHTTPGet
                  parameters:paramters
                    delegate:self.responseDelegate
                    callback:@selector(fetchAriticleResponse:)
                    reformer:self.responseReformer
                  reformFunc:@selector(reformArticleResponse:)];
}


#pragma mark - fetch article with block

- (void)fetchArticleWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                 successBlock:(WFSuccessCallback)success
                 failureBlock:(WFSuccessCallback)failure{
    [self fetchArticleWithBoard:board aid:aid mode:nil successBlock:success failureBlock:failure];
    
}

- (void)fetchArticleWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                         mode:(NSString *)mode
                 successBlock:(WFSuccessCallback)success
                 failureBlock:(WFSuccessCallback)failure{
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    if (mode) {
        [paramters setObject:mode forKey:@"mode"];
    }
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/%ld", WFByrArticleUrl, board, aid]
                      method:WFHTTPGet
                  parameters:paramters
                     success:success
                     failure:failure];
}


#pragma mark - fetch threads with delegate

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid {
   [self fetchThreadsWithBoard:board aid:aid au:nil count:10 page:1];
}

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                         page:(NSInteger)page {
    [self fetchThreadsWithBoard:board aid:aid au:nil count:10 page:page];
}

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                           au:(NSString *)au
                        count:(NSInteger)count
                         page:(NSInteger)page {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    if (au) {
        [paramters setObject:au forKey:@"au"];
    }
    [paramters setObject:count?[@(count) stringValue]:@"10" forKey:@"count"];
    [paramters setObject:page?[@(page) stringValue]:@"1" forKey:@"page"];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/%ld", WFByrThreadsUrl, board, aid]
                      method:WFHTTPGet
                  parameters:paramters
                    delegate:self.responseDelegate
                    callback:@selector(fetchThreadsResponse:)
                    reformer:self.responseReformer
                  reformFunc:@selector(reformThreadsResponse:)];
    
}

#pragma mark - fetch threads with block

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                 successBlock:(WFSuccessCallback)success
                 failureBlock:(WFFailureCallback)failure {
    [self fetchThreadsWithBoard:board aid:aid au:nil count:10 page:1 successBlock:success failureBlock:failure];
    
}

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                         page:(NSInteger)page
                 successBlock:(WFSuccessCallback)success
                 failureBlock:(WFFailureCallback)failure {
    [self fetchThreadsWithBoard:board aid:aid au:nil count:10 page:page successBlock:success failureBlock:failure];
    
}

- (void)fetchThreadsWithBoard:(NSString *)board
                         aid:(NSInteger)aid
                          au:(NSString *)au
                       count:(NSInteger)count
                        page:(NSInteger)page
                successBlock:(WFSuccessCallback)success
                failureBlock:(WFFailureCallback)failure{
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    if (au) {
        [paramters setObject:au forKey:@"au"];
    }
    [paramters setObject:count?[@(count) stringValue]:@"10" forKey:@"count"];
    [paramters setObject:page?[@(page) stringValue]:@"1" forKey:@"page"];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/%ld", WFByrThreadsUrl, board, aid] method:WFHTTPGet parameters:paramters success:success failure:failure];
    
}

- (void)postArticleWithBoard:(NSString *)board
                       title:(NSString *)title
                     content:(NSString *)content
                successBlock:(WFSuccessCallback)success
                failureBlock:(WFFailureCallback)failure {
    [self postArticleWithBoard:board title:title content:content reid:-1 successBlock:success failureBlock:failure];
}

- (void)postArticleWithBoard:(NSString *)board
                      title:(NSString *)title
                    content:(NSString *)content
                       reid:(NSInteger)reid
                successBlock:(WFSuccessCallback)success
                failureBlock:(WFFailureCallback)failure {
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    if (reid >= 0) {
        [paramters setObject:[@(reid) stringValue] forKey:@"reid"];
    }
    [paramters setObject:title forKey:@"title"];
    [paramters setObject:content forKey:@"content"];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/post", WFByrArticleUrl, board] method:WFHTTPPost parameters:paramters success:success failure:failure];
}

- (void)forwardArticleWithBoard:(NSString *)board
                            aid:(NSInteger)aid
                         target:(NSString *)target
                   successBlock:(WFSuccessCallback)success
                   failureBlock:(WFFailureCallback)failure {
    
    [self forwardArticleWithBoard:board aid:aid target:target threads:NO noref:NO noatt:NO noansi:NO big5:NO successBlock:success failureBlock:failure];

}

- (void)forwardArticleWithBoard:(NSString *)board
                            aid:(NSInteger)aid
                         target:(NSString *)target
                        threads:(BOOL)threads
                         noref:(BOOL)noref
                          noatt:(BOOL)noatt
                         noansi:(BOOL)noansi
                           big5:(BOOL)big5
                   successBlock:(WFSuccessCallback)success
                   failureBlock:(WFFailureCallback)failure {
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    if (threads) {
        [paramters setObject:[@(1) stringValue] forKey:@"threads"];
    }
    if (noref) {
        [paramters setObject:[@(1) stringValue] forKey:@"noref"];
    }
    if (noatt) {
        [paramters setObject:[@(1) stringValue] forKey:@"noatt"];
    }
    if (noansi) {
        [paramters setObject:[@(1) stringValue] forKey:@"noansi"];
    }
    if (big5) {
        [paramters setObject:[@(1) stringValue] forKey:@"big5"];
    }
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/forward/%ld", WFByrArticleUrl, board, aid] method:WFHTTPPost parameters:paramters success:success failure:failure];
}

- (void)crossAticleWithBoard:(NSString *)board
                         aid:(NSInteger)aid
                      target:(NSString *)target
                successBlock:(WFSuccessCallback)success
                failureBlock:(WFFailureCallback)failure {
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters setObject:target forKey:@"targer"];
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/cross/%ld", WFByrArticleUrl, board, aid] method:WFHTTPPost parameters:paramters success:success failure:failure];
}

- (void)updateArticleWithBoard:(NSString *)board
                           aid:(NSInteger)aid
                         title:(NSString *)title
                       content:(NSString *)content
                  successBlock:(WFSuccessCallback)success
                  failureBlock:(WFFailureCallback)failure {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters setObject:title forKey:@"title"];
    [paramters setObject:content forKey:@"content"];
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/update/%ld", WFByrArticleUrl, board, aid] method:WFHTTPPost parameters:paramters success:success failure:failure];
}

- (void)deleteArticleWithBoard:(NSString *)board
                           aid:(NSInteger)aid
                  successBlock:(WFSuccessCallback)success
                  failureBlock:(WFFailureCallback)failure {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/delete/%ld", WFByrArticleUrl, board, aid] method:WFHTTPPost parameters:nil success:success failure:failure];
}

@end
