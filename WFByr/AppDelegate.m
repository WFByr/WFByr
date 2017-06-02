//
//  AppDelegate.m
//  WFByr
//
//  Created by Andy on 2017/5/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "AppDelegate.h"
#import "WFModuleFactory.h"
#import "WFToken.h"
#import "WFLoginVC.h"
#import "WFRouter.h"
#import "WFTop10ModuleProtocol.h"
#import "WFLoginModuleProtocol.h"
#import "WFSectionModuleProtocol.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //return YES;

    UITabBarItem *favoriteTab = [[UITabBarItem alloc] initWithTitle:@"收藏" image:[UIImage imageNamed:@"bookmark"] selectedImage:nil];
    
    UITabBarItem *postTab = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"newpost"] selectedImage:nil];
    

    UITabBarItem *meTab = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"me"] selectedImage:nil];
    
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    
  
    id<WFTop10Module> top10Module = [WFModuleFactory moduleWithProtocol:@"WFTop10Module"];
    UIViewController *top10VC = [top10Module rootVC];
    
    id<WFSectionModule> sectionModule = [WFModuleFactory moduleWithProtocol:@"WFSectionModule"];
    UIViewController *sectionVC = [sectionModule rootVC];
    
    UIViewController *postVC = [UIViewController new];
    postVC.tabBarItem = postTab;
    
    UIViewController *favoriteTabVC = [UIViewController new];
    favoriteTabVC.tabBarItem = favoriteTab;
    
    UIViewController *meVC = [UIViewController new];
    meVC.tabBarItem = meTab;
    
    tabBarVC.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:top10VC],
                                 [[UINavigationController alloc] initWithRootViewController:sectionVC],
                                 postVC,
                                 [[UINavigationController alloc] initWithRootViewController:favoriteTabVC],
                                 [[UINavigationController alloc] initWithRootViewController:meVC]];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBarVC;
    
    
    [self.window makeKeyAndVisible];
    
    if (![WFHelpers checkAccessToken:[WFToken shareToken]]) {
        id<WFLoginModule> loginModule = [WFModuleFactory moduleWithProtocol:@"WFLoginModule"];
        [self.window.rootViewController presentViewController:[loginModule rootVC] animated:YES completion:nil];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
