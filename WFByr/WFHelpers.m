//
//  WFHelpers.m
//  WFByr
//
//  Created by Andy on 2017/5/25.
//  Copyright © 2017年 andy. All rights reserved.
//
#import "WFHelpers.h"
#import "WFModels.h"

@implementation WFHelpers

+ (BOOL)checkAccessToken:(WFToken*) aToken {
    if (!aToken.accessToken) {
        return false;
    }
    return true;
}

+ (NSString*)formatDateWithNow:(NSDate*) now past:(NSDate*)past {
    NSTimeInterval oneMinute = 60;
    NSTimeInterval oneHour = oneMinute * 60;
    NSTimeInterval oneDay  = oneHour * 24;
    
    NSTimeInterval seconds = now.timeIntervalSince1970 - past.timeIntervalSince1970;
    
    if (seconds / oneDay >= 1) return [NSString stringWithFormat:@"%.0f天前", seconds / oneDay];
    else if (seconds / oneHour >= 1) return [NSString stringWithFormat:@"%.0f小时前", seconds / oneHour];
    else if (seconds / oneMinute >= 1) return [NSString stringWithFormat:@"%.0f分钟前", seconds / oneMinute];
    else return @"刚刚";
}

+ (NSURL*)saveImage:(UIImage*)image withName:(NSString*) name {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSURL *fileUrl = [NSURL fileURLWithPath:[dir stringByAppendingPathComponent:name]];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    NSError *err3;
    if (![data writeToURL:fileUrl options:NSDataWritingAtomic error:&err3]) {
        NSLog(@"save error:%@", err3);
        return nil;
    }
    
    return fileUrl;
}

@end
