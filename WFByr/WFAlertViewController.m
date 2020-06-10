//
//  WFAlertViewController.m
//  WFByr
//
//  Created by 李向前 on 2020/5/19.
//  Copyright © 2020 andy. All rights reserved.
//

#import "WFAlertViewController.h"
#import "WFAlertView.h"
#import "WFByrUIUtils.h"

static const CGFloat WFAlertControllerAnimatedTransitioningDuration = 0.3;
@interface WFAlertControllerAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isDismiss;

@end

@implementation WFAlertControllerAnimatedTransitioning

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    if ([transitionContext isInteractive]) {
        return;
    }
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *container = [transitionContext containerView];
    if (self.isDismiss) {
        toView.alpha = 1;
        toView.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:WFAlertControllerAnimatedTransitioningDuration delay:0 usingSpringWithDamping:600 initialSpringVelocity:0 options:(UIViewAnimationOptionAutoreverse | UIViewAnimationOptionBeginFromCurrentState) animations:^{
            toView.alpha = 0;
        } completion:^(BOOL finished) {
            [toView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    } else {
        container.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        toView.alpha = 1;
        toView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        [container addSubview:toView];
        [UIView animateWithDuration:0.41 delay:0 usingSpringWithDamping:600 initialSpringVelocity:0 options:(UIViewAnimationOptionAutoreverse | UIViewAnimationOptionBeginFromCurrentState) animations:^{
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return WFAlertControllerAnimatedTransitioningDuration;
}

@end

@interface WFAlertControllerTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>

@end

@implementation WFAlertControllerTransitionDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    WFAlertControllerAnimatedTransitioning *transition = [[WFAlertControllerAnimatedTransitioning alloc] init];
    transition.isDismiss = YES;
    return transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    WFAlertControllerAnimatedTransitioning *transition = [[WFAlertControllerAnimatedTransitioning alloc] init];
    transition.isDismiss = NO;
    return transition;
}

@end

@interface WFAlertPresentingViewController : UIViewController

@end

@implementation WFAlertPresentingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
}

@end

@interface WFAlertBaseViewController()

@property (nonatomic, strong) UIWindow *presentedWindow;

@property (nonatomic, strong) WFAlertControllerTransitionDelegate *transitionDelegate;

@end

@implementation WFAlertBaseViewController

- (instancetype)init {
    if (self = [super init]) {
        self.transitionDelegate = [[WFAlertControllerTransitionDelegate alloc] init];
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle {
    modalPresentationStyle = UIModalPresentationCustom;
    [super setModalPresentationStyle:modalPresentationStyle];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    __weak WFAlertBaseViewController *weakSelf = self;
    [super dismissViewControllerAnimated:flag completion:^{
        [weakSelf releaseWindow];
        if (completion) {
            completion();
        }
    }];
}

- (void)releaseWindow {
    [self.presentedWindow setHidden:YES];
    self.presentedWindow = nil;
}

- (void)wf_show {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    WFAlertPresentingViewController *vc = [[WFAlertPresentingViewController alloc] init];
    window.rootViewController = vc;
    [window setHidden:NO];
    [vc presentViewController:self animated:YES completion:nil];
}

@end

@interface WFAlertViewController ()

@property (nonatomic, strong) NSMutableArray <WFAlertAction *> *actions;

@end

@implementation WFAlertViewController

- (instancetype)init {
    if (self = [super init]) {
        _actions = [NSMutableArray array];
    }
    return self;
}

- (void)loadView {
    CGSize size = CGSizeMake(270, 220);
    CGRect screen = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake((screen.size.width- size.width)/2, (screen.size.height-size.height)/2, size.width, size.height);
    WFAlertView *view = [[WFAlertView alloc] initWithFrame:frame];
    view.viewController = self;
    self.view = view;
}

+ (instancetype)alertViewControllerWithTitle:(nullable NSString *)title message:(nullable NSAttributedString *)message {
    WFAlertViewController *controller = [[self alloc] init];
    [(WFAlertView *)controller.view configurePropertiesWithTitle:title message:message];
    return controller;
}

- (void)addAction:(WFAlertAction *)action {
    [_actions addObject:action];
    [(WFAlertView *)self.view addHorizontalAction:action];
}



@end
