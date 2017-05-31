//
//  WFLoginModule.m
//  WFByr
//
//  Created by Andy on 2017/5/26.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFLoginModuleProtocol.h"
#import "WFLoginModule.h"
#import "WFLoginVC.h"

@interface WFLoginModule () <WFLoginModule>

@end


@implementation WFLoginModule

- (UIViewController*)rootVC {
    return [WFLoginVC new];
}

@end
