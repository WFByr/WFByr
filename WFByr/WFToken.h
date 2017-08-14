//
//  WFToken.h
//  WFByr
//
//  Created by Andy on 2017/8/14.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFToken : NSObject

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, assign) NSInteger expiresIn;
@property (nonatomic, copy) NSString *refreshToken;

+ (instancetype)shareToken;

- (void)setupWithAccesssToken:(NSString *)accessToken
                 refreshToken:(NSString*)refreshToken
                    expiresIn:(NSInteger)expiresIn;

- (BOOL)valid;
@end
