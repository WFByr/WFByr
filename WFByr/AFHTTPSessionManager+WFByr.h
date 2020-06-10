//
//  AFHTTPSessionManager+WFByr.h
//  WFByr
//
//  Created by 李向前 on 2020/4/18.
//  Copyright © 2020 andy. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPSessionManager (WFByr)

- (NSURLSessionDataTask *)wf_dataTaskWithHTTPMethod:(NSString *)method
                                          URLString:(NSString *)URLString
                                         parameters:(id)parameters
                                     uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                   downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                            success:(void (^)(NSURLSessionDataTask *, id))success
                                            failure:(void (^)(NSURLSessionDataTask *, NSError *, id responseObject))failure;

- (NSURLSessionDataTask *)wf_GET:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error, id responseObject))failure;

- (NSURLSessionDataTask *)wf_HEAD:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error, id _Nullable responseObject))failure;

- (NSURLSessionDataTask *)wf_POST:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error, id responseObject))failure;
@end

NS_ASSUME_NONNULL_END
