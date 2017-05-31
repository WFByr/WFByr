//
//  WFBBCodeParserTests.m
//  WFByr
//
//  Created by Andy on 2017/5/31.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WFBBCodeParser.h"
#import "ASDebugger.h"
@interface WFBBCodeParserTests : XCTestCase

@end

@implementation WFBBCodeParserTests {
    WFBBCodeParser *_parser;
}

- (void)setUp {
    [super setUp];
    _parser = [WFBBCodeParser new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *testString = @"[img=http://123][/img]asdfasdf[size=16]as[color=#1123]df[url=http://baidu.com]asd[/url]f[/color]ad[/size]asdfasdf";
    
    NSLog(@"%@", [[ASDebugger new] debug:testString]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
