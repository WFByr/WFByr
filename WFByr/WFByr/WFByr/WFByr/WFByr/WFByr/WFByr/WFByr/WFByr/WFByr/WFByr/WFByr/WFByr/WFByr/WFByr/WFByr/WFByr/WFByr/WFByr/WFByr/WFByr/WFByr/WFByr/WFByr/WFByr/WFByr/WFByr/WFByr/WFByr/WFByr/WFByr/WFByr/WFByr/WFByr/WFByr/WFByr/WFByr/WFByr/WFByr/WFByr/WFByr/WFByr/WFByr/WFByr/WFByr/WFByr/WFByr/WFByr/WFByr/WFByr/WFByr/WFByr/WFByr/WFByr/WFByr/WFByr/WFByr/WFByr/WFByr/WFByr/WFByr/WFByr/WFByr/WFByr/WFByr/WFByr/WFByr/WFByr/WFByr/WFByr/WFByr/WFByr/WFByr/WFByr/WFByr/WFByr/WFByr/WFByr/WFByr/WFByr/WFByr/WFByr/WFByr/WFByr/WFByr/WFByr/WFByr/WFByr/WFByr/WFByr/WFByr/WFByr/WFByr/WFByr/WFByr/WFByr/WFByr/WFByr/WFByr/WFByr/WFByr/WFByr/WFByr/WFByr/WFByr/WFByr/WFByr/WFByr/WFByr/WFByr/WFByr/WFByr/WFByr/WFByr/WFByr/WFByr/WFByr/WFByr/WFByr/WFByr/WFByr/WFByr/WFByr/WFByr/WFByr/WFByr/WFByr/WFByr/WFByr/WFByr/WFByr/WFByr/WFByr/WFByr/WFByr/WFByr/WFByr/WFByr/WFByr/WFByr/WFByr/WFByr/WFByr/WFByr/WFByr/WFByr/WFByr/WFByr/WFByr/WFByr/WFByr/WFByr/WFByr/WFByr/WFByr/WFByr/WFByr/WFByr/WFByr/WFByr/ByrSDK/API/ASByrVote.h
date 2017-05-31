//
//  ASByrVote.h
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBase.h"

typedef enum{
    ASByrVoteMe,
    ASByrVoteJoin,
    ASByrVoteList,
    ASByrVoteNew,
    ASByrVoteHot,
    ASByrVoteAll,
}ASByrVoteCategory;

@interface ASByrVote : ASByrBase

- (instancetype)initWithAccessToken:(NSString *)token;

- (void)fetchVoteListWithCategory:(ASByrVoteCategory)cate
                              uid:(NSString*)uid
                     successBlock:(ASSuccessCallback)success
                     failureBlock:(ASSuccessCallback)failure;

- (void)fetchVoteInfoWithVid:(NSInteger)vid
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASSuccessCallback)failure;

- (void)voteWithVid:(NSInteger)vid
              viids:(NSArray*)viids
            isMulti:(BOOL)isMulti
       successBlock:(ASSuccessCallback)success
       failureBlock:(ASSuccessCallback)failure;




@end
