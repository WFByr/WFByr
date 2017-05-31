//
//  XQByrUser.m
//  Pods
//
//  Created by lxq on 1/4/17.
//
//

#import "WFUser.h"

@implementation WFUser

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"uid" : @"id"};
}

- (instancetype)initWithUid:(NSString *)uid faceUrl:(NSString *)face_url userName:(NSString *)user_name{
    if (self = [super init]) {
        _uid = [uid copy];
        _face_url = [face_url copy];
        _user_name = [user_name copy];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    WFUser * user = [[WFUser alloc] initWithUid:self.uid faceUrl:self.face_url userName:self.user_name];
    return user;
}
@end
