//
//  ASByrArticle.h
//  ASByr
//
//  Created by andy on 16/3/6.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFBaseApi.h"

@class WFArticle;

@protocol WFArticleResponseDelegate <NSObject>

@optional

- (void)fetchAriticleResponse:(WFResponse*) response;

- (void)fetchThreadsResponse:(WFResponse*) response;



@end

@protocol WFArticleResponseReformer <NSObject>

@optional

- (WFResponse*)reformArticleResponse:(WFResponse*) response;

- (WFResponse*)reformThreadsResponse:(WFResponse*) response;

@end


@interface WFArticleApi : WFBaseApi

@property(nonatomic, weak)id<WFArticleResponseDelegate> responseDelegate;

@property(nonatomic, weak)id<WFArticleResponseReformer> responseReformer;

- (instancetype)initWithAccessToken:(NSString *)token;


- (void)fetchArticleWithBoard:(NSString *)board
                          aid:(NSInteger)aid;

- (void)fetchArticleWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                         mode:(NSString *)mode;

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid;

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                 successBlock:(WFSuccessCallback)success
                 failureBlock:(WFFailureCallback)failure;

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                         page:(NSInteger)page;

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                         page:(NSInteger)page
                 successBlock:(WFSuccessCallback)success
                 failureBlock:(WFFailureCallback)failure;

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                           au:(NSString *)au
                        count:(NSInteger)count
                         page:(NSInteger)page;
              
- (void)fetchThreadsWithBoard:(NSString *)board
                         aid:(NSInteger)aid
                          au:(NSString *)au
                       count:(NSInteger)count
                        page:(NSInteger)page
                successBlock:(WFSuccessCallback)success
                failureBlock:(WFFailureCallback)failure;

- (void)postArticleWithBoard:(NSString *)board
                       title:(NSString *)title
                     content:(NSString *)content
                successBlock:(WFSuccessCallback)success
                failureBlock:(WFFailureCallback)failure;

- (void)postArticleWithBoard:(NSString *)board
                       title:(NSString *)title
                    content:(NSString *)content
                        reid:(NSInteger)reid
                successBlock:(WFSuccessCallback)success
                failureBlock:(WFFailureCallback)failure;

- (void)forwardArticleWithBoard:(NSString *)board
                            aid:(NSInteger)aid
                         target:(NSString*)target
                   successBlock:(WFSuccessCallback)success
                   failureBlock:(WFFailureCallback)failure;

- (void)forwardArticleWithBoard:(NSString *)board
                            aid:(NSInteger)aid
                         target:(NSString*)target
                        threads:(BOOL)threads
                         noref:(BOOL)noref
                          noatt:(BOOL)noatt
                         noansi:(BOOL)noansi
                           big5:(BOOL)big5
                   successBlock:(WFSuccessCallback)success
                   failureBlock:(WFFailureCallback)failure;

- (void)crossAticleWithBoard:(NSString *)board
                         aid:(NSInteger)aid
                      target:(NSString*)target
                successBlock:(WFSuccessCallback)success
                failureBlock:(WFFailureCallback)failure;

- (void)updateArticleWithBoard:(NSString*)board
                           aid:(NSInteger)aid
                         title:(NSString*)title
                       content:(NSString*)content
                  successBlock:(WFSuccessCallback)success
                  failureBlock:(WFFailureCallback)failure;

- (void)deleteArticleWithBoard:(NSString*)board
                           aid:(NSInteger)aid
                  successBlock:(WFSuccessCallback)success
                  failureBlock:(WFFailureCallback)failure;

@end
