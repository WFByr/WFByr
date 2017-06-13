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
#import "WFFavoriteModuleProtocol.h"
#import "WFMeModuleProtocol.h"


#import "WFPostRootVC.h"



@interface WFAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@end

@implementation WFAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    UIView *containerView = transitionContext.containerView;
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    toView.frame = CGRectMake(0, toView.frame.size.height, toView.frame.size.width, toView.frame.size.height);
    
    //UIVisualEffectView *mask = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    UIView *mask = [[UIView alloc] initWithFrame:fromView.frame];
    mask.backgroundColor = [UIColor blackColor];
    mask.alpha = 0.5;
    
    UIView *snapShot = [[UIApplication sharedApplication].keyWindow snapshotViewAfterScreenUpdates:YES];//[fromView snapshotViewAfterScreenUpdates:YES];
    containerView.backgroundColor = [UIColor redColor];
    [containerView addSubview:snapShot];
    [containerView addSubview:mask];
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:0.5 animations:^{
        snapShot.frame = CGRectMake(10, 20, snapShot.frame.size.width - 20, snapShot.frame.size.height - 40);
        toView.transform = CGAffineTransformMakeTranslation(0, -(toView.frame.size.height - 100));
    } completion:^(BOOL finished) {
       [transitionContext completeTransition:YES];
    }];
    
}

@end

@interface WFTabBarController : UITabBarController <UITabBarControllerDelegate>

@end

@implementation WFTabBarController

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        self.delegate = self;
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([toVC isMemberOfClass:[WFPostRootVC class]]) {
        [UIView animateWithDuration:0.5 animations:^{
            tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, tabBarController.tabBar.frame.size.height);
        }];
        return [WFAnimationController new];
    }
    return nil;
}

@end

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //return YES;

    UITabBarItem *favoriteTab = [[UITabBarItem alloc] initWithTitle:@"收藏" image:[UIImage imageNamed:@"bookmark"] selectedImage:nil];
    
    UITabBarItem *postTab = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"newpost"] selectedImage:nil];
    

    
    WFTabBarController *tabBarVC = [[WFTabBarController alloc] init];
    

  
    id<WFTop10Module> top10Module = [WFModuleFactory moduleWithProtocol:@"WFTop10Module"];
    UIViewController *top10VC = [top10Module rootVC];
    
    id<WFSectionModule> sectionModule = [WFModuleFactory moduleWithProtocol:@"WFSectionModule"];
    
    id<WFFavoriteModule> favoriteModule = [WFModuleFactory moduleWithProtocol:@"WFFavoriteModule"];
    UIViewController *sectionVC = [sectionModule rootVC];
    
    UIViewController *postVC = [WFPostRootVC new];
    postVC.tabBarItem = postTab;
    
    UIViewController *favoriteTabVC = [favoriteModule rootVC];
    favoriteTabVC.tabBarItem = favoriteTab;
    
    id<WFMeModule> meModule = [WFModuleFactory moduleWithProtocol:@"WFMeModule"];
    UIViewController *meVC = [meModule rootVC];
    
    tabBarVC.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:top10VC],
                                 [[UINavigationController alloc] initWithRootViewController:sectionVC],
                                 postVC,
                                 [[UINavigationController alloc] initWithRootViewController:favoriteTabVC],
                                 [[UINavigationController alloc] initWithRootViewController:meVC]];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBarVC;
    self.window.tintColor = MAIN_BLUE;
    
    [self.window makeKeyAndVisible];
    
    if (!wf_checkToken([WFToken shareToken])) {
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
