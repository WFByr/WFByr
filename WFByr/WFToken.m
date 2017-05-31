//
//  ASByrToken.m
//  ASByr
//
//  Created by andy on 16/3/6.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFToken.h"

NSString * const kAccessTokenKey  = @"access_token";
NSString * const kRefreshTokenKey = @"refresh_token";
NSString * const kExpiresInKey    = @"expires_in";

@interface WFToken()

@end


@implementation WFToken

static id _instance;


+ (instancetype)shareToken {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [WFToken alloc];
    });
    [_instance initFromStorage];
    return _instance;
}

- (instancetype)initFromStorage {
    self = [super init];
    if (self) {
        self.accessToken  = [[NSUserDefaults standardUserDefaults] objectForKey:kAccessTokenKey];
        self.refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:kRefreshTokenKey];
        self.expiresIn    = [[NSUserDefaults standardUserDefaults] integerForKey:kExpiresInKey];
    }
    return self;
}

- (void)setupWithAccesssToken:(NSString *)accessToken
                 refreshToken:(NSString*)refreshToken
                    expiresIn:(NSInteger)expiresIn {
    self.accessToken = accessToken;
    self.refreshToken = refreshToken;
    self.expiresIn = expiresIn;
    [[NSUserDefaults standardUserDefaults] setObject:self.accessToken  forKey:kAccessTokenKey];
    [[NSUserDefaults standardUserDefaults] setInteger:self.expiresIn   forKey:kRefreshTokenKey];
    [[NSUserDefaults standardUserDefaults] setObject:self.refreshToken forKey:kExpiresInKey];
}

- (BOOL)valid {
    if (self.accessToken) {
        return YES;
    }
    return NO;
}

@end
