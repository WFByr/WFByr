//
//  WFFavoriteModuleProtocol.h
//  WFByr
//
//  Created by lixiangqian on 17/6/3.
//  Copyright © 2017年 andy. All rights reserved.
//

#ifndef WFFavoriteProtocol_h
#define WFFavoriteProtocol_h

@class WFArticle;

@protocol WFFavoriteModule <NSObject>

@required
- (UIViewController*) rootVC;

- (void)addFavoriteWithArticle:(WFArticle*)article success:(void (^)(void)) successBlk failure:(void (^)(void)) failureBlk;

@end

#endif
