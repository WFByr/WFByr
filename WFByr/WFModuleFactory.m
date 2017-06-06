//
//  WFModuleFactory.m
//  WFByr
//
//  Created by Andy on 2017/5/25.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFModuleFactory.h"
#import "WFTop10Module.h"
#import "WFLoginModule.h"
#import "WFSectionModule.h"
#import "WFFavoriteModule.h"

@implementation WFModuleFactory

+ (id)moduleWithProtocol:(NSString *)aProtocol {
    if ([aProtocol isEqualToString:@"WFTop10Module"]) {
        return [WFTop10Module new];
    }
    if ([aProtocol isEqualToString:@"WFLoginModule"]) {
        return [WFLoginModule new];
    }
    if ([aProtocol isEqualToString:@"WFSectionModule"]) {
        return [WFSectionModule new];
    }
    if ([aProtocol isEqualToString:@"WFFavoriteModule"]) {
        return [WFFavoriteModule new];
    }
    return nil;
}

@end
