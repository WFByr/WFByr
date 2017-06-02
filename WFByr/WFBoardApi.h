//
//  ASByrBoard.h
//  ASByr
//
//  Created by andy on 16/3/9.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFBaseApi.h"

@protocol WFBoardResponseDelegate <NSObject>

@optional

- (void)fetchBoardResponse:(WFResponse*) response;

@end

@protocol WFBoardResponseReformer <NSObject>

@optional

- (WFResponse*)reformBoardResponse:(WFResponse*) response;

@end

@interface WFBoardApi : WFBaseApi

/**
 *  <#Description#>
 *
 *  @param token byr accesstoken
 *
 *  @return void
 */
@property(nonatomic, weak)id<WFBoardResponseDelegate> responseDelegate;

@property(nonatomic, weak)id<WFBoardResponseReformer> responseReformer;

- (instancetype)initWithAccessToken:(NSString *)token;


- (void)fetchBoard:(NSString *)name pageNumber:(NSInteger)page;

- (void)fetchRootSectionsWithSuccessBlock:(WFSuccessCallback)success
                             failureBlock:(WFFailureCallback)failure;

- (void)fetchSectionInfoWithName:(NSString*)name
                    successBlock:(WFSuccessCallback)success
                    failureBlock:(WFFailureCallback)failure;

- (void)fetchBoardPostLineInfoWithName:(NSString*)name
                        successBlock:(WFSuccessCallback)success
                        failureBlock:(WFFailureCallback)failure;

- (void)fetchBoardDetailInfoWithName:(NSString*)name
                              page:(NSInteger)page
                      successBlock:(WFSuccessCallback)success
                      failureBlock:(WFFailureCallback)failure;

- (void)fetchBoardInfoWithName:(NSString*)name
                          mode:(NSInteger)mode
                         count:(NSInteger)count
                          page:(NSInteger)page
                  successBlock:(WFSuccessCallback)success
                  failureBlock:(WFFailureCallback)failure;
@end
