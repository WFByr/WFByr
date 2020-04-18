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
#import "WFByrUIUtils.h"
#import "WFPostVC.h"
#import "WFByrConst.h"

#if DEBUG
#import "ASDebugVC.h"
#endif

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
    UIView *snapShoot = [[UIApplication sharedApplication].keyWindow snapshotViewAfterScreenUpdates:YES];
    
    containerView.backgroundColor = [UIColor blueColor];
    
    [containerView addSubview:toView];
    [transitionContext completeTransition:YES];
    return;
    
    
    [containerView addSubview:snapShoot];
    
    toView.hidden = YES;
    toView.transform = CGAffineTransformMakeScale(0.6, 0.6);
    toView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
            snapShoot.transform = CGAffineTransformMakeScale(0.6, 0.6);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.4 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = - 1.0 / 500.0;
            transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
            snapShoot.layer.transform = transform;
            toView.hidden = NO;
        }];
        
       [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = - 1.0 / 500.0;
            transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
            toView.layer.transform = transform;
        }];
//
//        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:1 animations:^{
//            toView.transform = CGAffineTransformIdentity;
//        }];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
   // fromView.transform = CGAffineTransformMakeScale(0.6, 0.6);
    
    
    
    
    
    
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        snapShoot.frame = CGRectMake(10, 20, snapShoot.frame.size.width - 20, snapShoot.frame.size.height - 40);
//        toView.transform = CGAffineTransformMakeTranslation(0, -(toView.frame.size.height - 100));
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
    
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

#if DEBUG
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        ASDebugVC *debugVC = [ASDebugVC debugVCEmbedInNavigationController];
        UIViewController *targetVC = self;
        if (self.presentedViewController) {
            targetVC = self.presentedViewController;
        }
        [targetVC presentViewController:debugVC animated:YES completion:nil];
    }
}
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(apiRequestFailure:) name:WFByrNetworkFailureNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!wf_checkByrReachable()) {
        [self presentViewController:[[WFReachabilityVC alloc] initWithNibName:@"WFReachabilityVC" bundle:nil] animated:NO completion:nil];
        
    } else if (!wf_checkToken([WFToken shareToken])) {
        id<WFLoginModule> loginModule = [WFModuleFactory moduleWithProtocol:@"WFLoginModule"];
        [self presentViewController:[loginModule rootVC] animated:YES completion:nil];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (toVC == tabBarController.viewControllers[2]) {
        [UIView animateWithDuration:0.5 animations:^{
            tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, tabBarController.tabBar.frame.size.height);
        }];
        //return [WFAnimationController new];
    }
    if (fromVC == tabBarController.viewControllers[2]) {
        [UIView animateWithDuration:0.5 animations:^{
            tabBarController.tabBar.transform = CGAffineTransformIdentity;
        }];
    }
    return nil;
}

#pragma mark -Private Method
- (void)apiRequestFailure:(NSNotification *)notification {
    // access_token没有过期，直接返回
    if (![notification.userInfo[WFByrNetworkFailureCodeKey] isEqualToString:WFByrNetworkAccessTokenFailureCode]) {
        return;
    }
    
    //已经出现了登陆页面了，直接返回
    if ([[WFByrUIUtils topViewController] isKindOfClass:[WFLoginVC class]]) {
        return;
    }
    
    // access_token失效，重新登录
    id<WFLoginModule> loginModule = [WFModuleFactory moduleWithProtocol:@"WFLoginModule"];
    [self presentViewController:[loginModule rootVC] animated:YES completion:nil];
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
    
    UIViewController *postVC = [WFPostVC new];
    postVC.tabBarItem = postTab;
    
    UIViewController *favoriteTabVC = [favoriteModule rootVC];
    favoriteTabVC.tabBarItem = favoriteTab;
    
    id<WFMeModule> meModule = [WFModuleFactory moduleWithProtocol:@"WFMeModule"];
    UIViewController *meVC = [meModule rootVC];
    
    tabBarVC.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:top10VC],
                                 [[UINavigationController alloc] initWithRootViewController:sectionVC],
                                 [[UINavigationController alloc] initWithRootViewController:postVC],
                                 [[UINavigationController alloc] initWithRootViewController:favoriteTabVC],
                                 [[UINavigationController alloc] initWithRootViewController:meVC]];
   
    return tabBarVC;
}

@end
