//
//  ASByrWidget.h
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFBaseApi.h"

@protocol WFWidgetResponseDelegate <NSObject>

@optional

- (void)fetchTop10Response:(WFResponse*) response;

- (void)fetchRecommendResponse:(WFResponse*) response;

- (void)fetchSectionTopResponse:(WFResponse*) response;

@end


@protocol WFWidgetResponseReformer <NSObject>

@optional

- (WFResponse*)reformTop10Response:(WFResponse*) response;

- (WFResponse*)reformRecommendResponse:(WFResponse*)response;

- (WFResponse*)reformSectionTopResponse:(WFResponse*)response;

@end



@interface WFWidgetApi : WFBaseApi

@property(nonatomic, weak)id<WFWidgetResponseDelegate> responseDelegate;

@property(nonatomic, weak)id<WFWidgetResponseReformer> responseReformer;

- (void)fetchTop10;

- (void)fetchTop10WithSuccessBlock:(WFSuccessCallback)success
                      failureBlock:(WFFailureCallback)failure;

- (void)fetchRecommend;

- (void)fetchRecommendWithSuccessBlock:(WFSuccessCallback)success
                          failureBlock:(WFFailureCallback)failure;

- (void)fetchSectionTopWithSectionNo:(NSInteger)section;

- (void)fetchSectionTopWithSectionNo:(NSInteger)section
                        successBlock:(WFSuccessCallback)success
                        failureBlock:(WFFailureCallback)failure;


@end
