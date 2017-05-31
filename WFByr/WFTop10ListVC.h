//
//  ASTop10ListController.h
//  ASByrApp
//
//  Created by andy on 16/4/4.
//  Copyright © 2016年 andy. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WFTop10Const.h"

@interface WFTop10ListVC : UITableViewController

- (instancetype)initWithTitle:(NSString *)title
                    top10Type:(WFTop10Type)top10Type
                    sectionNo:(NSInteger)section;

@end
