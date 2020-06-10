//
//  WFAlertView.h
//  WFByr
//
//  Created by 李向前 on 2020/5/19.
//  Copyright © 2020 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WFAlertActionStyle) {
    WFAlertActionStyleDefault,        //蓝色 正常 字体
    WFAlertActionStyleCancel,         //蓝色 正常 字体
    WFAlertActionStyleDestructive     //蓝色 加粗 字体
};

@class WFAlertViewController;
@interface WFAlertAction : NSObject<NSCopying>

+ (instancetype)actionWithTitle:(NSString *)title style:(WFAlertActionStyle)style handler:(void (^)(WFAlertAction *action))handler;

@property (nonatomic, copy, readonly) NSString * title;

@property (nonatomic, assign, readonly) WFAlertActionStyle style;

@end

@interface WFAlertView : UIView

@property (nonatomic, assign) BOOL backgoundTapDismissEnable;  //点击空白处是否消失 默认NO

@property (nonatomic, weak) WFAlertViewController *viewController;


+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSAttributedString *)message;

//添加可以自定义内容的对齐方式
+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSAttributedString *)message contentTextAligment:(NSTextAlignment)contentTextAligment;

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSAttributedString *)message backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable;

- (void)configurePropertiesWithTitle:(NSString *)title message:(NSAttributedString *)message;

- (void)addHorizontalAction:(WFAlertAction *)action;

@end

NS_ASSUME_NONNULL_END
