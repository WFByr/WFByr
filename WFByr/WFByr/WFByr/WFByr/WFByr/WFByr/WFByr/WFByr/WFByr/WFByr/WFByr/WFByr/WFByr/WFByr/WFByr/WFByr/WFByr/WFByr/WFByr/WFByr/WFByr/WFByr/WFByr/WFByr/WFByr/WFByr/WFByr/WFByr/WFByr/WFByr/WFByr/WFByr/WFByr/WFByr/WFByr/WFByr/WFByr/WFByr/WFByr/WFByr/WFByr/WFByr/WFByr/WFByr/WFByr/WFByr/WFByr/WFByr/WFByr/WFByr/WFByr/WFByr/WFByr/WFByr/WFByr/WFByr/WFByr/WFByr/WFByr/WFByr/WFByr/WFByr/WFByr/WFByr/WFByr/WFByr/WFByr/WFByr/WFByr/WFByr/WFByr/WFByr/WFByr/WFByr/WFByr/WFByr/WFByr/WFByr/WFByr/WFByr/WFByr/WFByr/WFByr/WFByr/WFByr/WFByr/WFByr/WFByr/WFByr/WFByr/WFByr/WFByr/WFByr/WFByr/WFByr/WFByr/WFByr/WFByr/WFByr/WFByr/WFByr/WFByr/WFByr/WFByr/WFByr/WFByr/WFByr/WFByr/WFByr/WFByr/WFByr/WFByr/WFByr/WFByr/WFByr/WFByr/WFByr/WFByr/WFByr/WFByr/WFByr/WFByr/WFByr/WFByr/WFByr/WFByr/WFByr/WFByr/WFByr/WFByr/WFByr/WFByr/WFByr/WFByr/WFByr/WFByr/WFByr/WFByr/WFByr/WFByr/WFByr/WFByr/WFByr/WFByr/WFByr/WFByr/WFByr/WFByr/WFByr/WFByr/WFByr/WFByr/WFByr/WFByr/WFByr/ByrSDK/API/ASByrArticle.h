//
//  ASByrArticle.h
//  ASByr
//
//  Created by andy on 16/3/6.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBase.h"
#import "ASByrResponse.h"

@protocol ASByrArticleResponseDelegate <NSObject>

@optional

- (void)fetchAriticleResponse:(ASByrResponse*) response;

- (void)fetchThreadsResponse:(ASByrResponse*) response;



@end

@protocol ASByrArticleResponseReformer <NSObject>

@optional

- (ASByrResponse*)reformArticleResponse:(ASByrResponse*) response;

- (ASByrResponse*)reformThreadsResponse:(ASByrResponse*) response;

@end


@interface ASByrArticle : ASByrBase

@property(nonatomic, weak)id<ASByrArticleResponseDelegate> responseDelegate;

@property(nonatomic, weak)id<ASByrArticleResponseReformer> responseReformer;

- (ASByrArticle *)initWithAccessToken:(NSString *)token;


/**
 *
 *
 *  @param board
 *  @param aid
 *  @param success
 *  @param failure
 */
- (void)fetchArticleWithBoard:(NSString *)board
                          aid:(NSInteger)aid;

- (void)fetchArticleWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                         mode:(NSString *)mode;

/**
 *
 *
 *  @param board
 *  @param aid   
 */
- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid;

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                 successBlock:(ASSuccessCallback)success
                 failureBlock:(ASFailureCallback)failure;

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                         page:(NSInteger)page;

- (void)fetchThreadsWithBoard:(NSString *)board
                          aid:(NSInteger)aid
                         page:(NSInteger)page
                 successBlock:(ASSuccessCallback)success
                 failureBlock:(ASFailureCallback)failure;

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
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASFailureCallback)failure;

- (void)postArticleWithBoard:(NSString *)board
                       title:(NSString *)title
                     content:(NSString *)content
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASFailureCallback)failure;

- (void)postArticleWithBoard:(NSString *)board
                       title:(NSString *)title
                    content:(NSString *)content
                        reid:(NSInteger)reid
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASFailureCallback)failure;

- (void)forwardArticleWithBoard:(NSString *)board
                            aid:(NSInteger)aid
                         target:(NSString*)target
                   successBlock:(ASSuccessCallback)success
                   failureBlock:(ASFailureCallback)failure;

- (void)forwardArticleWithBoard:(NSString *)board
                            aid:(NSInteger)aid
                         target:(NSString*)target
                        threads:(BOOL)threads
                         noref:(BOOL)noref
                          noatt:(BOOL)noatt
                         noansi:(BOOL)noansi
                           big5:(BOOL)big5
                   successBlock:(ASSuccessCallback)success
                   failureBlock:(ASFailureCallback)failure;

- (void)crossAticleWithBoard:(NSString *)board
                         aid:(NSInteger)aid
                      target:(NSString*)target
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASFailureCallback)failure;

- (void)updateArticleWithBoard:(NSString*)board
                           aid:(NSInteger)aid
                         title:(NSString*)title
                       content:(NSString*)content
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASFailureCallback)failure;

- (void)deleteArticleWithBoard:(NSString*)board
                           aid:(NSInteger)aid
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASFailureCallback)failure;

@end
