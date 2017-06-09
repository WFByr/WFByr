//
//  WFSectionListVC.h
//  WFByr
//
//  Created by Andy on 2017/6/2.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const WFBoardPickerBoardKey;

@class WFBoardPicker;
@protocol WFBoardPickerDelegate <NSObject>

@optional

- (void)boardPicker:(WFBoardPicker*)boardPicker didFinishPickingWithInfo:(NSDictionary<NSString*, id>*) info;

@end


@interface WFBoardPicker : UINavigationController

@property (nonatomic, weak) id<WFBoardPickerDelegate> pickerDelegate;

@end
