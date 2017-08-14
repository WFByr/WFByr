//
//  WFLoginApi.m
//  WFByr
//
//  Created by Andy on 2017/8/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFLoginService.h"
#import "WFNetworkExecutor.h"
#import "WFByrConst.h"
#import "WFToken.h"
#import "YYModel.h"

@implementation WFLoginService

+ (void)loginWithUserName:(NSString *)name password:(NSString *)pwd
                  success:(void (^)(NSURLResponse *response, WFToken *token))successBlk
                     fail:(void (^)(NSURLResponse *response, NSError *error))failBlk {
    NSDictionary *parameters = @{@"source":@"1502546984-1",
                                 @"username":[[name dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0],
                                 @"password":[[pwd dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0],
                                 @"appkey":WFByrAppKey};
    [WFNetworkExecutor requestWithUrl:@"https://bbs.byr.cn/oauth2/official" parameters:parameters option:WFRequestOptionPost complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
//        if (obj.code != 0 && obj.msg) {
//            error = [NSError errorWithDomain:NSURLErrorDomain code:obj.code userInfo:@{NSLocalizedDescriptionKey:obj.msg}];
//        }
        if (!error) {
            WFToken *token = [WFToken yy_modelWithJSON:obj];
            if (successBlk) {
                successBlk(response, token);
            }
        } else {
            if (failBlk) {
                failBlk(response, error);
            }
        }
    }];
}

@end
