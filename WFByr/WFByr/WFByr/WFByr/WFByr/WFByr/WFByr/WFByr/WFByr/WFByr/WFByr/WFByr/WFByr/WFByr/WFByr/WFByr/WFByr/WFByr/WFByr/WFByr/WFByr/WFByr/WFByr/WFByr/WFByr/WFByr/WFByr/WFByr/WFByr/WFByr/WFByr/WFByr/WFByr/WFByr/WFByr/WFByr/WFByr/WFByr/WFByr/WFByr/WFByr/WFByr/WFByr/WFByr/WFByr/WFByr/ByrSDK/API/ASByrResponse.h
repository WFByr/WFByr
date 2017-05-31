//
//  ASByrResponse.h
//  Pods
//
//  Created by andy on 16/4/5.
//
//

#import <Foundation/Foundation.h>

@interface ASByrResponse : NSObject

@property(nonatomic, assign) BOOL isSucceeded;

@property(nonatomic, assign) NSInteger statusCode;

@property(nonatomic, strong) id response;

@property(nonatomic, strong) id reformedData;

@end
