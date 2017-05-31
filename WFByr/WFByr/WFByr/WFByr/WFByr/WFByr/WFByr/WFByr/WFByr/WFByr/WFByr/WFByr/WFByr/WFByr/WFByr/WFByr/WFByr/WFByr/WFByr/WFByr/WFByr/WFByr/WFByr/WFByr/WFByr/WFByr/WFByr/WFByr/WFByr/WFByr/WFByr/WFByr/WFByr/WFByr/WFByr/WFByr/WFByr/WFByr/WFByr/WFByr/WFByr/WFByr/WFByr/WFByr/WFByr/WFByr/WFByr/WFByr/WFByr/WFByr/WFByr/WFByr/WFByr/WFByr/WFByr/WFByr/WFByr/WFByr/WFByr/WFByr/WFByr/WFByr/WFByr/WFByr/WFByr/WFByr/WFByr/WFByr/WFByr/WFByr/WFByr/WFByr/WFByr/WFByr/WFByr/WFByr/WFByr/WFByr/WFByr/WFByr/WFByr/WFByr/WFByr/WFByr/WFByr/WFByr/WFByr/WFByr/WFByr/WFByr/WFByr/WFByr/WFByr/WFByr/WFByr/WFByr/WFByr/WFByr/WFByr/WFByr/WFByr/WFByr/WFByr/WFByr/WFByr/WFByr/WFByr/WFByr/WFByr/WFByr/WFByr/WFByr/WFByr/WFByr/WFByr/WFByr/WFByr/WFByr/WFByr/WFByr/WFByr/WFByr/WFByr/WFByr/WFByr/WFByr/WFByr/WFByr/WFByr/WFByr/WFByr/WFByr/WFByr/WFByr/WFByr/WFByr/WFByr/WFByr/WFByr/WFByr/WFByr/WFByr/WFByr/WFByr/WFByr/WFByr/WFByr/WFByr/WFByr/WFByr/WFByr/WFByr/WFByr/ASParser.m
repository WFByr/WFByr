//
//  Parser.m
//  playground
//
//  Created by Andy on 2017/5/9.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "Parser.h"

@implementation ASTNode

+ (instancetype)rootNode {
    return [[ASTNode alloc] initWithType:ASTNodeTypeRoot tag:nil val:nil];
}

- (instancetype)initWithType:(ASTNodeType)type tag:(NSString*)aTag val:(NSString*)aVal {
    self = [super init];
    if (self != nil) {
        _nodeType = type;
        _tag = aTag;
        _val = aVal;
    }
    return self;
}

@end

@implementation ASParser

+ (ASTNode*) parseTokens:(NSArray<ASToken *> *)tokens {
    return [[[ASParser alloc] init] parseTokens:tokens];
}

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _twinTags = [NSSet setWithObjects:@"size", @"color", nil];
        _singleTags = [NSSet setWithObjects:@"em0", @"em1", nil];
    }
    return self;
}

- (ASTNode*)parseTokens:(NSArray<ASToken*>*)tokens {
    ASTNode *root = [ASTNode rootNode];
    NSMutableArray<ASTNode*> *children = [NSMutableArray array];
    NSUInteger index = 0;
    for (; index < tokens.count; ++index) {
        if ([tokens[index] isMemberOfClass:[ASOpenTag class]]) {
             [children addObject:[self parseTagWithTokens:tokens ptr:&index]];
        } else if ([tokens[index] isMemberOfClass:[ASToken class]]) {
            [children addObject:[self _genNodeWithTag:nil val:tokens[index].raw]];
        }
    }
    root.children = [children copy];
    return root;
}

- (ASTNode*)parseTagWithTokens:(NSArray<ASToken*> *)tokens ptr:(NSUInteger*)aPtr {
    ASOpenTag *openTag = (ASOpenTag*)tokens[*aPtr];
    
    ASTNode *root = [self _genNodeWithTag:openTag.tag val:openTag.val];
    root = [self _genNodeWithTag:openTag.tag val:openTag.val];
    if (root.nodeType == ASTNodeTypeSingleTag) return root;
    ++(*aPtr);

    NSMutableArray<ASTNode*> *children = [NSMutableArray array];
    for (; *aPtr < tokens.count; ++(*aPtr)) {
        ASToken *curToken = tokens[*aPtr];
        if ([curToken isMemberOfClass:[ASOpenTag class]]) {
            [children addObject:[self parseTagWithTokens:tokens ptr:aPtr]];
        } else if ([curToken isMemberOfClass:[ASCloseTag class]] &&
                   openTag &&
                   [openTag match:(ASCloseTag*)curToken]) {
            break;
        } else {
            [children addObject:[self _genNodeWithTag:nil val:curToken.raw]];
        }
    }
    root.children = [children copy];
    return root;
}

- (ASTNode*)_genNodeWithTag:(NSString*)aTag val:(NSString*)aVal {
    if (!aTag) {
        return [[ASTNode alloc] initWithType:ASTNodeTypeString tag:nil val:aVal];
    } else if ([_twinTags containsObject:aTag]) {
        return [[ASTNode alloc] initWithType:ASTNodeTypeTwinTag tag:aTag val:aVal];
    } else {
        return [[ASTNode alloc] initWithType:ASTNodeTypeSingleTag tag:aTag val:aVal];
    }
}
@end
