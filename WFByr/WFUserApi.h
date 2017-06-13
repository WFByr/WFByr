//
//  ASByrUser.h
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFBaseApi.h"

@protocol WFUserResponseDelegate <NSObject>

-(void)fetchUserResponse:(WFResponse*)response;

@end

@protocol  WFUserResponseReformer<NSObject>

-(WFResponse*)reformUserResponse:(WFResponse*)response;

@end

@interface WFUserApi : WFBaseApi

@property (weak, nonatomic) id<WFUserResponseDelegate> responseDelegate;

@property (nonatomic, weak) id<WFUserResponseReformer> responseReformer;

- (instancetype)initWithAccessToken:(NSString *)token;

- (void)fetchUserInfo;

- (void)fetchUserInfoWithSuccessBlock:(WFSuccessCallback)success
                         failureBlock:(WFFailureCallback)failure;

- (void)fetchUserInfoWithUid:(NSString*)uid;

- (void)fetchUserInfoWithUid:(NSString*)uid
                successBlock:(WFSuccessCallback)success
                failureBlock:(WFFailureCallback)failure;
@end
