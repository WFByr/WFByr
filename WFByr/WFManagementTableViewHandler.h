//
//  WFManagementTableViewHandler.h
//  WFByr
//
//  Created by 李向前 on 2017/8/19.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFManagementUtils.h"
/**
 *  我的界面入口 cell样式设置
 **/
@class WFUser, WFManagementRow;

@interface WFManagementTableViewHandler : NSObject

@property (nonatomic, weak) UIViewController * ownerController;

- (NSArray *)createTableViewDataSourceWithType:(WFManagementRoleType)roleType;

- (void)cellSelectWithTableView:(UITableView *)tableView cell:(UITableViewCell *)cell rowItem:(WFManagementRow *)row;

@end
