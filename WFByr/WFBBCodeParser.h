//
//  WFBBCodeParser.h
//  WFByr
//
//  Created by Andy on 2017/5/31.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WFBBCodeParserDelegate <NSObject>

@optional

- (BOOL)customizeTag:(NSString*) tagName;

- (NSAttributedString*)renderTag:(NSString*) tagName withValue:(NSString*)val;

@end


@interface WFBBCodeParser : NSObject

@property (nonatomic, weak) id<WFBBCodeParserDelegate> delegate;

- (NSAttributedString*)parseBBCode:(NSString*) aBBCode;

- (void)parseBBCode:(NSString*)aBBCode finish:(void(^)(NSAttributedString *attrString))finishBlock;

@end
