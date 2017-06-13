//
//  ASByrUser.m
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFUserApi.h"
#import "WFByrConst.h"
#import "WFUser.h"
#import "YYModel.h"

@interface WFUserResponseReformer : NSObject <WFUserResponseReformer>

@end

@implementation WFUserResponseReformer

- (WFResponse*)reformUserResponse:(WFResponse *)response {
    if (response.isSucceeded) {
        response.reformedData = [WFUser yy_modelWithJSON:response.response];
    }
    return response;
}

@end
@implementation WFUserApi {
    WFUserResponseReformer *_defaultReformer;
}

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    _defaultReformer = [WFUserResponseReformer new];
    self.responseReformer = _defaultReformer;
    return self;
}

- (void)fetchUserInfo {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/getinfo", WFByrUserUrl] method:WFHTTPGet parameters:nil delegate:self.responseDelegate callback:@selector(fetchUserResponse:) reformer:self.responseReformer reformFunc:@selector(reformUserResponse:)];
}

//获取用户详细附属的信息
- (void)fetchUserInfoWithSuccessBlock:(WFSuccessCallback)success
                         failureBlock:(WFFailureCallback)failure {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/getinfo", WFByrUserUrl] method:WFHTTPGet parameters:nil success:success failure:failure];
}

- (void)fetchUserInfoWithUid:(NSString *)uid {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/query/%@", WFByrUserUrl, uid] method:WFHTTPGet parameters:nil delegate:self.responseDelegate callback:@selector(fetchUserResponse:) reformer:self.responseReformer reformFunc:@selector(reformUserResponse:)];
}

- (void)fetchUserInfoWithUid:(NSString *)uid
                successBlock:(WFSuccessCallback)success
                failureBlock:(WFFailureCallback)failure {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/query/%@", WFByrUserUrl, uid] method:WFHTTPGet parameters:nil success:success failure:failure];
}

@end
