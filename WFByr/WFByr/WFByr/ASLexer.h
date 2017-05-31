//
//  Lexer.h
//  playground
//
//  Created by Andy on 2017/5/9.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TagType) {
    TagTypeSize,
    TagTypeColor,
};

@interface ASToken : NSObject

@property (nonatomic, copy) NSString *raw;

@property (nonatomic, copy) NSString *stringValue;

+ (instancetype)tokenWithString:(NSString*) str;

- (instancetype)initWithString:(NSString*) str;

@end

@interface ASTag : ASToken

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *val;

@end

@interface ASCloseTag : ASTag

@end

@interface ASOpenTag : ASTag

- (BOOL)match:(ASCloseTag*) aCloseTag;

@end

@interface ASLexer : NSObject

+ (NSArray<Token*>*)scanSource:(NSString*)source;

@end
