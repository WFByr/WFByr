//
//  WFMeModule.m
//  WFByr
//
//  Created by Andy on 2017/6/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFMeModule.h"
#import "WFMeVC.h"
#import "WFRouter.h"
#import "WFMeModuleProtocol.h"

@interface WFMeModule () <WFMeModule>

@end

@implementation WFMeModule

+ (void)load {
    [WFRouter registerRoute:@"/user" withVC:[WFMeVC class]];
}

- (UIViewController*)rootVC {
    UITabBarItem *meTab = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"me"] selectedImage:nil];
    UIViewController *meVC = [WFMeVC new];
    meVC.tabBarItem = meTab;
    return meVC;
}


@end
