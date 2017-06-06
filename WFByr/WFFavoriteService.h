//
//  WFFavoriteService.h
//  WFByr
//
//  Created by Andy on 2017/6/6.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WFArticle;

@interface WFFavoriteService : NSObject

+ (instancetype)sharedService;

- (void)addFavoriteWithAricle:(WFArticle*)article success:(void(^)(void)) successBlk failure:(void (^)(void))failureBlk;

@end
