//
//  ASByrRefer.h
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBase.h"

typedef enum{
    ASByrReferAt,
    ASByrReferReply,
}ASByrReferType;

@interface ASByrRefer : ASByrBase

- (instancetype)initWithAccessToken:(NSString *)token;

- (void)fetchRefersWithType:(ASByrReferType)type
               successBlock:(ASSuccessCallback)success
               failureBlock:(ASSuccessCallback)failure;

- (void)fetchRefersWithType:(ASByrReferType)type
                      count:(NSInteger)count
                       page:(NSInteger)page
               successBlock:(ASSuccessCallback)success
               failureBlock:(ASSuccessCallback)failure;

- (void)fetchReferInfoWithType:(ASByrReferType)type
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASSuccessCallback)failure;

- (void)setReadWithType:(ASByrReferType)type
           successBlock:(ASSuccessCallback)success
           failureBlock:(ASSuccessCallback)failure;

- (void)setReadWithType:(ASByrReferType)type
                  index:(NSInteger)index
           successBlock:(ASSuccessCallback)success
           failureBlock:(ASSuccessCallback)failure;

- (void)deleteReferWithType:(ASByrReferType)type
               successBlock:(ASSuccessCallback)success
               failureBlock:(ASSuccessCallback)failure;

- (void)deleteReferWithType:(ASByrReferType)type
                      index:(NSInteger)index
               successBlock:(ASSuccessCallback)success
               failureBlock:(ASSuccessCallback)failure;

@end
