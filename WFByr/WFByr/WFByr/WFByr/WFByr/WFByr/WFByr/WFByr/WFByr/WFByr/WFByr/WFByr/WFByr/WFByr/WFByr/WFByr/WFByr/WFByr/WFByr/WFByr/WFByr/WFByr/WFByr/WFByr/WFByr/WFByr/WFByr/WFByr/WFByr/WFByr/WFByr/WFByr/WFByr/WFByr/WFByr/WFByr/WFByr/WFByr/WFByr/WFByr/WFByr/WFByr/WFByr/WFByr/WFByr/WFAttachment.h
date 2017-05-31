//
//  XQByrAttachment.h
//  Pods
//
//  Created by lxq on 1/4/17.
//
//

#import <Foundation/Foundation.h>

@class WFFile;
@interface WFAttachment : NSObject

@property (nonatomic, assign) NSInteger remain_count;

@property (nonatomic, strong) NSArray<WFFile *> *file;

@property (nonatomic, copy) NSString *remain_space;

@end
