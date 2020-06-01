//
//  WFByrUIUtils.h
//  WFByr
//
//  Created by 李向前 on 2020/4/18.
//  Copyright © 2020 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFByrUIUtils : NSObject

+ (UIViewController *)topViewController;

// iPhone X刘海屏适配，可适配至iPhone XS Max
+ (BOOL)isiPhoneXModel;

@end

NS_ASSUME_NONNULL_END
