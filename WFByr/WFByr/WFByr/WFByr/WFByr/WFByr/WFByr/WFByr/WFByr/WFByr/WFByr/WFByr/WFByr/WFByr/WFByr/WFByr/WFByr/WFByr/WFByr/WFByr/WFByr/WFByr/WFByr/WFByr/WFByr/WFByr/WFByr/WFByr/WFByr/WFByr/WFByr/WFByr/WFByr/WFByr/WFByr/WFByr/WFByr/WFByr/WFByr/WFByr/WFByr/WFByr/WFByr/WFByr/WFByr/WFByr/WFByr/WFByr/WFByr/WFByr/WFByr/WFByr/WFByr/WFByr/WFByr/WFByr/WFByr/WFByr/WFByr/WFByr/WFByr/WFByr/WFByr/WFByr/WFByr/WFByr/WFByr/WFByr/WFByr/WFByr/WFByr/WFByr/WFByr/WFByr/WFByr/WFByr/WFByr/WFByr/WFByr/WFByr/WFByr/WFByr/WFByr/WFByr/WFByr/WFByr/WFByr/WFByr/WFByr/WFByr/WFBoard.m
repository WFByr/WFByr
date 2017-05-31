//
//  XQByrBoard.m
//  Pods
//
//  Created by lxq on 1/4/17.
//
//

#import "WFBoard.h"
#import "WFArticle.h"
@implementation WFBoard
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"clazz" : @"class"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"article" : [WFArticle class]};
}
@end
