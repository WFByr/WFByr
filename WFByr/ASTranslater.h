//
//  Translator.h
//  playground
//
//  Created by Andy on 2017/5/11.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASLexer.h"
#import "ASParser.h"

@interface ASAttribute : NSObject

@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *value;


+(instancetype)attributeWithName:(NSString*)name value:(NSString*)value;

@end

@protocol ASTranslaterProtocol <NSObject>

@optional
- (void)translateString:(NSString*) string withAttrs:(NSArray<ASAttribute*>*) attrs;

- (void)translateTagWithName:(NSString *)name value:(NSString*)val attrs:(NSArray<ASAttribute*> *)attrs;

@end

@interface ASTranslater : NSObject

@property (nonatomic, assign) BOOL isDebugging;

- (void)translate:(NSString*) source withTranslater:(id<ASTranslaterProtocol>) translater;

@end
