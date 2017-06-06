//
//  WFCollection.h
//  WFByr
//
//  Created by lixiangqian on 17/6/3.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WFUser;

@interface WFCollection : NSObject<NSCopying>

@property (nonatomic, strong) WFUser *user;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString* createdTime;

@property (nonatomic, copy) NSString* postTime;

@property (nonatomic, copy) NSString* num;

@property (nonatomic, copy) NSString* gid;

@property (nonatomic, copy) NSString *bname;

//为和数据库同步增加的字段
@property (nonatomic, copy) NSString * firstImageUrl;

@property (nonatomic, assign) NSInteger replyCount;

///1为正常，2为待收藏，3为待删除
@property (nonatomic, assign) NSInteger state;

@end
