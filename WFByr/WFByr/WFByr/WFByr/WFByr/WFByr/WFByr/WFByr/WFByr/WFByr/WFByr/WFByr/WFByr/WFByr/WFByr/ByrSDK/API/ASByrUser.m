//
//  ASByrUser.m
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrUser.h"
#import "ASByrConfig.h"

@implementation ASByrUser

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    return self;
}

- (void)fetchUserInfoWithReformer:(id<ASByrUserResponseReformer>)reformer{
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/getinfo", BYR_USER_URL] method:HTTP_GET parameters:nil delegate:self.responseDelegate callback:@selector(fetchUserResponse:) reformer:reformer reformFunc:@selector(reformUserResponse:)];
}

//获取用户详细附属的信息
- (void)fetchUserInfoWithSuccessBlock:(ASSuccessCallback)success
                         failureBlock:(ASSuccessCallback)failure {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/getinfo", BYR_USER_URL] method:HTTP_GET parameters:nil success:success failure:failure];
}

- (void)fetchUserInfoWithUid:(NSString *)uid
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASSuccessCallback)failure {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/query/%@", BYR_USER_URL, uid] method:HTTP_GET parameters:nil success:success failure:failure];
}

@end
