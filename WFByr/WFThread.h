//
//  WFThreads.h
//  WFByr
//
//  Created by Andy on 2017/6/7.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFArticle.h"

@class WFPagination;
@interface WFThread : WFArticle

@property (nonatomic, assign) BOOL collect;

@property (nonatomic, strong) NSArray<WFArticle*> *like_articles;

@property (nonatomic, strong) WFPagination *pagination;

@end
