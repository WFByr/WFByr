//
//  WFCollectionApi.h
//  WFByr
//
//  Created by lixiangqian on 17/6/3.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFBaseApi.h"

@protocol WFCollectionResponseDelegate <NSObject>

@optional

- (void)fentchCollectionsResponse:(WFResponse *)response;

@end

@protocol WFCollectionResponseReformer <NSObject>

@optional

- (WFResponse *)reformCollectionResponse:(WFResponse *)response;

@end

@interface WFCollectionApi : WFBaseApi

@property(nonatomic, weak)id<WFCollectionResponseDelegate> responseDelegate;
@property(nonatomic, weak)id<WFCollectionResponseReformer> responseReformer;


- (instancetype)initWithAccessToken:(NSString *)token;

- (void)fetchCollectionsWithCount:(NSInteger)count page:(NSInteger)page SuccessBlock:(WFSuccessCallback)success
                     failureBlock:(WFSuccessCallback)failure;

- (void)fetchCollectionsWithCount:(NSInteger)count
                             page:(NSInteger)page;

- (void)addCollectionWithBoard:(NSString*)board
                           aid:(NSString*)aid
                  successBlock:(WFSuccessCallback)success
                  failureBlock:(WFSuccessCallback)failure;

- (void)deleteCollectionWithAid:(NSString*)aid
                   successBlock:(WFSuccessCallback)success
                   failureBlock:(WFSuccessCallback)failure;
@end
