//
//  WFManagementRow+Image.m
//  WFByr
//
//  Created by 李向前 on 2017/8/20.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFManagementRow+Image.h"
#import <objc/runtime.h>

static void * WFMangementRowImageNameKey = &WFMangementRowImageNameKey;

static void * WFMangementRowNewTextKey = &WFMangementRowNewTextKey;

static void * WFMangementRowImageColorKey = &WFMangementRowImageColorKey;

@implementation WFManagementRow (Image)

- (NSString *)imageName{
    return objc_getAssociatedObject(self, WFMangementRowImageNameKey);
}

- (void)setImageName:(NSString *)imageName{
    objc_setAssociatedObject(self, WFMangementRowImageNameKey, imageName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)newTextUrl{
    return objc_getAssociatedObject(self, WFMangementRowNewTextKey);
}

- (void)setNewTextUrl:(NSString *)newTextUrl{
    objc_setAssociatedObject(self, WFMangementRowNewTextKey, newTextUrl, OBJC_ASSOCIATION_COPY);
}

- (UIColor *)imageColor{
    return objc_getAssociatedObject(self, WFMangementRowImageColorKey);
}

- (void)setImageColor:(UIColor *)imageColor{
    objc_setAssociatedObject(self, WFMangementRowImageColorKey, imageColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
