//
//  WFMainModule.m
//  WFByr
//
//  Created by Andy on 2017/6/28.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFMainModule.h"
#import "WFModuleFactory.h"
#import "WFToken.h"
#import "WFLoginVC.h"
#import "WFRouter.h"
#import "WFTop10ModuleProtocol.h"
#import "WFLoginModuleProtocol.h"
#import "WFSectionModuleProtocol.h"
#import "WFFavoriteModuleProtocol.h"
#import "WFMeModuleProtocol.h"
#import "WFReachabilityVC.h"

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!wf_checkByrReachable()) {
        [self presentViewController:[[WFReachabilityVC alloc] initWithNibName:@"WFReachabilityVC" bundle:nil] animated:NO completion:nil];
    }
    if (!wf_checkToken([WFToken shareToken])) {
        id<WFLoginModule> loginModule = [WFModuleFactory moduleWithProtocol:@"WFLoginModule"];
        [self presentViewController:[loginModule rootVC] animated:YES completion:nil];
    }
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


@implementation WFMainModule

- (UIViewController*)rootVC {

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
   
    return tabBarVC;
}

@end
