//
//  Lexer.m
//  playground
//
//  Created by Andy on 2017/5/9.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "ASLexer.h"


@implementation ASToken

+ (instancetype)tokenWithString:(NSString *)str {
    return [[[self class] alloc] initWithString:str];
}

- (instancetype)initWithString:(NSString*) str {
    self = [super init];
    if (self != nil) {
        _raw = str;
    }
    return self;
}

@end

@implementation ASTag


@end

@implementation ASOpenTag

- (instancetype)initWithString:(NSString *)str {
    self = [super initWithString:str];
    if (self != nil) {
        if (str.length < 3 || [str characterAtIndex:0] != '[' || [str characterAtIndex:str.length - 1] != ']') return nil;
        NSRange equalRange = [str rangeOfString:@"="];
        
        if (equalRange.length != 0) {
            self.tag = [str substringWithRange:NSMakeRange(1, equalRange.location - 1)];
            self.val = [str substringWithRange:NSMakeRange(equalRange.location + 1, str.length - 3 - self.tag.length)];
        } else {
            self.tag = [str substringWithRange:NSMakeRange(1, str.length - 2)];
        }
    }
    return self;
}

- (BOOL)match:(ASCloseTag *)aCloseTag {
    return [self.tag isEqualToString:aCloseTag.tag];
}

@end

@implementation ASCloseTag

- (instancetype)initWithString:(NSString *)str {
    self = [super initWithString:str];
    if (self != nil) {
        if (str.length < 4
            || [str  characterAtIndex:0] != '['
            || [str characterAtIndex:1] != '/'
            || [str characterAtIndex:str.length - 1] != ']') {
            return nil;
        }
        self.tag = [str substringWithRange:NSMakeRange(2, str.length - 3)];
    }
    return self;
}

@end

ASToken* getToken(NSString *str, NSRangePointer rangePointer) {
    if (rangePointer->length == 0) return nil;
    static NSRegularExpression *closeTagRegx, *openTagRegx, *valueTagRegx;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        closeTagRegx = [NSRegularExpression regularExpressionWithPattern:@"^(\\[/\\w*\\])" options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators error:nil];
        openTagRegx = [NSRegularExpression regularExpressionWithPattern:@"^(\\[.*?\\])" options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators error:nil];
        valueTagRegx = [NSRegularExpression regularExpressionWithPattern:@"^((?!(\\[.*?\\])).)+" options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators error:nil];
    });
    
    NSTextCheckingResult *res = [closeTagRegx firstMatchInString:str options:kNilOptions range:*rangePointer];
    if (res) {
        rangePointer->location += res.range.length;
        rangePointer->length -= res.range.length;
        return [ASCloseTag tokenWithString:[str substringWithRange:res.range]];
    }
    
    res = [openTagRegx firstMatchInString:str options:kNilOptions range:*rangePointer];
    if (res) {
        rangePointer->location += res.range.length;
        rangePointer->length -= res.range.length;
        return [ASOpenTag tokenWithString:[str substringWithRange:res.range]];
    }
    
    res = [valueTagRegx firstMatchInString:str options:kNilOptions range:*rangePointer];
    if (res) {
        rangePointer->location += res.range.length;
        rangePointer->length -= res.range.length;
        return [ASToken tokenWithString:[str substringWithRange:res.range]];
    }
    
    return nil;
}

@implementation ASLexer

+ (NSArray<ASToken*>*)scanSource:(NSString*)source {
    NSMutableArray<ASToken*> *tokenArr = [NSMutableArray array];
    NSRange range = NSMakeRange(0, source.length);
    ASToken *token;
    while ((token = getToken(source, &range))) {
        [tokenArr addObject:token];
    }
    
    return [tokenArr copy];
}
@end
