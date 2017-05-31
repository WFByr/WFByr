//
//  XQByrCollection.m
//  Pods
//
//  Created by lxq on 1/4/17.
//
//

#import "XQByrCollection.h"
#import "XQByrUser.h"
@implementation XQByrCollection

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
    XQByrCollection * collection = [[XQByrCollection alloc]initWithTitle:_title createdTime:_createdTime postTime:_postTime num:_num gid:_gid bname:_bname];
    collection.user = [self.user copy];
    return collection;
}
@end


