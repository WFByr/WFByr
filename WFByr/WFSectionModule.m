//
//  WFSectionModule.m
//  WFByr
//
//  Created by Andy on 2017/6/2.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFSectionModule.h"
#import "WFArticleListVC.h"


@implementation WFSectionModule

- (UIViewController*)rootVC {
   UITabBarItem *sectionTab = [[UITabBarItem alloc] initWithTitle:@"版面" image:[UIImage imageNamed:@"list"] selectedImage:nil];
    WFArticleListVC *rootVC = [[WFArticleListVC alloc] initWithBoardName:@"Travel"];
    rootVC.tabBarItem = sectionTab;
    return rootVC;
}
@end
