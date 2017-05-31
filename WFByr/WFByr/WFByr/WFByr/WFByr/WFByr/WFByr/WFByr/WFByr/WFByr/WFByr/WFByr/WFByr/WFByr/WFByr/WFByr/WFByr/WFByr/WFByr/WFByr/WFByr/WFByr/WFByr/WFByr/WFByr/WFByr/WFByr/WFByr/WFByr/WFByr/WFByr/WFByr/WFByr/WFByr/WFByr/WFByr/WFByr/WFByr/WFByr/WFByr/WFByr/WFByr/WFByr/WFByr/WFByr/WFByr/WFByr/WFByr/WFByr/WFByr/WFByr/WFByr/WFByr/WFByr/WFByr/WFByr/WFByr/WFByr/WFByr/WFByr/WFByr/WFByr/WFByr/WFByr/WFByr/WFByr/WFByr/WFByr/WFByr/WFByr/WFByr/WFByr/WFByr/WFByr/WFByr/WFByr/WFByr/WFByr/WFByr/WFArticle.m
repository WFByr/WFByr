//
//  XQByrArticle.m
//  Pods
//
//  Created by lxq on 1/4/17.
//
//

#import "WFArticle.h"

@implementation WFArticle

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"aid" : @"id"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"article" : [WFArticle class]};
}
@end
