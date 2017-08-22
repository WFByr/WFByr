//
//  WFManagementTableViewAdapter.m
//  WFByr
//
//  Created by 李向前 on 2017/8/18.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFManagementTableViewAdapter.h"
#import "WFManagementTableViewProtocal.h"
#import "WFManagementSection.h"
#import "WFProfileHeaderView.h"
#import "WFProfileGuestHeaderView.h"
#import "WFManagementCell.h"
#import "WFManagementRow.h"
#import "WFManagementRow+Image.h"
#import "WFUser.h"

static NSString * reuseIdentifierD = @"com.BUPT.WFByr,WFManagementCellD";
static NSString * reuseIdentifierST = @"com.BUPT.WFByr,WFManagementCellST";
static NSString * reuseIdentifierSTI = @"com.BUPT.WFByr,WFManagementCellSTI";

@interface WFManagementTableViewAdapter()<WFManagementTableViewAdapterProtocal>

@end

@implementation WFManagementTableViewAdapter

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.ownerController dataSourceArray] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    WFManagementSection * sectionCell = [[self.ownerController dataSourceArray] objectAtIndex:section];
    return [sectionCell.rows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WFManagementSection * section = [[self.ownerController dataSourceArray] objectAtIndex:indexPath.section];
    WFManagementRow * row = [section.rows objectAtIndex:indexPath.row];
    WFManagementCell * cell = nil;
    if (row.appearanceType == WFRowAppearanceTypeDefault) {
        cell = [WFManagementCell reusableCellOfTableView:tableView identifier:reuseIdentifierD];
        cell.accessoryView = nil;
    } else if (row.appearanceType == WFRowAppearanceTypeSingleText) {
        cell = [WFManagementCell reusableCellOfTableView:tableView identifier:reuseIdentifierST];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (row.appearanceType == WFRowAppearanceTypeSingleTextImage) {
        cell = (WFManagementSingleTextImageCell *)[WFManagementSingleTextImageCell reusableCellOfTableView:tableView identifier:reuseIdentifierSTI];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setUpCellWithImage:row.imageName color:row.imageColor textStr:row.newTextUrl];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section > 0) {
        return nil;
    }
    if (self.ownerController.managementRoleType==WFManagementRoleManager || self.ownerController.managementRoleType == WFManagementRoleOther) {
        WFProfileHeaderView * headerView = [[WFProfileHeaderView alloc]initWithFrame:CGRectMake(0, 0, WFSCREEN_W, WFHeightScale * 157)];
        if ([[self.ownerController getUser] isKindOfClass:[WFUser class]]) {
            [headerView setUser:[self.ownerController getUser]];
        }
        return headerView;
    }else{
        WFProfileGuestHeaderView * guestHeaderView = [[WFProfileGuestHeaderView alloc]initWithFrame:CGRectMake(0, 0, WFSCREEN_W, WFHeightScale * 115)];
        return guestHeaderView;
    }
}


@end
