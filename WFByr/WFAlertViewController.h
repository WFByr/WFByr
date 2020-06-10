//
//  WFAlertViewController.h
//  WFByr
//
//  Created by 李向前 on 2020/5/19.
//  Copyright © 2020 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WFAlertAction;

@interface WFAlertBaseViewController : UIViewController

- (void)wf_show;

@end

@interface WFAlertViewController : WFAlertBaseViewController

+ (instancetype)alertViewControllerWithTitle:(nullable NSString *)title message:(nullable NSAttributedString *)message;

- (void)addAction:(WFAlertAction *)action;

@end

NS_ASSUME_NONNULL_END
