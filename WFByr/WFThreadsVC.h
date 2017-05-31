//
//  ASThreadsVC.h
//  ASByrApp
//
//  Created by andy on 16/4/14.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ASThreadsEnterType){
    WFThreadsEnterTypeNormal,
    WFThreadsEnterTypeCollection
};

@interface WFThreadsVC : UIViewController

- (instancetype)initWithWithBoard:(NSString*)board
                              aid:(NSUInteger)aid;

@end
