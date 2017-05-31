//
//  ASByrBlacklist.m
//  ASByr
//
//  Created by andy on 16/3/8.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBlacklist.h"
#import "ASByrConfig.h"

@implementation ASByrBlacklist

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    return  self;
}

- (void)fetchBlacklistWithSuccessBlock:(ASSuccessCallback)success
                          failureBlock:(ASSuccessCallback)failure {
    [self fetchBlacklistWithCount:20 page:1 successBlock:success failureBlock:failure];
}

- (void)fetchBlacklistWithCount:(NSInteger)count
                           page:(NSInteger)page
                   successBlock:(ASSuccessCallback)success
                   failureBlock:(ASSuccessCallback)failure {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[@(count) stringValue], @"count", [@(page) stringValue] , @"page", nil];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/list", BYR_BLACKLIST_URL] method:HTTP_GET parameters:parameters success:success failure:failure];
}

- (void)addBlacklistWithUid:(NSString *)uid
               successBlock:(ASSuccessCallback)success
               failureBlock:(ASSuccessCallback)failure {
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:uid forKey:@"id"];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/add", BYR_BLACKLIST_URL] method:HTTP_POST parameters:parameters success:success failure:failure];
}

- (void)deleteBlacklistWithUid:(NSString *)uid
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASSuccessCallback)failure {
    NSDictionary *parameters =  [NSDictionary dictionaryWithObject:uid forKey:@"id"];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/delete", BYR_BLACKLIST_URL] method:HTTP_POST parameters:parameters success:success failure:failure];
}

@end
