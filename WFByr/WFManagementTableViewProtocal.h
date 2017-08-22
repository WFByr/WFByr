//
//  WFManagementTableViewProtocal.h
//  WFByr
//
//  Created by 李向前 on 2017/8/19.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFManagementTableViewHelperProtocal.h"

@class WFManagementSection, WFManagementRow;

//一般只起dataSource 的作用
@protocol WFManagementTableViewAdapterProtocal

@required

@property (nonatomic, weak) UIViewController<WFManagementTableViewHelperProtocal> * ownerController;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

@end
