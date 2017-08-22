//
//  WFManagementRow.h
//  WFByr
//
//  Created by 李向前 on 2017/8/18.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFManagementUtils.h"
@interface WFManagementRow : NSObject

@property (nonatomic, assign) WFRowAppearanceType appearanceType;
@property (nonatomic, assign) WFManagementActionType actionType;
@property (nonatomic, assign) WFManagementSettingActionType settingActionType;

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * detail;
@property (nonatomic, assign) CGFloat rowHeight;

@end
