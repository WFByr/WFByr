//
//  ASByrBoard.h
//  ASByr
//
//  Created by andy on 16/3/9.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBase.h"

@protocol ASByrBoardResponseDelegate <NSObject>

@optional

- (void)fetchBoardResponse:(ASByrResponse*) response;

@end

@protocol ASByrBoardResponseReformer <NSObject>

@optional

- (ASByrResponse*)reformBoardResponse:(ASByrResponse*) response;

@end

@interface ASByrBoard : ASByrBase

/**
 *  <#Description#>
 *
 *  @param token byr accesstoken
 *
 *  @return void
 */
@property(nonatomic, weak)id<ASByrBoardResponseDelegate> responseDelegate;

@property(nonatomic, weak)id<ASByrBoardResponseReformer> responseReformer;

- (instancetype)initWithAccessToken:(NSString *)token;


- (void)fetchBoard:(NSString *)name pageNumber:(NSInteger)page;

- (void)fetchRootSectionsWithSuccessBlock:(ASSuccessCallback)success
                             failureBlock:(ASSuccessCallback)failure;

- (void)fetchSectionInfoWithName:(NSString*)name
                    successBlock:(ASSuccessCallback)success
                    failureBlock:(ASSuccessCallback)failure;

- (void)fetchBoardPostLineInfoWithName:(NSString*)name
                        successBlock:(ASSuccessCallback)success
                        failureBlock:(ASSuccessCallback)failure;

- (void)fetchBoardDetailInfoWithName:(NSString*)name
                              page:(NSInteger)page
                      successBlock:(ASSuccessCallback)success
                      failureBlock:(ASSuccessCallback)failure;

- (void)fetchBoardInfoWithName:(NSString*)name
                          mode:(NSInteger)mode
                         count:(NSInteger)count
                          page:(NSInteger)page
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASSuccessCallback)failure;
@end
