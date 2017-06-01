//
//  WFThreadsModule.m
//  WFByr
//
//  Created by Andy on 2017/5/27.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFThreadsModule.h"
#import "WFThreadsVC.h"

@implementation WFThreadsModule

+ (void)load {
    [WFRouter registerRoute:@"threads" withVC:[WFThreadsVC class]];
}

@end
