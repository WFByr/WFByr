//
//  ASByrMail.m
//  ASByr
//
//  Created by andy on 16/3/9.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrMail.h"
#import "ASByrConfig.h"

@implementation ASByrMail

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    if (self) {
        
    }
    return self;
}

- (NSString*)boxStrWithBox:(ASByrMailbox)box {
    switch (box) {
        case ASByrMailOutbox:
            return @"outbox";
        case ASByrMailDeleted:
            return @"deleted";
        default:
            return @"inbox";
    }
}

- (void)fetchInboxmailsWithSuccessBlock:(ASSuccessCallback)success
                           failureBlock:(ASSuccessCallback)failure {
    [self fetchMailsWithBox:ASByrMailInbox count:20 page:1 successBlock:success failureBlock:failure];
}

- (void)fetchInboxmailsWithPage:(NSInteger)page
                   successBlock:(ASSuccessCallback)success
                   failureBlock:(ASSuccessCallback)failure {
    
    [self fetchMailsWithBox:ASByrMailInbox count:20 page:page successBlock:success failureBlock:failure];
}

- (void)fetchInboxmailsWithCount:(NSInteger)count
                            page:(NSInteger)page
                    successBlock:(ASSuccessCallback)success
                    failureBlock:(ASSuccessCallback)failure {
    [self fetchMailsWithBox:ASByrMailInbox count:count page:page successBlock:success failureBlock:failure];
}

- (void)fetchOutboxmailsWithSuccessBlock:(ASSuccessCallback)success
                            failureBlock:(ASSuccessCallback)failure {
    [self fetchMailsWithBox:ASByrMailOutbox count:20 page:1 successBlock:success failureBlock:failure];
}

- (void)fetchOutboxmailsWithPage:(NSInteger)page
                    successBlock:(ASSuccessCallback)success
                    failureBlock:(ASSuccessCallback)failure {
    [self fetchMailsWithBox:ASByrMailOutbox count:20 page:page successBlock:success failureBlock:failure];
}

- (void)fetchOutboxmailsWithCount:(NSInteger)count
                             page:(NSInteger)page
                     successBlock:(ASSuccessCallback)success
                     failureBlock:(ASSuccessCallback)failure {
    [self fetchMailsWithBox:ASByrMailOutbox count:count page:page successBlock:success failureBlock:failure];
}

- (void)fetchDeletedmailsWithSuccessBlock:(ASSuccessCallback)success
                             failureBlock:(ASSuccessCallback)failure {
    [self fetchMailsWithBox:ASByrMailDeleted count:20 page:1 successBlock:success failureBlock:failure];
}

- (void)fetchDeletedboxmailsWithPage:(NSInteger)page
                        successBlock:(ASSuccessCallback)success
                        failureBlock:(ASSuccessCallback)failure {
    [self fetchMailsWithBox:ASByrMailDeleted count:20 page:page successBlock:success failureBlock:failure];
}

- (void)fetchDeletedboxmailsWithCount:(NSInteger)count
                                 page:(NSInteger)page
                         successBlock:(ASSuccessCallback)success
                         failureBlock:(ASSuccessCallback)failure {
   [self fetchMailsWithBox:ASByrMailDeleted count:count page:page successBlock:success failureBlock:failure];
}

- (void)fetchMailsWithBox:(ASByrMailbox)box
                   count:(NSInteger)count
                    page:(NSInteger)page
            successBlock:(ASSuccessCallback)success
            failureBlock:(ASSuccessCallback)failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *boxStr = [self boxStrWithBox:box];
    if (count > 0) {
        [parameters setObject:[@(count) stringValue] forKey:@"count"];
    }
    if (page > 0) {
        [parameters setObject:[@(page) stringValue] forKey:@"page"];
    }

    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@", BYR_MAIL_URL, boxStr] method:HTTP_GET parameters:parameters success:success failure:failure];
}

- (void)fetchMailInfoWithSuccessBlock:(ASSuccessCallback)success
                         failureBlock:(ASSuccessCallback)failure {
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/info", BYR_MAIL_URL] method:HTTP_GET parameters:nil success:success failure:failure];
}

- (void)fetchMailWithBox:(ASByrMailbox)box
                     num:(NSInteger)num
            successBlock:(ASSuccessCallback)success
            failureBlock:(ASSuccessCallback)failure {
    NSString *boxStr = [self boxStrWithBox:box];
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/%ld", BYR_MAIL_URL, boxStr, num] method:HTTP_GET parameters:nil success:success failure:failure];
}

- (void)sendMailWithUid:(NSString *)uid
                  title:(NSString *)title
                content:(NSString *)content
              signature:(BOOL)signature
                 backup:(BOOL)backup
           successBlock:(ASSuccessCallback)success
           failureBlock:(ASSuccessCallback)failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:uid forKey:@"id"];
    if (title) {
        [parameters setObject:title forKey:@"title"];
    }
    if (content) {
        [parameters setObject:content forKey:@"content"];
    }
    [parameters setObject:[@(signature) stringValue] forKey:@"signature"];
    [parameters setObject:[@(backup) stringValue] forKey:@"backup"];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/send", BYR_MAIL_URL] method:HTTP_POST parameters:parameters success:success failure:failure];
}

- (void)forwardMailWithBox:(ASByrMailbox)box
                       num:(NSInteger)num
                    target:(NSString *)target
              successBlock:(ASSuccessCallback)success
              failureBlock:(ASSuccessCallback)failure {
    [self forwardMailWithBox:box num:num target:target noansi:NO big5:NO successBlock:success failureBlock:failure];
}

- (void)forwardMailWithBox:(ASByrMailbox)box
                       num:(NSInteger)num
                    target:(NSString *)target
                    noansi:(BOOL)noansi
                      big5:(BOOL)big5
              successBlock:(ASSuccessCallback)success
              failureBlock:(ASSuccessCallback)failure {
    NSString *boxStr = [self boxStrWithBox:box];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:target forKey:@"target"];
    if (noansi) {
        [parameters  setObject:@"1" forKey:@"noansi"];
    }
    if (big5) {
        [parameters setObject:@"1" forKey:@"big5"];
    }
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/forward/%ld", BYR_MAIL_URL, boxStr, num] method:HTTP_POST parameters:parameters success:success failure:failure];
}

- (void)replyMailWithBox:(ASByrMailbox)box
                     num:(NSInteger)num
                   title:(NSString *)title
                 content:(NSString *)content
               signature:(BOOL)signature
                  backup:(BOOL)backup
            successBlock:(ASSuccessCallback)success
            failureBlock:(ASSuccessCallback)failure {
    NSString *boxStr = [self boxStrWithBox:box];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (title) {
        [parameters setObject:title forKey:@"title"];
    }
    if (content) {
        [parameters setObject:content forKey:@"content"];
    }
    [parameters setObject:[@(signature) stringValue] forKey:@"signature"];
    [parameters setObject:[@(backup) stringValue] forKey:@"backup"];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/reply/%ld", BYR_MAIL_URL, boxStr, num] method:HTTP_POST parameters:parameters success:success failure:failure];
}

- (void)deleteMailWithBox:(ASByrMailbox)box
                      num:(NSInteger)num
             successBlock:(ASSuccessCallback)success
             failureBlock:(ASSuccessCallback)failure {
    NSString *boxStr = [self boxStrWithBox:box];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%@/delete/%ld", BYR_MAIL_URL, boxStr, num] method:HTTP_POST parameters:nil success:success failure:failure];
}
@end
