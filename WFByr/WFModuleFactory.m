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
#import "WFMeModule.h"

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
    if ([aProtocol isEqualToString:@"WFMeModule"]) {
        return [WFMeModule new];
    }
    return nil;
}

@end
