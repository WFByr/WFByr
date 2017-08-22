//
//  WFManagementTableViewHandler.m
//  WFByr
//
//  Created by 李向前 on 2017/8/19.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFManagementTableViewHandler.h"
#import "WFManagementSection.h"
#import "WFManagementRow.h"
#import "WFManagementRow+Image.h"
#import "WFManagementCell.h"

@implementation WFManagementTableViewHandler

static inline void addToDataSourceIfAllowed(id obj, NSMutableArray * array, BOOL allow){
    if (allow) {
        [array addObject:obj];
    }
}

- (NSArray *)createTableViewDataSourceWithType:(WFManagementRoleType)roleType{
    NSMutableArray * arrData = [NSMutableArray new];
    WFManagementSection * section0 = [self createTopSectionWithRoleType:roleType];
    addToDataSourceIfAllowed(section0, arrData, [section0.rows count]>0);
    
    WFManagementSection * section1 = [self createBottomSectionWithRoleType:roleType];
    addToDataSourceIfAllowed(section1, arrData, [section1.rows count]>0);
    
    return arrData;
}

- (void)cellSelectWithTableView:(UITableView *)tableView cell:(WFManagementCell *)cell rowItem:(WFManagementRow *)row{
    if (row.actionType == WFManagementActionTypeHighLightPush) {
        [self.ownerController setEditing:NO];
    }
    
    switch (row.settingActionType) {
        case WFManagementSettingActionNone:
            break;
        case WFManagementSettingActionSetting:
            [self pushManagementSettingController];
            break;
        case WFManagementSettingActionCollectionSection:
            [self pushCollectionSectionController];
            break;
        case WFManagementSettingActionEmailReply:
            [self pushEmailReplyController];
            break;
        case WFManagementSettingActionArticleReply:
            [self pushArticleReplyController];
            break;
        default:
            break;
    }
}

#pragma mark -- private methods

- (WFManagementSection *)createTopSectionWithRoleType:(WFManagementRoleType)roleType{
    WFManagementSection * section = [[WFManagementSection alloc]init];
    if (roleType == WFManagementRoleManager) {
        WFManagementRow * collectSectionRow = [[WFManagementRow alloc]init];
        collectSectionRow.newTextUrl = @"收藏版面";
        collectSectionRow.imageName = @"collectionSection";
        collectSectionRow.imageColor = MAIN_BLUE;
        collectSectionRow.appearanceType = WFRowAppearanceTypeSingleTextImage;
        collectSectionRow.actionType =  WFManagementActionTypeHighLightPush;
        
        WFManagementRow * emailSectionRow = [[WFManagementRow alloc]init];
        emailSectionRow.newTextUrl = @"站内信";
        emailSectionRow.imageName = @"emailReply";
        emailSectionRow.imageColor = MAIN_BLUE;
        emailSectionRow.appearanceType = WFRowAppearanceTypeSingleTextImage;
        emailSectionRow.actionType = WFManagementActionTypeHighLightPush;
        
        WFManagementRow * replySectionRow = [[WFManagementRow alloc]init];
        replySectionRow.newTextUrl = @"回复文章";
        replySectionRow.imageColor = MAIN_BLUE;
        replySectionRow.imageName = @"articleReply";
        replySectionRow.appearanceType = WFRowAppearanceTypeSingleTextImage;
        replySectionRow.actionType = WFManagementActionTypeHighLightPush;
        
        addToDataSourceIfAllowed(collectSectionRow, section.rows, YES);
        addToDataSourceIfAllowed(emailSectionRow, section.rows, YES);
        addToDataSourceIfAllowed(replySectionRow, section.rows, YES);
    }
    return section;
}

- (WFManagementSection *)createBottomSectionWithRoleType:(WFManagementRoleType)roleType{
    WFManagementSection * section = [[WFManagementSection alloc]init];
    WFManagementRow * settingEnterRow = [[WFManagementRow alloc]init];
    settingEnterRow.appearanceType = WFRowAppearanceTypeSingleTextImage;
    settingEnterRow.actionType = WFManagementActionTypeHighLightPush;
    settingEnterRow.imageName = @"setting";
    settingEnterRow.imageColor = MAIN_BLUE;
    settingEnterRow.newTextUrl = @"设置";
    addToDataSourceIfAllowed(settingEnterRow, section.rows, YES);
    return section;
}

- (void)pushManagementSettingController{
    
}

- (void)pushCollectionSectionController{
    
}

- (void)pushEmailReplyController{
    
}

- (void)pushArticleReplyController{
    
}
@end
