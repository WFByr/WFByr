//
//  ASByrWidget.h
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBase.h"
#import "ASByrResponse.h"

@protocol ASByrWidgetResponseDelegate <NSObject>

@optional

- (void)fetchTop10Response:(ASByrResponse*) response;

- (void)fetchRecommendResponse:(ASByrResponse*) response;

- (void)fetchSectionTopResponse:(ASByrResponse*) response;

@end

@protocol ASByrWidgetResponseReformer <NSObject>

@optional

- (ASByrResponse*)reformTop10Response:(ASByrResponse*) response;

- (ASByrResponse*)reformRecommendResponse:(ASByrResponse*)response;

- (ASByrResponse*)reformSectionTopResponse:(ASByrResponse*)response;

@end

@interface ASByrWidget : ASByrBase

@property(nonatomic, weak)id<ASByrWidgetResponseDelegate> responseDelegate;

@property(nonatomic, weak)id<ASByrWidgetResponseReformer> responseReformer;

- (instancetype)initWithAccessToken:(NSString *)token;

- (void)fetchTop10;

- (void)fetchTop10WithSuccessBlock:(ASSuccessCallback)success
                      failureBlock:(ASSuccessCallback)failure;

- (void)fetchRecommendWithReformer:(id<ASByrWidgetResponseReformer>) reformer;

- (void)fetchRecommendWithSuccessBlock:(ASSuccessCallback)success
                          failureBlock:(ASSuccessCallback)failure;

- (void)fetchSectionTopWithSectionNo:(NSInteger)section
                            reformer:(id<ASByrWidgetResponseReformer>) reformer;

- (void)fetchSectionTopWithSectionNo:(NSInteger)section
                        successBlock:(ASSuccessCallback)success
                        failureBlock:(ASSuccessCallback)failure;


@end
