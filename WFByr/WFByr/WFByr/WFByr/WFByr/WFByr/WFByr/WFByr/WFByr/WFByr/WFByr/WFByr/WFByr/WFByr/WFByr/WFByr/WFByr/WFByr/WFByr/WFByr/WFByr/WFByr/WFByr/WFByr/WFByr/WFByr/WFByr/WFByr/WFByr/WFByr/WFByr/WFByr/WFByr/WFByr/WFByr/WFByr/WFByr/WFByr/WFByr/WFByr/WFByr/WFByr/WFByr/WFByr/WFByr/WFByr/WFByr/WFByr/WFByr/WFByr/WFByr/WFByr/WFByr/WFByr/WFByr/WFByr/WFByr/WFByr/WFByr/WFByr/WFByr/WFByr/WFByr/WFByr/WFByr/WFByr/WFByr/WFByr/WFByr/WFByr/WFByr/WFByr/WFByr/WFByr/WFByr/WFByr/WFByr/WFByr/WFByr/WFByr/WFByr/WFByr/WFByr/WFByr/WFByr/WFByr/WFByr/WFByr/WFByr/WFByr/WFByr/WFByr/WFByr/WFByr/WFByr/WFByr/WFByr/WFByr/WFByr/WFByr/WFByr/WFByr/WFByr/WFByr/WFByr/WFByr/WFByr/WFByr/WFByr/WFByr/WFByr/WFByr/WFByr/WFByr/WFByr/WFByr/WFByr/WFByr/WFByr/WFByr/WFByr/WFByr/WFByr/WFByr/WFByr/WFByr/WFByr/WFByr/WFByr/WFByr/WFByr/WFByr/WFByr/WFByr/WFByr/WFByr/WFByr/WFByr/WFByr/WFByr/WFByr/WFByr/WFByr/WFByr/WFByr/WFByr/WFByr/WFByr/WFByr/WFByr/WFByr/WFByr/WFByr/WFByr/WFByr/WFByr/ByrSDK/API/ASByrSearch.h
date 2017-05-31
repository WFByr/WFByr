//
//  ASByrSearch.h
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBase.h"

@interface ASByrSearch : ASByrBase

- (instancetype)initWithAccessToken:(NSString *)token;

- (void)searchBoardWithBoard:(NSString*)board
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASSuccessCallback)failure;


- (void)searchArticlesWithBoard:(NSString*)board
                         title1:(NSString*)title1
                         title2:(NSString*)title2
                         titlen:(NSString*)titlen
                         author:(NSString*)author
                            day:(NSInteger)day
                              m:(NSInteger)m
                              a:(NSInteger)a
                              o:(NSInteger)o
                          count:(NSInteger)count
                           page:(NSInteger)page
                   successBlock:(ASSuccessCallback)success
                   failureBlock:(ASSuccessCallback)failure;


- (void)searchThreadsWithBoard:(NSString*)board
                        title1:(NSString*)title1
                        title2:(NSString*)title2
                        titlen:(NSString*)titlen
                        author:(NSString*)author
                           day:(NSInteger)day
                             m:(NSInteger)m
                             a:(NSInteger)a
                         count:(NSInteger)count
                          page:(NSInteger)page
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASSuccessCallback)failure;
@end
