//
//  ASByrAttachment.h
//  ASByr
//
//  Created by andy on 16/3/8.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFBaseApi.h"

@class WfAttachment;

@interface WFAttachmentApi : WFBaseApi

- (WFAttachmentApi*)initWithAccessToken:(NSString*)token;

- (void)fetchAttachmentWithBoard:(NSString*)board
                    successBlock:(WFSuccessCallback)success
                    failureBlock:(WFFailureCallback)failure;

- (void)fetchAttachmentWithBoard:(NSString*)board
                             aid:(NSInteger)aid
                    successBlock:(WFSuccessCallback)success
                    failureBlock:(WFFailureCallback)failure;

#warning todo
- (void)addAttachmentWithBoard:(NSString*)board
                          file:(NSURL*)file
                  successBlock:(WFSuccessCallback)success
                  failureBlock:(WFFailureCallback)failure;

- (void)addAttachmentWithBoard:(NSString*)board
                           aid:(NSInteger)aid
                          file:(NSURL*)file
                  successBlock:(WFSuccessCallback)success
                  failureBlock:(WFFailureCallback)failure;

#warning not tested
- (void)deleteAttachmentWithBoard:(NSString*)board
                             file:(NSString*)file
                     successBlock:(WFSuccessCallback)success
                     failureBlock:(WFFailureCallback)failure;

- (void)deleteAttachmentWithBoard:(NSString*)board
                              aid:(NSInteger)aid
                             file:(NSString*)file
                     successBlock:(WFSuccessCallback)success
                     failureBlock:(WFFailureCallback)failure;
@end
