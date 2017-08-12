//
//  WFLoginApi.m
//  WFByr
//
//  Created by Andy on 2017/8/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFLoginApi.h"
#import "WFNetworkExecutor.h"
#import "WFByrConst.h"
#import "WFToken.h"

@implementation WFLoginApi

- (void)loginWithUserName:(NSString *)name password:(NSString *)pwd success:(void (^)())successBlk fail:(void (^)())failBlk {
    NSDictionary *parameters = @{@"source":@"1502546984-1",
                                 @"username":[[name dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0],
                                 @"password":[[pwd dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0],
                                 @"appkey":WFByrAppKey};
    [WFNetworkExecutor requestWithUrl:@"https://bbs.byr.cn/oauth2/official" parameters:parameters option:WFRequestOptionPost complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (!error) {
            WFToken *token = [WFToken shareToken];
            [token setupWithAccesssToken:[obj valueForKey:@"access_token"]
                            refreshToken:@""
                               expiresIn:[[obj valueForKey:@"expires_in"] integerValue]];
            if (successBlk) {
                successBlk();
            }
        } else {
            if (failBlk) {
                failBlk();
            }
        }
        
        
    }];
}

@end
