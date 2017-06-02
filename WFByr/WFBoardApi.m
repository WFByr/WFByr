//
//  ASByrBoard.m
//  ASByr
//
//  Created by andy on 16/3/9.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFBoardApi.h"
#import "WFByrConst.h"

@implementation WFBoardApi

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    return self;
}

- (void)fetchBoard:(NSString *)name pageNumber:(NSInteger)page{
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    
    [paramters setObject:page?[@(page) stringValue]:@"1" forKey:@"page"];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@", WFByrBoardUrl, name]
                      method:WFHTTPGet
                  parameters:paramters
                    delegate:self.responseDelegate
                    callback:@selector(fetchBoardResponse:)
                    reformer:self.responseReformer
                  reformFunc:@selector(reformBoardResponse:)];

}

- (void)fetchSectionInfoWithName:(NSString *)name
                    successBlock:(WFSuccessCallback)success
                    failureBlock:(WFFailureCallback)failure {
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:name forKey:@"name"];
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@", WFByrSectionUrl, name] method:WFHTTPGet parameters:parameters success:success failure:failure];
}

- (void)fetchRootSectionsWithSuccessBlock:(WFSuccessCallback)success
                             failureBlock:(WFFailureCallback)failure {
    [self sendRequestWithUrl:WFByrSectionUrl method:WFHTTPGet parameters:nil success:success failure:failure];
}

//按发表顺序读取文章列表
- (void)fetchBoardPostLineInfoWithName:(NSString *)name
                        successBlock:(WFSuccessCallback)success
                        failureBlock:(WFFailureCallback)failure {
    [self fetchBoardInfoWithName:name mode:6 count:30 page:1 successBlock:success failureBlock:failure];
}

//按web顺序读取文章列表
- (void)fetchBoardDetailInfoWithName:(NSString *)name
                              page:(NSInteger)page
                      successBlock:(WFSuccessCallback)success
                      failureBlock:(WFFailureCallback)failure {
    [self fetchBoardInfoWithName:name mode:2 count:30 page:page successBlock:success failureBlock:failure];
}

- (void)fetchBoardInfoWithName:(NSString *)name
                          mode:(NSInteger)mode
                         count:(NSInteger)count
                          page:(NSInteger)page
                  successBlock:(WFSuccessCallback)success
                  failureBlock:(WFFailureCallback)failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (mode >= 0) {
        [parameters setObject:[@(mode) stringValue] forKey:@"mode"];
    }
    if (count > 0) {
        [parameters setObject:[@(count) stringValue] forKey:@"count"];
    }
    if (page > 0) {
        [parameters setObject:[@(page) stringValue] forKey:@"page"];
    }
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@", WFByrBoardUrl, name] method:WFHTTPGet parameters:parameters success:success failure:failure];
}


@end
