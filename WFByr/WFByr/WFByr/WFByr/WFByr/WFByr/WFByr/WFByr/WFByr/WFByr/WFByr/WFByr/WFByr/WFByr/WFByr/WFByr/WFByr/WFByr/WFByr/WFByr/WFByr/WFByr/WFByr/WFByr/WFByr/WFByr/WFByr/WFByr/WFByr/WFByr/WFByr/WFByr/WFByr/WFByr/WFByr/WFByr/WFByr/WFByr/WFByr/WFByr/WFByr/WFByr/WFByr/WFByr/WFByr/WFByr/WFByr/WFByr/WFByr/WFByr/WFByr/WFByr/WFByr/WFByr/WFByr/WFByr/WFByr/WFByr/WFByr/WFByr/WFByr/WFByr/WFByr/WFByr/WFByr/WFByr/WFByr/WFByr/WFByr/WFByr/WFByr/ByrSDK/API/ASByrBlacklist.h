//
//  ASByrBlacklist.h
//  ASByr
//
//  Created by andy on 16/3/8.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBase.h"

@interface ASByrBlacklist : ASByrBase
/**
 *  <#Description#>
 *
 *  @param token <#token description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithAccessToken:(NSString *)token;

/**
 *  Description
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)fetchBlacklistWithSuccessBlock:(ASSuccessCallback)success
                          failureBlock:(ASSuccessCallback)failure;

/**
 *  <#Description#>
 *
 *  @param count   <#count description#>
 *  @param page    <#page description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)fetchBlacklistWithCount:(NSInteger)count
                           page:(NSInteger)page
                   successBlock:(ASSuccessCallback)success
                   failureBlock:(ASSuccessCallback)failure;
/**
 *  <#Description#>
 *
 *  @param uid     <#uid description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)addBlacklistWithUid:(NSString*)uid
               successBlock:(ASSuccessCallback)success
               failureBlock:(ASSuccessCallback)failure;

/**
 *  <#Description#>
 *
 *  @param uid     <#uid description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)deleteBlacklistWithUid:(NSString*)uid
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASSuccessCallback)failure;

@end
