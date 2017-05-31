//
//  ASByrOAth2.m
//  Pods
//
//  Created by andy on 16/4/8.
//
//

#import "ASByrOAth2.h"

#define RESPONSE_TYPE @"token"
#define STATE @"35f7879b051b0bcb77a015977f5aeeeb"
#define URL_TEMPLATE @"http://bbs.byr.cn/oauth2/authorize?response_type=%@&client_id=%@&redirect_uri=%@&state=%@"


@interface ASByrOAth2()

@property (nonatomic, strong) NSRegularExpression *accessTokenReg;

@property (nonatomic, strong) NSRegularExpression *expiresInReg;

@property (nonatomic, strong) NSRegularExpression *refreshTokenReg;

@property (nonatomic, strong) NSRegularExpression *stateReg;

@end



@implementation ASByrOAth2

#warning apple id and bundle id are currently not writed into the oath url

- (instancetype)initWithAppkey:(NSString *)appkey
                   redirectUri:(NSURL *)url
                       appleId:(NSString *)appleId
                      bundleId:(NSString *)bundleId{
    self = [super init];
    if (self) {
        self.oathUrl = [NSURL URLWithString:[NSString stringWithFormat:URL_TEMPLATE, RESPONSE_TYPE, appkey, url, STATE]];
        
        self.accessTokenReg = [NSRegularExpression regularExpressionWithPattern:@"(?<=access_token\\=)[a-zA-Z0-9]+" options:NSRegularExpressionCaseInsensitive error:nil];
        self.expiresInReg = [NSRegularExpression regularExpressionWithPattern:@"(?<=expires_in\\=)[0-9]+" options:NSRegularExpressionCaseInsensitive error:nil];
        self.refreshTokenReg = [NSRegularExpression regularExpressionWithPattern:@"(?<=refresh_token\\=)[a-zA-Z0-9]+" options:NSRegularExpressionCaseInsensitive error:nil];
        self.stateReg = [NSRegularExpression regularExpressionWithPattern:@"(?<=state\\=)[a-zA-Z0-9]+" options:NSRegularExpressionCaseInsensitive error:nil];
    }
    return self;
}

- (BOOL)parseRedirectUri:(NSString *)url {
    
    NSArray *matches = [self.accessTokenReg matchesInString:url options:0 range:NSMakeRange(0, [url length])];
    if (![matches count]) {
        return NO;
    }
    NSString * accessToken = [url substringWithRange:((NSTextCheckingResult*)matches[0]).range];
    
    matches = [self.expiresInReg matchesInString:url options:0 range:NSMakeRange(0, [url length])];
    if (![matches count]) {
        return NO;
    }
    NSInteger expiresIn = [[url substringWithRange:((NSTextCheckingResult*)matches[0]).range] integerValue];
    
    matches = [self.refreshTokenReg matchesInString:url options:0 range:NSMakeRange(0, [url length])];
    if (![matches count]) {
        return NO;
    }
    NSString * refreshToken = [url substringWithRange:((NSTextCheckingResult*)matches[0]).range];
    
    matches = [self.stateReg matchesInString:url options:0 range:NSMakeRange(0, [url length])];
    if (![matches count]) {
        return NO;
    }
    
    [[ASByrToken shareInstance] setupWithAccesssToken:accessToken
                                         refreshToken:refreshToken
                                            expiresIn:expiresIn];
    return YES;
}

- (BOOL)test:(NSString *)url {
    NSLog(@"%@", url);
    return YES;
}
@end
