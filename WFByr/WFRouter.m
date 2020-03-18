//
//  WFRouter.m
//  WFByr
//
//  Created by Andy on 2017/5/27.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFRouter.h"

static NSMutableDictionary<NSString*, Class> * routingTable;

@implementation WFRouter

+ (void)registerRoute:(NSString *)url withVC:(Class)destVC{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        routingTable = [NSMutableDictionary dictionary];
    });
    
    NSAssert([destVC isSubclassOfClass:[UIViewController class]], @"Destination needs to be a UIViewController!");
    
    routingTable[url] = destVC;
}

+ (void)go:(NSString *)url withParams:(NSDictionary *)params from:(UIViewController *)fromVC{
    Class destClass = routingTable[url];
    WFLogInfo(@"go:%@, %@", url, destClass);
    UIViewController<WFRouterProtocol> *destVC = [[destClass alloc] initWithParams:params];
    if (fromVC && fromVC.navigationController) {
        [fromVC.navigationController pushViewController:destVC animated:YES];
    }
    if ([fromVC isKindOfClass:[UINavigationController class]]) {
        [((UINavigationController*)fromVC) pushViewController:destVC animated:YES];
    }
}

@end
