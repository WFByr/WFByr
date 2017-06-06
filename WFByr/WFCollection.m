//
//  WFCollection.m
//  WFByr
//
//  Created by lixiangqian on 17/6/3.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFCollection.h"
#import "WFUser.h"

@implementation WFCollection

- (instancetype)initWithTitle:(NSString *)title createdTime:(NSString *)createdTime postTime:(NSString *)postTime num:(NSString *)num gid:(NSString *)gid bname:(NSString *)bname{
    if (self = [super init]) {
        _title = [title copy];
        _createdTime = [createdTime copy];
        _postTime = [postTime copy];
        _num = [num copy];
        _gid = [gid copy];
        _bname = [bname copy];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    WFCollection * collection = [[WFCollection alloc]initWithTitle:_title createdTime:_createdTime postTime:_postTime num:_num gid:_gid bname:_bname];
    collection.user = [self.user copy];
    return collection;
}

@end
