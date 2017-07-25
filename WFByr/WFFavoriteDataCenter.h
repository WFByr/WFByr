//
//  WFFavoriteDataCenter.h
//  WFByr
//
//  Created by lixiangqian on 17/6/3.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WFCollection, WFCollectionApi;

@interface WFFavoriteDataCenter : NSObject

@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSNumber* maxPage;

@property (strong, nonatomic) WFCollectionApi * collectionApi;

@property (strong, nonatomic) NSMutableArray<WFCollection*> * collectionList;

- (void)deleteCollection:(NSString*)gid successBlk:(void(^)(NSInteger statusCode, id reponse))successBlk failureBlk:(void(^)(NSInteger statusCode, id reponse))failureBlk;

@end
