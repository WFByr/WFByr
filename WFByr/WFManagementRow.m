//
//  WFManagementRow.m
//  WFByr
//
//  Created by 李向前 on 2017/8/18.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFManagementRow.h"

@implementation WFManagementRow

- (instancetype)init{
    if (self = [super init]) {
        _actionType = WFManagementActionTypeNone;
        _appearanceType = WFRowAppearanceTypeDefault;
        _settingActionType = WFManagementSettingActionNone;
        
        _rowHeight = 44;
    }
    return self;
}
@end
