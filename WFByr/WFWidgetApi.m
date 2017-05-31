//
//  ASByrWidget.m
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFByrConst.h"
#import "WFWidgetApi.h"
#import "WFArticle.h"
#import "YYModel.h"


@interface WFWidgetReformer : NSObject

@end

@implementation WFWidgetReformer

#pragma mark - ASByrWidgetResponseReformer

- (WFResponse*)reformTop10Response:(WFResponse *)response {
    return [self wf_reform:response];
}

- (WFResponse*)reformRecommendResponse:(WFResponse *)response {
    return [self wf_reform:response];
}

- (WFResponse*)reformSectionTopResponse:(WFResponse *)response {
    return [self wf_reform:response];
}

- (WFResponse*)wf_reform:(WFResponse *)response {
    if (response.statusCode >= 200 && response.statusCode < 300) {
        NSMutableArray * reformedData = [[NSMutableArray alloc] init];
        @autoreleasepool {
            for (id article in response.response[@"article"]) {
                WFArticle *reformedArticle = [WFArticle yy_modelWithJSON:article];
                [reformedData addObject:reformedArticle];
            }
            response.reformedData = [reformedData copy];
        }
        response.isSucceeded = YES;
    } else {
        response.isSucceeded = NO;
    }
    return response;
}

@end


@interface WFWidgetApi ()

@end


@implementation WFWidgetApi {
    WFWidgetReformer *_defaultReformer;
}

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    _defaultReformer = [WFWidgetReformer new];
    self.responseReformer = _defaultReformer;
    return self;
}


- (void)fetchTop10{
    void (^callback)(NSInteger, id) = ^(NSInteger statusCode, id response) {
        WFResponse *byrResponse = [[WFResponse alloc] init];
        byrResponse.statusCode = statusCode;
        byrResponse.response   = response;
        if (self.responseReformer) {
            byrResponse = [self.responseReformer reformSectionTopResponse:byrResponse];
        }
        [self.responseDelegate fetchTop10Response:byrResponse];
    };
    [self fetchTop10WithSuccessBlock:callback failureBlock:callback];
}


- (void)fetchTop10WithSuccessBlock:(WFSuccessCallback)success
                      failureBlock:(WFFailureCallback)failure {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/topten", WFByrWidgetUrl] method:WFHTTPGet parameters:nil success:success failure:failure];
}

- (void)fetchRecommend {
    void (^callback)(NSInteger, id) = ^(NSInteger statusCode, id response) {
        WFResponse *byrResponse = [[WFResponse alloc] init];
        byrResponse.statusCode = statusCode;
        byrResponse.response   = response;
        if (self.responseReformer) {
            byrResponse = [self.responseReformer reformSectionTopResponse:byrResponse];
        }
        [self.responseDelegate fetchRecommendResponse:byrResponse];
    };
    [self fetchRecommendWithSuccessBlock:callback failureBlock:callback];
}

- (void)fetchRecommendWithSuccessBlock:(WFSuccessCallback)success
                          failureBlock:(WFFailureCallback)failure {
   [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/recommend", WFByrWidgetUrl] method:WFHTTPGet parameters:nil success:success failure:failure];
}



- (void)fetchSectionTopWithSectionNo:(NSInteger)section {
    void (^callback)(NSInteger, id) = ^(NSInteger statusCode, id response) {
        WFResponse *byrResponse = [[WFResponse alloc] init];
        byrResponse.statusCode = statusCode;
        byrResponse.response   = response;
        if (self.responseReformer) {
            byrResponse = [self.responseReformer reformSectionTopResponse:byrResponse];
        }
        [self.responseDelegate fetchSectionTopResponse:byrResponse];
    };
    [self fetchSectionTopWithSectionNo:section successBlock:callback failureBlock:callback];
}

- (void)fetchSectionTopWithSectionNo:(NSInteger)section
                      successBlock:(WFSuccessCallback)success
                      failureBlock:(WFFailureCallback)failure {
   [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/section-%ld", WFByrWidgetUrl, section] method:WFHTTPGet parameters:nil success:success failure:failure];
}

@end
