//
//  AppDelegate.m
//  WFByr
//
//  Created by Andy on 2017/5/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "AppDelegate.h"
#import "WFModuleFactory.h"
#import "WFMainModuleProtocol.h"
#import "WFConst.h"
#import "WFByrUIUtils.h"
#import "WFAlertView.h"
#import "WFAlertViewController.h"

// 用户是否已经同意了隐私协议
static NSString *const WFByrUserAgreedPrivacyArchiveKey = @"WFByrUserAgreedPrivacy";
@interface AppDelegate ()<BuglyDelegate>
@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupBugly];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    id<WFMainModule> mainModule = [WFModuleFactory moduleWithProtocol:@"WFMainModule"];
    UIViewController *rootVC = [mainModule rootVC];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = rootVC;
    self.window.tintColor = MAIN_BLUE;
    [self.window makeKeyAndVisible];
    
    [self showPrivacyAlertOnVCIfNeed:rootVC];

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


#pragma mark

// 隐私协议弹框
- (void)showPrivacyAlertOnVCIfNeed:(UIViewController *)rootVC {
    
    BOOL privacyAgree = [[NSUserDefaults standardUserDefaults] boolForKey:WFByrUserAgreedPrivacyArchiveKey];
//    if (privacyAgree) {
//        return;
//    }
    
    NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:@"感谢您选择远邮APP！我们非常重视您的个人信息和隐私保护。为了更好地保障您的个人权益，在您使用我们的产品掐，请务必审慎阅读《隐私政策》内的所有条款。如您对以上协议有任何疑问，可发邮件至jessicaleech7@gmail.com进行反馈。您点击\"同意并继续\"的行为即表示您已阅读完毕并同意以上协议的全部内容。"];
    NSRange highlightRange = [[alertMessageStr string] rangeOfString:@"《隐私政策》"];
    [alertMessageStr addAttribute:NSLinkAttributeName value:@"https://xiangqian.space/privacy" range:highlightRange];
    [alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:highlightRange];
    
    WFAlertViewController *alertController = [WFAlertViewController alertViewControllerWithTitle:@"用户隐私协议政策" message:alertMessageStr];
    
    
    WFAlertAction *agreeAction = [WFAlertAction actionWithTitle:@"同意并继续" style:WFAlertActionStyleDestructive handler:^(WFAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:WFByrUserAgreedPrivacyArchiveKey];
        [alertController dismissViewControllerAnimated:NO completion:nil];
    }];
    
    WFAlertAction *disagreeAction = [WFAlertAction actionWithTitle:@"不同意" style:WFAlertActionStyleCancel handler:^(WFAlertAction * _Nonnull action) {
        exit(0);
    }];
    
    [alertController addAction:agreeAction];
    [alertController addAction:disagreeAction];
    [rootVC presentViewController:alertController animated:NO completion:nil];
}


- (void)setupBugly {
    BuglyConfig *config = [[BuglyConfig alloc] init];
    
#if DEBUG
    config.debugMode = YES;
    config.consolelogEnable = YES;
    config.viewControllerTrackingEnable = NO;
    config.reportLogLevel = BuglyLogLevelVerbose;
#else
    config.debugMode = NO;
    config.consolelogEnable = NO;
    config.viewControllerTrackingEnable = YES;
    config.reportLogLevel = BuglyLogLevelWarn;
#endif
    
    // 卡顿监测开关 默认关闭
    config.blockMonitorEnable = YES;
        
    config.blockMonitorTimeout = 1.5;
        
    config.channel = @"iOSWFByr";
        
    config.delegate = self;
    
    [Bugly startWithAppId:WFByrBuglyAPPID
    #ifdef DEBUG
            developmentDevice:YES
    #endif
                       config:config];
        
    [Bugly setUserIdentifier:[UIDevice currentDevice].identifierForVendor.UUIDString?:@""];
        
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
}

#pragma mark - BuglyDelegate
- (NSString *)attachmentForException:(NSException *)exception {
    NSString *attachment = [NSString stringWithFormat:@"(%@:%d) %s %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, exception];
    WFLogInfo(@"attachmentforexception %@", attachment);
    return attachment;
}


@end
