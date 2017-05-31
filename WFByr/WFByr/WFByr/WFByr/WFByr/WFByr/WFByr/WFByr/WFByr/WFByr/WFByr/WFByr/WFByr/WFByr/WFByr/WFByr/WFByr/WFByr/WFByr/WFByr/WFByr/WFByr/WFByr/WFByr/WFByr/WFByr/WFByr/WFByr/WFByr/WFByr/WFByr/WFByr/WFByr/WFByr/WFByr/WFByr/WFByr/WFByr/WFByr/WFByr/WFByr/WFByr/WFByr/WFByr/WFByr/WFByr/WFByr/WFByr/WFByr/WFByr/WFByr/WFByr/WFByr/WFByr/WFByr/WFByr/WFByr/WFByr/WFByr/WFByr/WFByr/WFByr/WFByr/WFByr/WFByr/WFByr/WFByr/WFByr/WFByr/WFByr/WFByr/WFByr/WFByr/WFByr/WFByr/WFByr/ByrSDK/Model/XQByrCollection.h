//
//  XQByrCollection.h
//  Pods
//
//  Created by lxq on 1/4/17.
//
//

#import <Foundation/Foundation.h>

@class XQByrUser;
@interface XQByrCollection : NSObject<NSCopying>

@property (nonatomic, strong) XQByrUser *user;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSString* createdTime;

@property (nonatomic, assign) NSString* postTime;

@property (nonatomic, assign) NSString* num;

@property (nonatomic, assign) NSString* gid;

@property (nonatomic, copy) NSString *bname;

//为和数据库同步增加的字段
@property (nonatomic, copy) NSString * firstImageUrl;

@property (nonatomic, assign) NSInteger replyCount;

///1为正常，2为待收藏，3为待删除
@property (nonatomic, assign) NSInteger state;

@end
