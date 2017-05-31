//
//  WFHelpers.h
//  WFByr
//
//  Created by Andy on 2017/5/25.
//  Copyright © 2017年 andy. All rights reserved.
//

#ifndef WFHelpers_h
#define WFHelpers_h

#import <Foundation/Foundation.h>

@class WFToken;

@interface WFHelpers : NSObject

+ (BOOL)checkAccessToken:(WFToken*) aToken;

+ (NSString*)formatDateWithNow:(NSDate*) now past:(NSDate*)past;

+ (NSURL*)saveImage:(UIImage*)image withName:(NSString*) name;

@end


#endif /* WFHelpers_h */
