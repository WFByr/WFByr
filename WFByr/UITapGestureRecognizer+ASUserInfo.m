//
//  UITapGestureRecognizer+ASTag.m
//  WFByr
//
//  Created by Andy on 2017/7/27.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "UITapGestureRecognizer+ASUserInfo.h"
#import <objc/runtime.h>

@implementation UITapGestureRecognizer (ASActionUserInfo)

- (void)setUserInfo:(id)userInfo {
    objc_setAssociatedObject(self, @selector(userInfo), userInfo, OBJC_ASSOCIATION_RETAIN);
}

- (id)userInfo {
    return objc_getAssociatedObject(self, @selector(userInfo));
}

@end
