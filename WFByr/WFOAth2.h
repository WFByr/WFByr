//
//  ASByrOAth2.h
//  Pods
//
//  Created by andy on 16/4/8.
//
//

#import <Foundation/Foundation.h>
#import "WFToken.h"

@interface WFOAth2 : NSObject

@property(nonatomic, strong) NSURL * oathUrl;

- (instancetype)initWithAppkey:(NSString*)appkey
                   redirectUri:(NSURL*)url
                         state:(NSString *)state
                       appleId:(NSString*)appleId
                      bundleId:(NSString*)bundleId;

- (BOOL)parseRedirectUri:(NSString*)url;

- (BOOL)test:(NSString*)url;

@end
