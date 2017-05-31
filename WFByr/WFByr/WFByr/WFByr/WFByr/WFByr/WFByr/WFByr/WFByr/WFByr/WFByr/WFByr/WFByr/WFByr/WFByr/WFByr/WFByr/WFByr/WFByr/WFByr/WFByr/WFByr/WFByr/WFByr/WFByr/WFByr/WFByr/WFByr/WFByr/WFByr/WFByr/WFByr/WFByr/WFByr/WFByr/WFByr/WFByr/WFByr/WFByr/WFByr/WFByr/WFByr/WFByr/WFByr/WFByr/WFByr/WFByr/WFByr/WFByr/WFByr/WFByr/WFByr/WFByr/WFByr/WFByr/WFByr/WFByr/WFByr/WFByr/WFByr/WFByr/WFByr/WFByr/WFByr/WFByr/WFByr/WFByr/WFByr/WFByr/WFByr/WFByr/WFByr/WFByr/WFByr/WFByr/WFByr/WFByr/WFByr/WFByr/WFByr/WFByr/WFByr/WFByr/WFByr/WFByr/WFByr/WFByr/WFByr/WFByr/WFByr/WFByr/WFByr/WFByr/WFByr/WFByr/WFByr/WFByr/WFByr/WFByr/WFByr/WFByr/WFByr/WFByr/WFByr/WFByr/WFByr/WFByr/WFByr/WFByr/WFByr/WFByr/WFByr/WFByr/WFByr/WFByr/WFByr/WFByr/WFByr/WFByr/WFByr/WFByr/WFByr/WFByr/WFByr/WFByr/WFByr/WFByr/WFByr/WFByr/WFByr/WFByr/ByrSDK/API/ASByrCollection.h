//
//  ASByrCollection.h
//  ASByr
//
//  Created by andy on 16/3/9.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBase.h"

@protocol ASByrCollectionResponseDelegate <NSObject>

@optional

- (void)fentchCollectionsResponse:(ASByrResponse *)response;

@end

@protocol ASByrCollectionResponseReformer <NSObject>

@optional

- (ASByrResponse *)reformCollectionResponse:(ASByrResponse *)response;

@end

@interface ASByrCollection : ASByrBase

@property(nonatomic, weak)id<ASByrCollectionResponseDelegate> responseDelegate;
@property(nonatomic, weak)id<ASByrCollectionResponseReformer> responseReformer;


- (instancetype)initWithAccessToken:(NSString *)token;

- (void)fetchCollectionsWithCount:(NSInteger)count page:(NSInteger)page SuccessBlock:(ASSuccessCallback)success
                     failureBlock:(ASSuccessCallback)failure;

- (void)fetchCollectionsWithCount:(NSInteger)count
                             page:(NSInteger)page;

- (void)addCollectionWithBoard:(NSString*)board
                           aid:(NSString*)aid
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASSuccessCallback)failure;

- (void)deleteCollectionWithAid:(NSString*)aid
                   successBlock:(ASSuccessCallback)success
                   failureBlock:(ASSuccessCallback)failure;
@end
