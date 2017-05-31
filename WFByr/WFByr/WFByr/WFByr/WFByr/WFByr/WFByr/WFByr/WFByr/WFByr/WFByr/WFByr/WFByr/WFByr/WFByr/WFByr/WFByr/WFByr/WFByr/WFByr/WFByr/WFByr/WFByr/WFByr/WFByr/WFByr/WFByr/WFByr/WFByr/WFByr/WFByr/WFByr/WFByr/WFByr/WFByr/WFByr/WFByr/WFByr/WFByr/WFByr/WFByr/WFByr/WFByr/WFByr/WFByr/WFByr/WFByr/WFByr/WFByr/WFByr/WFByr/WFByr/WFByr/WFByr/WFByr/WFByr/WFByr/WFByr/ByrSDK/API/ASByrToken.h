//
//  ASByrToken.h
//  ASByr
//
//  Created by andy on 16/3/6.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ACCESS_TOKEN  @"access_token"
#define REFRESH_TOKEN @"refresh_token"
#define EXPIRES_IN    @"expires_in"

@interface ASByrToken : NSObject

@property(strong, nonatomic) NSString *accessToken;
@property(strong, nonatomic) NSString *refreshToken;
@property(assign, nonatomic) NSInteger expiresIn;

+ (instancetype)shareInstance;

- (void)setupWithAccesssToken:(NSString *)accessToken
                 refreshToken:(NSString*)refreshToken
                    expiresIn:(NSInteger)expiresIn;

//- (instancetype)initWithAccesssToken:(NSString *)accessToken
//                        refreshToken:(NSString*)refreshToken
//                           expiresIn:(NSInteger) expiresIn;
//
//- (instancetype)initWithAccesssToken:(NSString *)accessToken;
//
//- (instancetype)initFromStorage;
//
//- (void)saveToken;

- (BOOL)valid;

@end
