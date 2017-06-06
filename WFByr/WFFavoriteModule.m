//
//  WFFavoriteModule.m
//  WFByr
//
//  Created by lixiangqian on 17/6/3.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFFavoriteModule.h"
#import "WFFavoriteVC.h"

@implementation WFFavoriteModule

- (UIViewController*)rootVC {
    UITabBarItem *sectionTab = [[UITabBarItem alloc] initWithTitle:@"收藏" image:[UIImage imageNamed:@"bookmark"] selectedImage:nil];
    WFFavoriteVC *rootVC = [[WFFavoriteVC alloc] init];
    rootVC.tabBarItem = sectionTab;
    return rootVC;
}
@end
