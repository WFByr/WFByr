//
//  ASByrAttachment.h
//  ASByr
//
//  Created by andy on 16/3/8.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBase.h"
#import "ASByrConfig.h"

@class XQByrAttachment;

@interface ASByrAttachment : ASByrBase

- (ASByrAttachment*)initWithAccessToken:(NSString*)token;

- (void)fetchAttachmentWithBoard:(NSString*)board
                    successBlock:(ASSuccessCallback)success
                    failureBlock:(ASSuccessCallback)failure;

- (void)fetchAttachmentWithBoard:(NSString*)board
                             aid:(NSInteger)aid
                    successBlock:(ASSuccessCallback)success
                    failureBlock:(ASSuccessCallback)failure;

#warning todo
- (void)addAttachmentWithBoard:(NSString*)board
                          file:(NSURL*)file
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASSuccessCallback)failure;

- (void)addAttachmentWithBoard:(NSString*)board
                           aid:(NSInteger)aid
                          file:(NSURL*)file
                  successBlock:(ASSuccessCallback)success
                  failureBlock:(ASSuccessCallback)failure;

#warning not tested
- (void)deleteAttachmentWithBoard:(NSString*)board
                             file:(NSString*)file
                     successBlock:(ASSuccessCallback)success
                     failureBlock:(ASSuccessCallback)failure;

- (void)deleteAttachmentWithBoard:(NSString*)board
                              aid:(NSInteger)aid
                             file:(NSString*)file
                     successBlock:(ASSuccessCallback)success
                     failureBlock:(ASSuccessCallback)failure;
@end
