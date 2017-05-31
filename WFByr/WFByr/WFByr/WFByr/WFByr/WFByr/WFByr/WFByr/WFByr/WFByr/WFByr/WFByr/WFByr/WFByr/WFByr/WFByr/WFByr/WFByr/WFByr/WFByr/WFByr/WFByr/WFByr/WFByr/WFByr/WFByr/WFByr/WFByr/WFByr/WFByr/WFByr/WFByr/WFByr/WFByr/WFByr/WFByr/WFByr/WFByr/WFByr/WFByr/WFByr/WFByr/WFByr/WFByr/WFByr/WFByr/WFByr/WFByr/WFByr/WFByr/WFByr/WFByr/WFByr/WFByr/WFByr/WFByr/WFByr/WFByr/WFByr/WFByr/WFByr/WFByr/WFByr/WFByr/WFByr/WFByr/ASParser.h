//
//  Parser.h
//  playground
//
//  Created by Andy on 2017/5/9.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASLexer.h"

typedef NS_ENUM(NSUInteger, ASTNodeType) {
    ASTNodeTypeRoot,
    ASTNodeTypeString,
    ASTNodeTypeTwinTag,
    ASTNodeTypeSingleTag,
};
@interface ASTNode : NSObject

@property (nonatomic, strong) NSArray<ASTNode*> *children;

@property (nonatomic, assign) ASTNodeType nodeType;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *val;

+ (instancetype)rootNode;

@end

@interface ASParser : NSObject

@property (nonatomic, strong) NSSet<NSString*> *twinTags;

@property (nonatomic, strong) NSSet<NSString*> *singleTags;

+ (ASTNode *) parseTokens:(NSArray<ASToken*> *) tokens;

@end
