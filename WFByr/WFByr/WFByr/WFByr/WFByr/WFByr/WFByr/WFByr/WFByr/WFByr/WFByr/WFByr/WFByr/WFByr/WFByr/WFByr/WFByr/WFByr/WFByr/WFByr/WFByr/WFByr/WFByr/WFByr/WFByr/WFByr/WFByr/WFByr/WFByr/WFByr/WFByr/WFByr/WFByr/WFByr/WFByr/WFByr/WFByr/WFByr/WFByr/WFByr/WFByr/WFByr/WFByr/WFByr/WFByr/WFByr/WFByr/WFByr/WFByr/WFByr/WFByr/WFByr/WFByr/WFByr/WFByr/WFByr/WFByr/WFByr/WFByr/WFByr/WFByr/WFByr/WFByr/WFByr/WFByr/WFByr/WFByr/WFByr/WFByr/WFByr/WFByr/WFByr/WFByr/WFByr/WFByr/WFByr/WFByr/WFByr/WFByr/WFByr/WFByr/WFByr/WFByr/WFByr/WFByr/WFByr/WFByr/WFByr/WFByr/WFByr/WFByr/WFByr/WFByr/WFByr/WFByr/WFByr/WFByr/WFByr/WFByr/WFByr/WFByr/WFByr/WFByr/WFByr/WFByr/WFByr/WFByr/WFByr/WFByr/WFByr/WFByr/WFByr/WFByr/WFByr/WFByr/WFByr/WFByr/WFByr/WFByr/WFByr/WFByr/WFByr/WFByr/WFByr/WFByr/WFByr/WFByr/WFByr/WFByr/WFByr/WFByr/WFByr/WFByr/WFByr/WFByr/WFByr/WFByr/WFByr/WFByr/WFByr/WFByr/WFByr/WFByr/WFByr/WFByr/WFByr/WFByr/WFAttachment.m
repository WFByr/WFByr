//
//  XQByrAttachment.m
//  Pods
//
//  Created by lxq on 1/4/17.
//
//

#import "WFAttachment.h"
#import "WFFile.h"

@implementation WFAttachment

+ (NSDictionary *)objectClassInArray{
    return @{@"file" : [WFFile class]};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"file" : [WFFile class]};
}

@end
