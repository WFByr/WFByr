//
//  XQByrFile.m
//  Pods
//
//  Created by lxq on 1/4/17.
//
//

#import "WFFile.h"
#import "WFToken.h"

@implementation WFFile

- (NSString*)thumbnail_small {
    return [NSString stringWithFormat:@"%@?oauth_token=%@", _thumbnail_small, [WFToken shareToken].accessToken];
}

- (NSString*)thumbnail_middle {
    return [NSString stringWithFormat:@"%@?oauth_token=%@", _thumbnail_middle, [WFToken shareToken].accessToken];
}

- (NSString*)url {
    return [NSString stringWithFormat:@"%@?oauth_token=%@", _url, [WFToken shareToken].accessToken];
}

- (NSString *)staticUrl{
    return _url;
}
@end
