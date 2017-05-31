//
//  ASByrToken.h
//  ASByr
//
//  Created by andy on 16/3/6.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WFToken : NSObject

@property(strong, nonatomic) NSString *accessToken;
@property(strong, nonatomic) NSString *refreshToken;
@property(assign, nonatomic) NSInteger expiresIn;

+ (instancetype)shareToken;

- (void)setupWithAccesssToken:(NSString *)accessToken
                 refreshToken:(NSString*)refreshToken
                    expiresIn:(NSInteger)expiresIn;

- (BOOL)valid;

@end
