//
//  ASByrBase.h
//  ASByr
//
//  Created by andy on 16/3/5.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASByrToken.h"
#import "ASByrResponse.h"
#import "AFNetworking.h"

typedef void (^ASSuccessCallback)(NSInteger statusCode, id response);
typedef void (^ASFailureCallback)(NSInteger statusCode, id response);

@interface ASByrBase : NSObject

@property(strong, nonatomic) NSString *accessToken;

- (instancetype)initWithAccessToken:(NSString*)accessToken;

- (ASByrResponse*)sendRequestWithUrl:(NSString *) urlStr
                    method:(NSString *) method
                parameters:(id) parameters;

- (void)sendRequestWithUrl:(NSString *) urlStr
                    method:(NSString *) method
                parameters:(id) parameters
                   success:(ASSuccessCallback) successCallback
                   failure:(ASFailureCallback) failureCallback;

- (void)sendRequestWithUrl:(NSString *)urlStr
                    method:(NSString *)method
                parameters:(id) parameters
                  delegate:(id) delegate
                  callback:(SEL) callback
                  reformer:(id) reformer
                reformFunc:(SEL) reformFunc;
@end

@interface XQSessionManager : AFHTTPSessionManager

+ (XQSessionManager *)sharedHttpSessionManager;

@end
