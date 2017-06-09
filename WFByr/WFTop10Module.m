//
//  WFTop10Module.m
//  WFByr
//
//  Created by Andy on 2017/5/25.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFTop10Module.h"
#import "WFTop10ModuleProtocol.h"
#import "WFTop10RootVC.h"
#import <UIKit/UIKit.h>

@interface WFTop10Module () <WFTop10Module>

@end

@implementation WFTop10Module

# pragma mark - WFTop10Module

- (UIViewController*) rootVC {
    UITabBarItem *top10Tab = [[UITabBarItem alloc] initWithTitle:@"十大" image:[UIImage imageNamed:@"home"] selectedImage:nil];
    UIViewController *rootVC = [WFTop10RootVC new];
    rootVC.tabBarItem = top10Tab;
    return rootVC;
}

@end
