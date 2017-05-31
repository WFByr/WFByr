//
//  ASByrFav.m
//  ASByr
//
//  Created by andy on 16/3/9.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "ASByrFav.h"
#import "ASByrConfig.h"

@implementation ASByrFav

- (instancetype)initWithAccessToken:(NSString *)token {
    self = [super initWithAccessToken:token];
    return self;
}

- (void)fetchFavsWithLevel:(NSInteger)level
              successBlock:(ASSuccessCallback)success
              failureBlock:(ASSuccessCallback)failure {
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:[@(level) stringValue] forKey:@"level"];
    
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/%ld", BYR_FAVORITE_URL, level] method:HTTP_GET parameters:parameters success:success failure:failure];
}

- (void)addFavWithLevel:(NSInteger)level
                   name:(NSString *)name
                    dir:(NSInteger)dir
           successBlock:(ASSuccessCallback)success
           failureBlock:(ASSuccessCallback)failure {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[@(level) stringValue], @"level",
                                                                                            name, @"name",
                                                                            [@(dir) stringValue], @"dir", nil];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/add/%ld", BYR_FAVORITE_URL, level] method:HTTP_POST parameters:parameters success:success failure:failure];
}

- (void)deleteFavWithLevel:(NSInteger)level
                      name:(NSString *)name
                       dir:(NSInteger)dir
              successBlock:(ASSuccessCallback)success
              failureBlock:(ASSuccessCallback)failure {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[@(level) stringValue], @"level",
                                                                                            name, @"name",
                                                                            [@(dir) stringValue], @"dir", nil];
    [self sendRequestWithUrl:[NSString stringWithFormat:@"%@/delete/%ld", BYR_FAVORITE_URL, level] method:HTTP_POST parameters:parameters success:success failure:failure];
}

@end
