//
//  ASDebugger.m
//  playground
//
//  Created by Andy on 2017/5/10.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "ASDebugger.h"
#import "ASTranslater.h"

NSString *printASTTree(ASTNode*root, NSString *attr) {
    NSMutableString *str = [NSMutableString string];
    if (root.children == nil || root.children.count == 0) { // leaf
        if (root.nodeType == ASTNodeTypeString)
            [str appendFormat:@"\n%@,(%@)", root.val, attr];
        else
            [str appendFormat:@"\n(%@,%@)", root.tag, root.val];
    } else {
        NSMutableString *tmpAttr = [attr mutableCopy];
        if (root.nodeType != ASTNodeTypeRoot) [tmpAttr appendFormat:@"<%@,%@>", root.tag, root.val];
        for (ASTNode *child in root.children) {
            [str appendString:printASTTree(child, [tmpAttr copy])];
        }
    }
    [str appendString:@"\n"];
    return str;
}

@interface ASDebugger () <ASTranslaterProtocol>

@end

@implementation ASDebugger {
    NSMutableString *_debugString;
}

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _debugString = [NSMutableString string];
    }
    return self;
}
- (NSString*)debug:(NSString *)input {
    ASTranslater *translater = [ASTranslater new];
    translater.isDebugging = true;
    [translater translate:input withTranslater:self];
    return _debugString;
}

- (void)translateString:(NSString *)string withAttrs:(NSArray *)attrs {
    NSMutableString *attrString = [NSMutableString string];
    for (ASAttribute *attr in attrs) {
        [attrString appendFormat:@"<%@,%@>,", attr.name, attr.value];
    }
    
    [_debugString appendFormat:@"%@,(%@)\n", string, attrString];
}

- (void)translateTagWithName:(NSString *)name value:(NSString *)val attrs:(NSArray *)attrs {
    [_debugString appendFormat:@"(%@,%@)\n", name, val];
}
@end
