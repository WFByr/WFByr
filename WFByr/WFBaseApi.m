//
//  ASByrBase.m
//  ASByr
//
//  Created by andy on 16/3/5.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFBaseApi.h"
#import "WFByrConst.h"
#import "WFToken.h"

@implementation WFResponse


@end

@interface WFSessionManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation WFSessionManager

+ (WFSessionManager *)sharedHttpSessionManager{
    static WFSessionManager * sessionManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[WFSessionManager alloc] init];
    });
    return sessionManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:WFByrBaseUrl]];
    }
    return self;
}

@end

@interface WFBaseApi()


@end

@implementation WFBaseApi

- (void)sendRequestWithUrl:(NSString *)urlStr
                    method:(NSString *)method
                    parameters:(id) parameters
                   success:(WFSuccessCallback)successCallback
                   failure:(WFFailureCallback)failureCallback{
    
    NSMutableDictionary *params = parameters ? [NSMutableDictionary dictionaryWithDictionary:parameters] : [NSMutableDictionary dictionary];
    [params setObject:[WFToken shareToken].accessToken forKey:@"oauth_token"];
    
    WFSessionManager * manager = [WFSessionManager sharedHttpSessionManager];
    if ([method  isEqual:WFHTTPGet]) {
        if (![[manager.sessionManager reachabilityManager] isReachable]) {
            manager.sessionManager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
        }
        [manager.sessionManager wf_GET:[NSString stringWithFormat:@"%@%@", urlStr, WFReturnFormat] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (successCallback) {
                    successCallback(response.statusCode, responseObject);
                }
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error, id responseObject) {
            NSDictionary *json  = nil;
            if ([error.userInfo valueForKey:AFNetworkingOperationFailingURLResponseDataErrorKey] != nil) {
                json = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:kNilOptions  error:nil];
            } else {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    json = responseObject;
                }
            }
        
            NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failureCallback) {
                    failureCallback(response.statusCode, json);
                }
            });
        }];
    } else {
        
        [manager.sessionManager wf_POST:[NSString stringWithFormat:@"%@%@", urlStr, WFReturnFormat] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (successCallback) {
                    successCallback(response.statusCode, responseObject);
                }
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error, id responseObject) {
            NSDictionary *json  = nil;
            if ([error.userInfo valueForKey:AFNetworkingOperationFailingURLResponseDataErrorKey] != nil) {
                json = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:kNilOptions  error:nil];
            } else {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    json = responseObject;
                }
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
    
    void (^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error, id _Nullable responseObject) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error, id _Nullable responseObject) {
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
    [params setObject:[WFToken shareToken].accessToken forKey:@"oauth_token"];
    
    WFSessionManager * manager = [WFSessionManager sharedHttpSessionManager];

    //AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BYR_BASE_URL]];
    if ([method  isEqual: WFHTTPGet]) {
        [manager.sessionManager wf_GET:[NSString stringWithFormat:@"%@%@", urlStr, WFReturnFormat]
          parameters:params
             success:successBlock
             failure:failureBlock];
    } else {
        [manager.sessionManager wf_POST:[NSString stringWithFormat:@"%@%@", urlStr, WFReturnFormat]
           parameters:params
              success:successBlock
              failure:failureBlock];
    }
    
}


@end
