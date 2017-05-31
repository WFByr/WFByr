//
//  WFRouter.h
//  WFByr
//
//  Created by Andy on 2017/5/27.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WFRouterProtocol <NSObject>

@required

- (instancetype)initWithParams:(NSDictionary*)params;

@end


@interface WFRouter : NSObject

+ (void)registerRoute:(NSString*) url withVC:(Class<WFRouterProtocol>) destVC;

+ (void)go:(NSString*)url withParams:(NSDictionary*)params from:(UIViewController*) fromVC;

@end
