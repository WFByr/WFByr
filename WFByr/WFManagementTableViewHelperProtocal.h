//
//  WFManagementTableViewHelperProtocal.h
//  WFByr
//
//  Created by 李向前 on 2017/8/19.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFManagementUtils.h"

@class WFUser;
@protocol WFManagementTableViewHelperProtocal

@required

- (NSArray *)dataSourceArray;

- (WFManagementRoleType)managementRoleType;

@optional

- (id)getUser;

@end
