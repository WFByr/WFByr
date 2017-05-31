//
//  ASByrUser.h
//  ASByr
//
//  Created by andy on 16/3/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBase.h"

@protocol ASByrUserResponseDelegate <NSObject>

-(void)fetchUserResponse:(ASByrResponse*)response;

@end

@protocol  ASByrUserResponseReformer<NSObject>

-(ASByrResponse*)reformUserResponse:(ASByrResponse*)response;

@end

@interface ASByrUser : ASByrBase
@property (weak, nonatomic) id<ASByrUserResponseDelegate> responseDelegate;

- (instancetype)initWithAccessToken:(NSString *)token;

- (void)fetchUserInfoWithReformer:(id<ASByrUserResponseReformer>)reformer;

- (void)fetchUserInfoWithSuccessBlock:(ASSuccessCallback)success
                         failureBlock:(ASSuccessCallback)failure;

- (void)fetchUserInfoWithUid:(NSString*)uid
                successBlock:(ASSuccessCallback)success
                failureBlock:(ASSuccessCallback)failure;
@end
