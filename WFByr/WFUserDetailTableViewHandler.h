//
//  WFUserDetailTableViewHandler.h
//  WFByr
//
//  Created by 李向前 on 2017/8/22.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFManagementUtils.h"

@interface WFUserDetailTableViewHandler : NSObject

- (NSArray *)createTableViewDataSourceWithType:(WFManagementRoleType)roleType;

@end
