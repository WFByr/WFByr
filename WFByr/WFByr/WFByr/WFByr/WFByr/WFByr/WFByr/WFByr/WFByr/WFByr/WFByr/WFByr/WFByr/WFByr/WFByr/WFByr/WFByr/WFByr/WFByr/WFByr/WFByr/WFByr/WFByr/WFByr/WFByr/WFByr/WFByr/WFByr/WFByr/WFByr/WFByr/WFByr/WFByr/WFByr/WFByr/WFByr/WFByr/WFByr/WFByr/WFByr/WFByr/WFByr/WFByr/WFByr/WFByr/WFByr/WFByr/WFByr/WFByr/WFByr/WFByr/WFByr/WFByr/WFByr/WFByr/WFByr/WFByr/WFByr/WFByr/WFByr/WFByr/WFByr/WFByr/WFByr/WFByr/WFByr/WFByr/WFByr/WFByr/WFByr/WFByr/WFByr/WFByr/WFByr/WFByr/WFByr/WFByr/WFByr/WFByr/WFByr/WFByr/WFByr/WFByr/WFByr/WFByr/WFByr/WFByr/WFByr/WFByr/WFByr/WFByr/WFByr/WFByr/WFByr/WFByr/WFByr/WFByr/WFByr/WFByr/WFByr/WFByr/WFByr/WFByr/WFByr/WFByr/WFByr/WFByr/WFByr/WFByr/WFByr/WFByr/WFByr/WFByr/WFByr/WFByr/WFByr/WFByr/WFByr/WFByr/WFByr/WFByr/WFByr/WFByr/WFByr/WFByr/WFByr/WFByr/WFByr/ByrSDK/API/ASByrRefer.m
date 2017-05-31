//
//  ASByrRefer.m
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrRefer.h"
#import "ASByrConfig.h"

@implementation ASByrRefer

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    return self;
}


- (NSString*)typeStrWithType:(ASByrReferType)type {
    switch (type) {
        case ASByrReferReply:
            return @"reply";
            break;
            
        default:
            return @"at";
            break;
    }
}

- (void)fetchRefersWithType:(ASByrReferType)type
               successBlock:(ASSuccessCallback)success
               failureBlock:(ASSuccessCallback)failure {
    [self fetchRefersWithType:type count:20 page:1 successBlock:success failureBlock:failure];
}

- (void)fetchRefersWithType:(ASByrReferType)type
                      count:(NSInteger)count
                       page:(NSInteger)page
               successBlock:(ASSuccessCallback)success
               failureBlock:(ASSuccessCallback)failure {
    NSString *typeStr = [self typeStrWithType:type];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[@(count) stringValue], @"count",
                                                                          [@(page) stringValue], @"page", nil];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@", BYR_REFER_URL, typeStr] method:HTTP_GET parameters:parameters success:success failure:failure];
}

- (void)fetchReferInfoWithType:(ASByrReferType)type
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASSuccessCallback)failure {
    NSString *typeStr = [self typeStrWithType:type];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/info", BYR_REFER_URL, typeStr] method:HTTP_GET parameters:nil success:success failure:failure];
}

- (void)setReadWithType:(ASByrReferType)type
           successBlock:(ASSuccessCallback)success
           failureBlock:(ASSuccessCallback)failure {
    [self setReadWithType:type index:-1 successBlock:success failureBlock:failure];
}

- (void)setReadWithType:(ASByrReferType)type
                  index:(NSInteger)index
           successBlock:(ASSuccessCallback)success
           failureBlock:(ASSuccessCallback)failure {
    NSString *typeStr = [self typeStrWithType:type];
    if (index > 0) {
        [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/setRead/%ld", BYR_REFER_URL, typeStr, index] method:HTTP_POST parameters:nil success:success failure:failure];
    } else {
       [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/setRead/", BYR_REFER_URL, typeStr] method:HTTP_POST parameters:nil success:success failure:failure];
    }
    
}

- (void)deleteReferWithType:(ASByrReferType)type
               successBlock:(ASSuccessCallback)success
               failureBlock:(ASSuccessCallback)failure {
    [self deleteReferWithType:type index:-1 successBlock:success failureBlock:failure];
}
- (void)deleteReferWithType:(ASByrReferType)type
                      index:(NSInteger)index
               successBlock:(ASSuccessCallback)success
               failureBlock:(ASSuccessCallback)failure {
    NSString *typeStr = [self typeStrWithType:type];
    if (index > 0) {
       [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/delete/", BYR_REFER_URL, typeStr] method:HTTP_POST parameters:nil success:success failure:failure];
    } else {
       [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/delete/%ld", BYR_REFER_URL, typeStr, index] method:HTTP_POST parameters:nil success:success failure:failure];
    }
}

@end
