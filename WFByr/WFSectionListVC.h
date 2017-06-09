//
//  WFSectionListVCTableViewController.h
//  WFByr
//
//  Created by Andy on 2017/6/8.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WFBoardPickerDelegate;

@interface WFSectionListVC : UITableViewController

@property (nonatomic, weak) id<WFBoardPickerDelegate> pickerDelegate;

- (instancetype)initWithSectionName:(NSString*)name;

@end
