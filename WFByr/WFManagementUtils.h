//
//  WFManagementUtils.h
//  WFByr
//
//  Created by 李向前 on 2017/8/18.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  NS_ENUM(NSInteger, WFRowAppearanceType){
    WFRowAppearanceTypeDefault = 0,         //0 左边文字，右边详情(或没有)
    WFRowAppearanceTypeSingleText,          //1 左边文字，右边详情(或没有)，右箭头
    WFRowAppearanceTypeSingleTextImage      //2 左边图片，文字，右边详情，右箭头
};

typedef NS_ENUM(NSInteger, WFManagementRoleType) {
    WFManagementRoleManager = 0,            //0 自己
    WFManagementRoleGuest,                  //1 游客
    WFManagementRoleOther                   //2 浏览其他人
};

typedef NS_ENUM(NSInteger, WFManagementActionType) {
    WFManagementActionTypeNone = 0,         //0 没有反应
    WFManagementActionTypeHighLight,        //1 高亮，没有反应
    WFManagementActionTypeHighLightAlert,   //2 高亮，弹出提示框
    WFManagementActionTypeHighLightPush     //3 高亮，推入下一个
};

typedef NS_ENUM(NSInteger, WFManagementSettingActionType) {
    WFManagementSettingActionNone = 0,          //无反应
    WFManagementSettingActionCollectionSection, //收藏版面
    WFManagementSettingActionEmailReply,        //邮件回复
    WFManagementSettingActionArticleReply,      //文章回复
    WFManagementSettingActionSetting            //设置
};

@interface WFManagementUtils : NSObject

@end
