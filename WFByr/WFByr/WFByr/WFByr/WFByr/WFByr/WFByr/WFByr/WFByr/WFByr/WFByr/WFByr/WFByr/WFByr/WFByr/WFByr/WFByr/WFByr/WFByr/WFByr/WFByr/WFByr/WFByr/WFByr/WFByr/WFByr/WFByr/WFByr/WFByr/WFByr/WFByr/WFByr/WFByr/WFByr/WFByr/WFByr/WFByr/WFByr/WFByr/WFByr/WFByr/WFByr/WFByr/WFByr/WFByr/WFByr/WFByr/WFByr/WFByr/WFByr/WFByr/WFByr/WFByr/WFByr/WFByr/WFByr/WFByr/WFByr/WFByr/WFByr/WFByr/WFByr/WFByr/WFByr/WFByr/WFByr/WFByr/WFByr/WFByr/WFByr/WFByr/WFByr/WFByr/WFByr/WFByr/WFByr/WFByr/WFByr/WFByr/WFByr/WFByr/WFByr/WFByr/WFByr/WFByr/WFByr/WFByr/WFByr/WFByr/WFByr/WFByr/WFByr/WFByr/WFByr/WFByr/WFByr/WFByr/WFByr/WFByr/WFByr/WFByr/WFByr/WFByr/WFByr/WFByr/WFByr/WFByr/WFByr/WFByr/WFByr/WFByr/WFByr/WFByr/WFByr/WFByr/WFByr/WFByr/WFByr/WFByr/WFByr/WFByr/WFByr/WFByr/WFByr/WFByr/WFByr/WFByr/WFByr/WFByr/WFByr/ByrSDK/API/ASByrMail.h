//
//  ASByrMail.h
//  ASByr
//
//  Created by andy on 16/3/9.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrBase.h"

typedef enum{
    ASByrMailInbox,
    ASByrMailOutbox,
    ASByrMailDeleted
}ASByrMailbox;


@interface ASByrMail : ASByrBase

- (instancetype)initWithAccessToken:(NSString *)token;

- (void)fetchInboxmailsWithSuccessBlock:(ASSuccessCallback)success
                           failureBlock:(ASSuccessCallback)failure;

- (void)fetchInboxmailsWithPage:(NSInteger)page
                   successBlock:(ASSuccessCallback)success
                   failureBlock:(ASSuccessCallback)failure;

- (void)fetchInboxmailsWithCount:(NSInteger)count
                            page:(NSInteger)page
                    successBlock:(ASSuccessCallback)success
                    failureBlock:(ASSuccessCallback)failure;

- (void)fetchOutboxmailsWithSuccessBlock:(ASSuccessCallback)success
                           failureBlock:(ASSuccessCallback)failure;

- (void)fetchOutboxmailsWithPage:(NSInteger)page
                   successBlock:(ASSuccessCallback)success
                   failureBlock:(ASSuccessCallback)failure;

- (void)fetchOutboxmailsWithCount:(NSInteger)count
                            page:(NSInteger)page
                    successBlock:(ASSuccessCallback)success
                    failureBlock:(ASSuccessCallback)failure;

- (void)fetchDeletedmailsWithSuccessBlock:(ASSuccessCallback)success
                            failureBlock:(ASSuccessCallback)failure;

- (void)fetchDeletedboxmailsWithPage:(NSInteger)page
                    successBlock:(ASSuccessCallback)success
                    failureBlock:(ASSuccessCallback)failure;

- (void)fetchDeletedboxmailsWithCount:(NSInteger)count
                             page:(NSInteger)page
                     successBlock:(ASSuccessCallback)success
                     failureBlock:(ASSuccessCallback)failure;

- (void)fetchMailsWithBox:(ASByrMailbox)box
                   count:(NSInteger)count
                    page:(NSInteger)page
            successBlock:(ASSuccessCallback)success
            failureBlock:(ASSuccessCallback)failure;


- (void)fetchMailInfoWithSuccessBlock:(ASSuccessCallback)success
                         failureBlock:(ASSuccessCallback)failure;

- (void)fetchMailWithBox:(ASByrMailbox)box
                     num:(NSInteger)num
            successBlock:(ASSuccessCallback)success
            failureBlock:(ASSuccessCallback)failure;

- (void)sendMailWithUid:(NSString*)uid
                  title:(NSString*)title
                content:(NSString*)content
              signature:(BOOL)signature
                 backup:(BOOL)backup
           successBlock:(ASSuccessCallback)success
           failureBlock:(ASSuccessCallback)failure;

- (void)forwardMailWithBox:(ASByrMailbox)box
                       num:(NSInteger)num
                    target:(NSString*)target
              successBlock:(ASSuccessCallback)success
              failureBlock:(ASSuccessCallback)failure;

- (void)forwardMailWithBox:(ASByrMailbox)box
                       num:(NSInteger)num
                    target:(NSString*)target
                    noansi:(BOOL)noansi
                      big5:(BOOL)big5
              successBlock:(ASSuccessCallback)success
              failureBlock:(ASSuccessCallback)failure;

- (void)replyMailWithBox:(ASByrMailbox)box
                     num:(NSInteger)num
                   title:(NSString*)title
                 content:(NSString*)content
               signature:(BOOL)signature
                  backup:(BOOL)backup
           successBlock:(ASSuccessCallback)success
           failureBlock:(ASSuccessCallback)failure;

- (void)deleteMailWithBox:(ASByrMailbox)box
                      num:(NSInteger)num
             successBlock:(ASSuccessCallback)success
             failureBlock:(ASSuccessCallback)failure;

@end
