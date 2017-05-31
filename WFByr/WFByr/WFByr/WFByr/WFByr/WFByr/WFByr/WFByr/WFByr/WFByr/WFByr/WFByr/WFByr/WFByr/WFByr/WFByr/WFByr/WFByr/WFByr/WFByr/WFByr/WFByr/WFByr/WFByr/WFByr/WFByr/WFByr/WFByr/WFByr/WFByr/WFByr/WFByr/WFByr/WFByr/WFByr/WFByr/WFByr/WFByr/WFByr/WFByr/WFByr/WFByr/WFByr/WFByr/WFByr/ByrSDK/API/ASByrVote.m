//
//  ASByrVote.m
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrVote.h"
#import "ASByrConfig.h"

@implementation ASByrVote

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    return self;
}

- (NSString*)categoryStrWithCategory:(ASByrVoteCategory)category {
    switch (category) {
        case ASByrVoteMe:
            return @"me";
        case ASByrVoteJoin:
            return @"join";
        case ASByrVoteList:
            return @"list";
        case ASByrVoteHot:
            return @"hot";
        case ASByrVoteNew:
            return @"new";
        default:
            return @"all";
    }
}

- (void)fetchVoteListWithCategory:(ASByrVoteCategory)cate
                              uid:(NSString*)uid
                     successBlock:(ASSuccessCallback)success
                     failureBlock:(ASSuccessCallback)failure {
    NSString *cateStr = [self categoryStrWithCategory:cate];
    if (cate == ASByrVoteList) {
        [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/category/list",BYR_VOTE_URL] method:HTTP_GET parameters:@{@"u":uid} success:success failure:failure];
    } else {
        [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/category/%@",BYR_VOTE_URL, cateStr] method:HTTP_GET parameters:nil success:success failure:failure];
    }
}

- (void)fetchVoteInfoWithVid:(NSInteger)vid
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASSuccessCallback)failure {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%ld", BYR_VOTE_URL, vid] method:HTTP_GET parameters:nil success:success failure:failure];
}

- (void)voteWithVid:(NSInteger)vid
              viids:(NSArray*)viids
            isMulti:(BOOL)isMulti
       successBlock:(ASSuccessCallback)success
       failureBlock:(ASSuccessCallback)failure {
    if (isMulti) {
        [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%ld", BYR_VOTE_URL, vid] method:HTTP_POST parameters:@{@"vote":viids} success:success failure:failure];
    } else {
       [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%ld", BYR_VOTE_URL, vid] method:HTTP_POST parameters:@{@"vote":viids[0]} success:success failure:failure];
    }
}
@end
