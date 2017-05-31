//
//  ASTop10Manager.m
//  ASByrApp
//
//  Created by andy on 16/4/30.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFTop10Manager.h"

@implementation WFTop10ManageItem

+ (instancetype)itemWithName:(NSString *)name
                     sectionNo:(NSInteger)section
                        type:(WFTop10Type)type
                     isShown:(BOOL)isShown {
    WFTop10ManageItem *item = [[WFTop10ManageItem alloc] init];
    if (item != nil) {
        item.name    = name;
        item.section = section;
        item.type    = type;
        item.isShown = isShown;
    }
    return item;
}

@end



@interface WFTop10Manager()

@property(strong, nonatomic) NSMutableArray * shownArr;

@property(strong, nonatomic) NSMutableArray * hiddenArr;

@end

static NSString * const showArrKey   = @"shownArr";

static NSString * const hiddenArrKey = @"hiddenArr";

static NSString * const fileName = @"top10Iterms.plist";

static NSString * const kNameKey = @"name";

static NSString * const kIdKey = @"sectionNo";

static NSString * const kTypeKey = @"type";


@implementation WFTop10Manager

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path =  [pathArr objectAtIndex:0];
        NSString *filePath=[path stringByAppendingPathComponent:fileName];
        
        NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        self.shownArr = [tmp objectForKey:showArrKey];
        if (self.shownArr == nil) {
            self.shownArr = [NSMutableArray arrayWithArray:@[
                                                             @{kNameKey: @"十大",
                                                               kIdKey  : @(0),
                                                               kTypeKey: @(ASTop10)},
                                                             @{kNameKey: @"本站",
                                                               kIdKey  : @(0),
                                                               kTypeKey: @(ASSectionTop)},
                                                             @{kNameKey: @"北邮",
                                                               kIdKey  : @(1),
                                                               kTypeKey: @(ASSectionTop)},
                                                             @{kNameKey: @"学术",
                                                               kIdKey  : @(2),
                                                               kTypeKey: @(ASSectionTop)},
                                                             @{kNameKey: @"信息",
                                                               kIdKey  : @(3),
                                                               kTypeKey: @(ASSectionTop)},
                                                             @{kNameKey: @"人文",
                                                               kIdKey  : @(4),
                                                               kTypeKey: @(ASSectionTop)},
                                                             @{kNameKey: @"生活",
                                                               kIdKey  : @(5),
                                                               kTypeKey: @(ASSectionTop)},
                                                             @{kNameKey: @"休闲",
                                                               kIdKey  : @(6),
                                                               kTypeKey: @(ASSectionTop)},
                                                             @{kNameKey: @"体育",
                                                               kIdKey  : @(7),
                                                               kTypeKey: @(ASSectionTop)},
                                                             @{kNameKey: @"游戏",
                                                               kIdKey  : @(8),
                                                               kTypeKey: @(ASSectionTop)},
                                                             @{kNameKey: @"乡亲",
                                                               kIdKey  : @(9),
                                                               kTypeKey: @(ASSectionTop)}
                                                             ]];
            tmp[@"top10Items"] = self.shownArr;
            [tmp writeToFile:path atomically:YES];
        }
        
        self.hiddenArr = [tmp objectForKey:hiddenArrKey];
        if (self.hiddenArr == nil) {
            self.hiddenArr = [NSMutableArray array];
        }
    }
    return self;
}

- (WFTop10ManageItem *) shownObjectAtIndex:(NSUInteger)index {
    WFTop10ManageItem * tmp = [[WFTop10ManageItem alloc] init];
    tmp.name = self.shownArr[index][kNameKey];
    tmp.section = [self.shownArr[index][kIdKey] integerValue];
    tmp.type = [self.shownArr[index][kTypeKey] intValue];
    return tmp;
}

- (WFTop10ManageItem *) hiddenObjectAtIndex:(NSUInteger)index {
    WFTop10ManageItem * tmp = [[WFTop10ManageItem alloc] init];
    tmp.name = self.hiddenArr[index][kNameKey];
    tmp.section = [self.hiddenArr[index][kIdKey] integerValue];
    tmp.type = [self.hiddenArr[index][kTypeKey] intValue];
    return tmp;}

- (void)save {
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path =  [pathArr objectAtIndex:0];
    NSString *filePath=[path stringByAppendingPathComponent:fileName];
    
    NSDictionary * tmp = [NSDictionary dictionaryWithObjectsAndKeys:self.shownArr, showArrKey, self.hiddenArr, hiddenArrKey, nil];
    [tmp writeToFile:filePath atomically:YES];
}

- (void)moveFromShownAtIndex:(NSUInteger)fromIndex
             toHiddenAtIndex:(NSUInteger)toIndex {
    NSDictionary * tmp = [self.shownArr objectAtIndex:fromIndex];
    [self.hiddenArr insertObject:tmp atIndex:toIndex];
    [self.shownArr removeObjectAtIndex:fromIndex];
}

- (void)moveFromShownAtIndex:(NSUInteger)fromIndex
              toShownAtIndex:(NSUInteger)toIndex {
    NSDictionary * tmp = [self.shownArr objectAtIndex:fromIndex];
    if (fromIndex < toIndex) {
        [self.shownArr insertObject:tmp atIndex:++toIndex];
        [self.shownArr removeObjectAtIndex:fromIndex];
    }
    if (fromIndex > toIndex) {
        [self.shownArr insertObject:tmp atIndex:toIndex];
        [self.shownArr removeObjectAtIndex:++fromIndex];
    }
}

- (void)moveFromHiddenAtIndex:(NSUInteger)fromIndex
               toShownAtIndex:(NSUInteger)toIndex {
    NSDictionary * tmp = [self.hiddenArr objectAtIndex:fromIndex];
    [self.shownArr insertObject:tmp atIndex:toIndex];
    [self.hiddenArr removeObjectAtIndex:fromIndex];
}

- (void)moveFromHiddenAtIndex:(NSUInteger)fromIndex
              toHiddenAtIndex:(NSUInteger)toIndex {
    NSDictionary * tmp = [self.hiddenArr objectAtIndex:fromIndex];
    if (fromIndex < toIndex) {
        [self.hiddenArr insertObject:tmp atIndex:++toIndex];
        [self.hiddenArr removeObjectAtIndex:fromIndex];
    }
    if (fromIndex > toIndex) {
        [self.hiddenArr insertObject:tmp atIndex:toIndex];
        [self.hiddenArr removeObjectAtIndex:++fromIndex];
    }
}

#pragma mark - getter and setter

- (NSUInteger)shownItemsCount {
    return [self.shownArr count];
}

- (NSUInteger)hiddenItemsCount {
    return [self.hiddenArr count];
}

@end
