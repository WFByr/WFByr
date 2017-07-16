//
//  WFPostModule.m
//  WFByr
//
//  Created by Andy on 2017/6/1.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFPostModule.h"
#import "WFRouter.h"
#import "WFPostVC.h"
@implementation WFPostModule

+ (void)load {
    [WFRouter registerRoute:@"post" withVC:[WFPostVC class]];
}

- (__kindof UIViewController*)rootVC {
    return [WFPostVC new];
}

@end
