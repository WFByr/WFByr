//
//  ASByrBase.h
//  ASByr
//
//  Created by andy on 16/3/5.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFToken.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager+WFByr.h"


typedef void (^WFSuccessCallback)(NSInteger statusCode, id response);
typedef void (^WFFailureCallback)(NSInteger statusCode, id response);

@interface WFResponse : NSObject

@property(nonatomic, assign) BOOL isSucceeded;

@property(nonatomic, assign) NSInteger statusCode;

@property(nonatomic, strong) id response;

@property(nonatomic, strong) id reformedData;

@end

@interface WFSessionManager : NSObject

@property (nonatomic, strong, readonly) AFHTTPSessionManager *sessionManager;

+ (WFSessionManager *)sharedHttpSessionManager;

@end

@interface WFBaseApi : NSObject


- (WFResponse*)sendRequestWithUrl:(NSString *) urlStr
                    method:(NSString *) method
                parameters:(id) parameters;

- (void)sendRequestWithUrl:(NSString *) urlStr
                    method:(NSString *) method
                parameters:(id) parameters
                   success:(WFSuccessCallback) successCallback
                   failure:(WFFailureCallback) failureCallback;

- (void)sendRequestWithUrl:(NSString *)urlStr
                    method:(NSString *)method
                parameters:(id) parameters
                  delegate:(id) delegate
                  callback:(SEL) callback
                  reformer:(id) reformer
                reformFunc:(SEL) reformFunc;
@end
