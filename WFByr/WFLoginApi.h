//
//  WFLoginApi.h
//  WFByr
//
//  Created by Andy on 2017/8/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFLoginApi : NSObject

- (void)loginWithUserName:(NSString*)name password:(NSString*)pwd success:(void(^)())successBlk fail:(void(^)())failBlk;

@end
