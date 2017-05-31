//
//  ASByrWidget.m
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrWidget.h"
#import "ASByrConfig.h"

@implementation ASByrWidget

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    return self;
}


- (void)fetchTop10{
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/topten", BYR_WIDGET_URL]
                      method:HTTP_GET
                  parameters:nil
                    delegate:self.responseDelegate
                    callback:@selector(fetchTop10Response:)
                    reformer:self.responseReformer
                  reformFunc:@selector(reformTop10Response:)];
}

- (void)fetchTop10WithReformer:(id<ASByrWidgetResponseReformer>)reformer {
    void (^callback)(NSInteger, id) = ^(NSInteger statusCode, id response) {
        ASByrResponse *byrResponse = [[ASByrResponse alloc] init];
        byrResponse.statusCode = statusCode;
        byrResponse.response   = response;
        if (reformer) {
            byrResponse = [reformer reformTop10Response:byrResponse];
        }
        [self.responseDelegate fetchTop10Response:byrResponse];
    };
    [self fetchTop10WithSuccessBlock:callback failureBlock:callback];
}

- (void)fetchTop10WithSuccessBlock:(ASSuccessCallback)success
                      failureBlock:(ASSuccessCallback)failure {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/topten", BYR_WIDGET_URL] method:HTTP_GET parameters:nil success:success failure:failure];
}

- (void)fetchRecommendWithReformer:(id<ASByrWidgetResponseReformer>)reformer {
    void (^callback)(NSInteger, id) = ^(NSInteger statusCode, id response) {
        ASByrResponse *byrResponse = [[ASByrResponse alloc] init];
        byrResponse.statusCode = statusCode;
        byrResponse.response   = response;
        if (reformer) {
            byrResponse = [reformer reformRecommendResponse:byrResponse];
        }
        [self.responseDelegate fetchRecommendResponse:byrResponse];
    };
    [self fetchRecommendWithSuccessBlock:callback failureBlock:callback];
}

- (void)fetchRecommendWithSuccessBlock:(ASSuccessCallback)success
                          failureBlock:(ASSuccessCallback)failure {
   [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/recommend", BYR_WIDGET_URL] method:HTTP_GET parameters:nil success:success failure:failure];
}

- (void)fetchSectionTopWithSectionNo:(NSInteger)section
                            reformer:(id<ASByrWidgetResponseReformer>)reformer{
    void (^callback)(NSInteger, id) = ^(NSInteger statusCode, id response) {
        ASByrResponse *byrResponse = [[ASByrResponse alloc] init];
        byrResponse.statusCode = statusCode;
        byrResponse.response   = response;
        if (reformer) {
            byrResponse = [reformer reformSectionTopResponse:byrResponse];
        }
        [self.responseDelegate fetchSectionTopResponse:byrResponse];
    };
    [self fetchSectionTopWithSectionNo:section successBlock:callback failureBlock:callback];
}

- (void)fetchSectionTopWithSectionNo:(NSInteger)section
                      successBlock:(ASSuccessCallback)success
                      failureBlock:(ASSuccessCallback)failure {
   [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/section-%ld", BYR_WIDGET_URL, section] method:HTTP_GET parameters:nil success:success failure:failure];
}

@end
