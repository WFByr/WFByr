//
//  WFLoginApi.h
//  WFByr
//
//  Created by Andy on 2017/8/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WFToken;

@interface WFLoginService : NSObject

+ (void)loginWithUserName:(NSString *)name password:(NSString *)pwd
                  success:(void (^)(NSURLResponse *response, WFToken *token))successBlk
                     fail:(void (^)(NSURLResponse *response, NSError *error))failBl;
@end
