//
//  Translator.m
//  playground
//
//  Created by Andy on 2017/5/11.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "ASTranslater.h"

void travelASTTree(ASTNode* root, NSArray<ASAttribute*> *attrs, id<ASTranslaterProtocol>translater) {
    if (root.children == nil || root.children.count == 0) { // leaf
        if (!root.tag) { // string leaf
            if ([translater respondsToSelector:@selector(translateString:withAttrs:)]) {
                [translater translateString:root.val withAttrs:attrs];
            }
        } else { // tag leaf
            if ([translater respondsToSelector:@selector(translateTagWithName:value:attrs:)]) {
                [translater translateTagWithName:root.tag value:root.val attrs:attrs];
            }
        }
    } else {
        NSMutableArray<ASAttribute*> *tmpAttrs = [attrs mutableCopy];
        if (root.nodeType != ASTNodeTypeRoot) {
            [tmpAttrs addObject:[ASAttribute attributeWithName:root.tag value:root.val]];
        }
        for (ASTNode *child in root.children) travelASTTree(child, [tmpAttrs copy], translater);
    }
}

@implementation ASAttribute

+ (instancetype)attributeWithName:(NSString *)name value:(NSString *)value {
    ASAttribute *attr = [ASAttribute new];
    attr.name = name;
    attr.value = value;
    return attr;
}

@end

@implementation ASTranslater

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _isDebugging = false;
    }
    return self;
}


- (void)translate:(NSString *)source withTranslater:(id<ASTranslaterProtocol>)translater{
    if (_isDebugging) {
        NSLog(@"%@", source);
    }
    NSArray<ASToken*> *tokens = [ASLexer scanSource:source];
    if (_isDebugging) {
        for (ASToken* token in tokens) {
            NSLog(@"%@,%@", [token class], token.raw);
        }
    }
    ASTNode *root = [ASParser parseTokens:tokens];
    travelASTTree(root, @[], translater);
}

@end
