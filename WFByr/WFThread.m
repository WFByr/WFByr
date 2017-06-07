//
//  WFThreads.m
//  WFByr
//
//  Created by Andy on 2017/6/7.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFThread.h"

@implementation WFThread

+ (NSDictionary *)objectClassInArray{
    return @{@"like_articles" : [WFArticle class]};
}

@end
