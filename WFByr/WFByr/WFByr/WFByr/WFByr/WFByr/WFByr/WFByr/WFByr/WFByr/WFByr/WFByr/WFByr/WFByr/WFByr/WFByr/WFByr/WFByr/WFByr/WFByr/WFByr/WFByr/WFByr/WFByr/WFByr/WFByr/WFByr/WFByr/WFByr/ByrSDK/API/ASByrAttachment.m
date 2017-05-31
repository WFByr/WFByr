//
//  ASByrAttachment.m
//  ASByr
//
//  Created by andy on 16/3/8.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrAttachment.h"
#import "XQByrAttachment.h"
#import "YYModel.h"
@implementation ASByrAttachment

- (ASByrAttachment*)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    return self;
}

- (void)fetchAttachmentWithBoard:(NSString *)board
                    successBlock:(ASSuccessCallback)success
                    failureBlock:(ASSuccessCallback)failure {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/", BYR_ATTACHMENT_URL, board] method:HTTP_GET parameters:nil success:success failure:failure];
    
}
- (void)fetchAttachmentWithBoard:(NSString *)board
                             aid:(NSInteger)aid
                    successBlock:(ASSuccessCallback)success
                    failureBlock:(ASSuccessCallback)failure {
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/%ld", BYR_ATTACHMENT_URL, board, (long)aid] method:HTTP_GET parameters:nil success:success failure:failure];
    
}

- (void)addAttachmentWithBoard:(NSString *)board
                          file:(NSURL *)file
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASFailureCallback)failure {
    return [self addAttachmentWithBoard:board aid:-1 file:file successBlock:success failureBlock:failure];
    
}

- (void)addAttachmentWithBoard:(NSString *)board
                           aid:(NSInteger)aid
                          file:(NSURL *)file
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASFailureCallback)failure {
    NSString *url = [NSString stringWithFormat:@"http://bbs.byr.cn/open/attachment/Advertising/add/%ld.json", (long)aid];
    NSDictionary *parameters = @{@"oauth_token":self.accessToken};
    
    NSError *err;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSError *err2;
        [formData appendPartWithFileURL:file name:@"file" error:&err2];
        if (err2) {
            NSLog(@"err2:%@", err2);
        }
        
    } error:&err];
    
    if (err) {
        NSLog(@"%@", err);
        return;
    }
    
    NSURLSessionUploadTask *uploadTask = [[XQSessionManager sharedHttpSessionManager] uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploading");
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
                success(1, [XQByrAttachment yy_modelWithJSON:responseObject]);
            });
        }
    }];
    [uploadTask resume];
}

- (void)deleteAttachmentWithBoard:(NSString *)board
                             file:(NSString *)file
                     successBlock:(ASSuccessCallback)success
                     failureBlock:(ASSuccessCallback)failure {
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:file forKey:@"name"];
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/delete/", BYR_ATTACHMENT_URL, board] method:HTTP_POST parameters:parameters success:success failure:failure];
}

- (void)deleteAttachmentWithBoard:(NSString *)board
                              aid:(NSInteger)aid
                             file:(NSString *)file
                     successBlock:(ASSuccessCallback)success
                     failureBlock:(ASSuccessCallback)failure {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:file forKey:@"name"];
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/delete/%ld", BYR_ATTACHMENT_URL, board, aid] method:HTTP_POST parameters:parameters success:success failure:failure];
}
@end
