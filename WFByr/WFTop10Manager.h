//
//  ASTop10Manager.h
//  ASByrApp
//
//  Created by andy on 16/4/30.
//  Copyright © 2016年 andy. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "WFTop10Const.h"

@interface WFTop10ManageItem : NSObject

@property(strong, nonatomic) NSString * name;

@property(assign, nonatomic) NSInteger section;

@property(assign, nonatomic) WFTop10Type type;

@property(assign, nonatomic) BOOL isShown;

+ (instancetype)itemWithName:(NSString*)name
                   sectionNo:(NSInteger)section
                        type:(WFTop10Type)type
                     isShown:(BOOL)isShown;

@end



@interface WFTop10Manager : NSObject

@property(assign, nonatomic) NSUInteger shownItemsCount;

@property(assign, nonatomic) NSUInteger hiddenItemsCount;

- (WFTop10ManageItem*)shownObjectAtIndex:(NSUInteger)index;

- (WFTop10ManageItem*)hiddenObjectAtIndex:(NSUInteger)index;

- (void)save;

- (void)moveFromShownAtIndex:(NSUInteger)fromIndex
             toHiddenAtIndex:(NSUInteger)toIndex;

- (void)moveFromShownAtIndex:(NSUInteger)fromIndex
              toShownAtIndex:(NSUInteger)toIndex;

- (void)moveFromHiddenAtIndex:(NSUInteger)fromIndex
               toShownAtIndex:(NSUInteger)toIndex;

- (void)moveFromHiddenAtIndex:(NSUInteger)fromIndex
              toHiddenAtIndex:(NSUInteger)toIndex;

@end
