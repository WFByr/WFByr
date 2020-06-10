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
    WFArticleListVC *rootVC = [[WFArticleListVC alloc] initWithBoardName:[self defaultBoardName] boardTitle:[self defaultBoardTitle]];
    rootVC.tabBarItem = sectionTab;
    return rootVC;
}

// 初次默认选中的版面名称
- (NSString *)defaultBoardName {
    NSString *lastSelectedBoardName = [[NSUserDefaults standardUserDefaults] stringForKey:WFByrDefaultShowBoardNameKey];
    if (lastSelectedBoardName.length == 0) {
        lastSelectedBoardName = @"BUPT";
    }
    return lastSelectedBoardName;
}

// 初次默认选中的版面标题
- (NSString *)defaultBoardTitle {
    NSString *lastSelectedBoardTitle = [[NSUserDefaults standardUserDefaults] stringForKey:WFByrDefaultShowBoardTitleKey];
    if (lastSelectedBoardTitle.length == 0) {
        lastSelectedBoardTitle = @"北邮生活";
    }
    return lastSelectedBoardTitle;
}

@end
