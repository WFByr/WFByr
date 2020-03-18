//
//  ASByrAttachment.m
//  ASByr
//
//  Created by andy on 16/3/8.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFAttachmentApi.h"
#import "WFByrConst.h"
#import "WFAttachment.h"
#import "YYModel.h"

@implementation WFAttachmentApi

- (WFAttachmentApi*)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    return self;
}

- (void)fetchAttachmentWithBoard:(NSString *)board
                    successBlock:(WFSuccessCallback)success
                    failureBlock:(WFFailureCallback)failure {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/", WFByrAttachmentUrl, board] method:WFHTTPGet parameters:nil success:success failure:failure];
    
}
- (void)fetchAttachmentWithBoard:(NSString *)board
                             aid:(NSInteger)aid
                    successBlock:(WFSuccessCallback)success
                    failureBlock:(WFFailureCallback)failure {
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/%ld", WFByrAttachmentUrl, board, (long)aid] method:WFHTTPGet parameters:nil success:success failure:failure];
    
}

- (void)addAttachmentWithBoard:(NSString *)board
                          file:(NSURL *)file
                  successBlock:(WFSuccessCallback)success
                  failureBlock:(WFFailureCallback)failure {
    return [self addAttachmentWithBoard:board aid:-1 file:file successBlock:success failureBlock:failure];
    
}

- (void)addAttachmentWithBoard:(NSString *)board
                           aid:(NSInteger)aid
                          file:(NSURL *)file
                  successBlock:(WFSuccessCallback)success
                  failureBlock:(WFFailureCallback)failure {
    NSString *url = [NSString stringWithFormat:@"http://bbs.byr.cn/open/attachment/Advertising/add/%ld.json", (long)aid];
    NSDictionary *parameters = @{@"oauth_token":self.accessToken};
    
    NSError *err;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSError *err2;
        [formData appendPartWithFileURL:file name:@"file" error:&err2];
        if (err2) {
            WFErrorInfo(@"%s err2:%@", __func__, err2);
        }
        
    } error:&err];
    
    if (err) {
        WFErrorInfo(@"%s %@", __func__, err);
        return;
    }
    
    NSURLSessionUploadTask *uploadTask = [[WFSessionManager sharedHttpSessionManager] uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        WFLogInfo(@"%s uploading", __func__);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(-1, responseObject);
                });
            }
            return;
        }
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(1, [WFAttachment yy_modelWithJSON:responseObject]);
            });
        }
    }];
    [uploadTask resume];
}

- (void)deleteAttachmentWithBoard:(NSString *)board
                             file:(NSString *)file
                     successBlock:(WFSuccessCallback)success
                     failureBlock:(WFFailureCallback)failure {
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:file forKey:@"name"];
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/delete/", WFByrAttachmentUrl, board] method:WFHTTPPost parameters:parameters success:success failure:failure];
}

- (void)deleteAttachmentWithBoard:(NSString *)board
                              aid:(NSInteger)aid
                             file:(NSString *)file
                     successBlock:(WFSuccessCallback)success
                     failureBlock:(WFFailureCallback)failure {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:file forKey:@"name"];
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/delete/%ld", WFByrAttachmentUrl, board, aid] method:WFHTTPPost parameters:parameters success:success failure:failure];
}
@end
