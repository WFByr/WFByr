//
//  XQByrFile.m
//  Pods
//
//  Created by lxq on 1/4/17.
//
//

#import "XQByrFile.h"
#import "ASByrToken.h"

@implementation XQByrFile

- (NSString*)thumbnail_small {
    return [NSString stringWithFormat:@"%@?oauth_token=%@", _thumbnail_small, [ASByrToken shareInstance].accessToken];
}

- (NSString*)thumbnail_middle {
    return [NSString stringWithFormat:@"%@?oauth_token=%@", _thumbnail_middle, [ASByrToken shareInstance].accessToken];
}

- (NSString*)url {
    return [NSString stringWithFormat:@"%@?oauth_token=%@", _url, [ASByrToken shareInstance].accessToken];
}

- (NSString *)staticUrl{
    return _url;
}
@end
