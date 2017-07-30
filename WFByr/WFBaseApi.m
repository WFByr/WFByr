//
//  ASByrBase.m
//  ASByr
//
//  Created by andy on 16/3/5.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFBaseApi.h"
#import "WFByrConst.h"

@implementation WFResponse


@end



@implementation WFSessionManager

+ (WFSessionManager *)sharedHttpSessionManager{
    static WFSessionManager * sessionManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:WFByrBaseUrl]];
    });
    return sessionManager;
}

@end

@interface WFBaseApi()


@end

@implementation WFBaseApi


- (instancetype)initWithAccessToken:(NSString*)accessToken {
    self = [super init];
    if (self) {
        self.accessToken = accessToken ? accessToken : @"";
    }
    return self;
}

- (void)sendRequestWithUrl:(NSString *)urlStr
                    method:(NSString *)method
                    parameters:(id) parameters
                   success:(WFSuccessCallback)successCallback
                   failure:(WFFailureCallback)failureCallback{
    
    NSMutableDictionary *params = parameters ? [NSMutableDictionary dictionaryWithDictionary:parameters] : [NSMutableDictionary dictionary];
    [params setObject:self.accessToken forKey:@"oauth_token"];
    
    WFSessionManager * manager = [WFSessionManager sharedHttpSessionManager];
    //AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BYR_BASE_URL]];
    if ([method  isEqual: WFHTTPGet]) {
        if (![[manager reachabilityManager] isReachable]) {
            manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
        }
        [manager GET:[NSString stringWithFormat:@"%@%@", urlStr, WFReturnFormat] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (successCallback) {
                    successCallback(response.statusCode, responseObject);
                }
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSDictionary *json  = nil;
            if ([error.userInfo valueForKey:AFNetworkingOperationFailingURLResponseDataErrorKey] != nil) {
                json = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:kNilOptions  error:nil];
            }
            
            NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failureCallback) {
                    failureCallback(response.statusCode, json);
                }
            });
        }];
    } else {
        
        [manager POST:[NSString stringWithFormat:@"%@%@", urlStr, WFReturnFormat] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (successCallback) {
                    successCallback(response.statusCode, responseObject);
                }
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSDictionary *json  = nil;
            if ([error.userInfo valueForKey:AFNetworkingOperationFailingURLResponseDataErrorKey] != nil) {
                json = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:kNilOptions  error:nil];
            }
            NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failureCallback) {
                    failureCallback(response.statusCode, json);
                }
            });
        }];
    }
    
}

- (void)sendRequestWithUrl:(NSString *)urlStr
                    method:(NSString *)method
                parameters:(id) parameters
                  delegate:(id) delegate
                  callback:(SEL) callback
                  reformer:(id) reformer
                reformFunc:(SEL) reformFunc{
    void (^successBlock)(NSURLSessionDataTask*, id) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        WFResponse *byrResponse = [[WFResponse alloc] init];
        byrResponse.statusCode = response.statusCode;
        byrResponse.response   = responseObject;
        byrResponse.isSucceeded = YES;
        if (reformer) {
            byrResponse = [reformer performSelector:reformFunc withObject:byrResponse];
        }
        [delegate performSelector:callback withObject:byrResponse];
    };
    
    void (^failureBlock)(NSURLSessionDataTask*, NSError*) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *json  = nil;
        if ([error.userInfo valueForKey:AFNetworkingOperationFailingURLResponseDataErrorKey] != nil) {
            json = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:kNilOptions  error:nil];
        }else{//无网络时
            json = [NSDictionary dictionaryWithObjectsAndKeys:error.userInfo[NSLocalizedDescriptionKey],@"msg",error.userInfo[NSURLErrorFailingURLErrorKey],@"request",nil];
        }
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        WFResponse *byrResponse = [[WFResponse alloc] init];
        byrResponse.statusCode = response.statusCode;
        byrResponse.response   = json;
        if (reformer) {
            byrResponse = [reformer performSelector:reformFunc withObject:byrResponse];
        }
        [delegate performSelector:callback withObject:byrResponse];
    };
    
    NSMutableDictionary *params = parameters ? [NSMutableDictionary dictionaryWithDictionary:parameters] : [NSMutableDictionary dictionary];
    [params setObject:self.accessToken forKey:@"oauth_token"];
    
    WFSessionManager * manager = [WFSessionManager sharedHttpSessionManager];

    //AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BYR_BASE_URL]];
    if ([method  isEqual: WFHTTPGet]) {
        [manager GET:[NSString stringWithFormat:@"%@%@", urlStr, WFReturnFormat]
          parameters:params
            progress:nil
             success:successBlock
             failure:failureBlock];
    } else {
        [manager POST:[NSString stringWithFormat:@"%@%@", urlStr, WFReturnFormat]
           parameters:params
             progress:nil
              success:successBlock
              failure:failureBlock];
    }
    
}


@end
