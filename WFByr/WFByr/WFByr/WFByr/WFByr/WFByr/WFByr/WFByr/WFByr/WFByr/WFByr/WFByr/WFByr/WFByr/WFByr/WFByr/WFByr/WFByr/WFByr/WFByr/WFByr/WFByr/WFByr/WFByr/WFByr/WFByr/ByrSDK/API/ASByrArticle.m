//
//  ASByrArticle.m
//  ASByr
//
//  Created by andy on 16/3/6.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrArticle.h"
#import "ASByrConfig.h"

@implementation ASByrArticle

- (ASByrArticle *)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    if (self) {
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
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/%ld", BYR_ARTICLE_URL, board, aid]
                      method:HTTP_GET
                  parameters:paramters
                    delegate:self.responseDelegate
                    callback:@selector(fetchAriticleResponse:)
                    reformer:self.responseReformer
                  reformFunc:@selector(reformArticleResponse:)];
}


#pragma mark - fetch article with block

- (void)fetchArticleWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                 successBlock:(ASSuccessCallback)success
                 failureBlock:(ASSuccessCallback)failure{
    [self fetchArticleWithBoard:board aid:aid mode:nil successBlock:success failureBlock:failure];
    
}

- (void)fetchArticleWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                         mode:(NSString *)mode
                 successBlock:(ASSuccessCallback)success
                 failureBlock:(ASSuccessCallback)failure{
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    if (mode) {
        [paramters setObject:mode forKey:@"mode"];
    }
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/%ld", BYR_ARTICLE_URL, board, aid]
                      method:HTTP_GET
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
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/%ld", BYR_THREADS_URL, board, aid]
                      method:HTTP_GET
                  parameters:paramters
                    delegate:self.responseDelegate
                    callback:@selector(fetchThreadsResponse:)
                    reformer:self.responseReformer
                  reformFunc:@selector(reformThreadsResponse:)];
    
}

#pragma mark - fetch threads with block

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                 successBlock:(ASSuccessCallback)success
                 failureBlock:(ASFailureCallback)failure {
    [self fetchThreadsWithBoard:board aid:aid au:nil count:10 page:1 successBlock:success failureBlock:failure];
    
}

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                         page:(NSInteger)page
                 successBlock:(ASSuccessCallback)success
                 failureBlock:(ASFailureCallback)failure {
    [self fetchThreadsWithBoard:board aid:aid au:nil count:10 page:page successBlock:success failureBlock:failure];
    
}

- (void)fetchThreadsWithBoard:(NSString *)board
                         aid:(NSInteger)aid
                          au:(NSString *)au
                       count:(NSInteger)count
                        page:(NSInteger)page
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASFailureCallback)failure{
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    if (au) {
        [paramters setObject:au forKey:@"au"];
    }
    [paramters setObject:count?[@(count) stringValue]:@"10" forKey:@"count"];
    [paramters setObject:page?[@(page) stringValue]:@"1" forKey:@"page"];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/%ld", BYR_THREADS_URL, board, aid] method:HTTP_GET parameters:paramters success:success failure:failure];
    
}

- (void)postArticleWithBoard:(NSString *)board
                       title:(NSString *)title
                     content:(NSString *)content
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASFailureCallback)failure {
    [self postArticleWithBoard:board title:title content:content reid:-1 successBlock:success failureBlock:failure];
}

- (void)postArticleWithBoard:(NSString *)board
                      title:(NSString *)title
                    content:(NSString *)content
                       reid:(NSInteger)reid
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASFailureCallback)failure {
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    if (reid >= 0) {
        [paramters setObject:[@(reid) stringValue] forKey:@"reid"];
    }
    [paramters setObject:title forKey:@"title"];
    [paramters setObject:content forKey:@"content"];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/post", BYR_ARTICLE_URL, board] method:HTTP_POST parameters:paramters success:success failure:failure];
}

- (void)forwardArticleWithBoard:(NSString *)board
                            aid:(NSInteger)aid
                         target:(NSString *)target
                   successBlock:(ASSuccessCallback)success
                   failureBlock:(ASFailureCallback)failure {
    
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
                   successBlock:(ASSuccessCallback)success
                   failureBlock:(ASFailureCallback)failure {
    
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
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/forward/%ld", BYR_ARTICLE_URL, board, aid] method:HTTP_POST parameters:paramters success:success failure:failure];
}

- (void)crossAticleWithBoard:(NSString *)board
                         aid:(NSInteger)aid
                      target:(NSString *)target
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASFailureCallback)failure {
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters setObject:target forKey:@"targer"];
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/cross/%ld", BYR_ARTICLE_URL, board, aid] method:HTTP_POST parameters:paramters success:success failure:failure];
}

- (void)updateArticleWithBoard:(NSString *)board
                           aid:(NSInteger)aid
                         title:(NSString *)title
                       content:(NSString *)content
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASFailureCallback)failure {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters setObject:title forKey:@"title"];
    [paramters setObject:content forKey:@"content"];
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/update/%ld", BYR_ARTICLE_URL, board, aid] method:HTTP_POST parameters:paramters success:success failure:failure];
}

- (void)deleteArticleWithBoard:(NSString *)board
                           aid:(NSInteger)aid
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASFailureCallback)failure {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/delete/%ld", BYR_ARTICLE_URL, board, aid] method:HTTP_POST parameters:nil success:success failure:failure];
}

@end
