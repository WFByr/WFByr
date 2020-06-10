//
//  WFByrUIUtils.m
//  WFByr
//
//  Created by 李向前 on 2020/4/18.
//  Copyright © 2020 andy. All rights reserved.
//

#import "WFByrUIUtils.h"

@implementation WFByrUIUtils

+ (UIViewController *)topViewController {
    UIViewController *topVC = [self getTopViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
    
    while (topVC.presentedViewController) {
        return [WFByrUIUtils getTopViewController:topVC.presentedViewController];
    }
    return topVC;
}

+ (UIViewController *)getTopViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return nil;
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        return [WFByrUIUtils getTopViewController:(UINavigationController *)viewController.presentedViewController];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        return [WFByrUIUtils getTopViewController:[(UITabBarController *)viewController selectedViewController]];
    } else {
        return viewController;
    }
}

+ (BOOL)isiPhoneXModel {
    return WFSCREEN_H > 736;
}

+ (BOOL)isiPhoneXBefore {
    return WFSCREEN_H <= 736;
}

@end
