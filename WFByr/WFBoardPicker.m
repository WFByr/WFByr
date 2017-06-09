//
//  WFSectionListVC.m
//  WFByr
//
//  Created by Andy on 2017/6/2.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFBoardPicker.h"
#import "WFSectionCell.h"
#import "WFBoardApi.h"
#import "WFSectionListVC.h"
#import "WFModels.h"
#import "MJRefresh.h"


NSString * const WFBoardPickerBoardKey = @"WFBoardPickerBoardKey";

@interface WFBoardPicker ()


@end

@implementation WFBoardPicker {
    WFSectionListVC *rootVC;
}

- (instancetype)init {
    rootVC = [[WFSectionListVC alloc] initWithSectionName:nil];
    self = [super initWithRootViewController:rootVC];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setPickerDelegate:(id<WFBoardPickerDelegate>)pickerDelegate {
    _pickerDelegate = pickerDelegate;
    rootVC.pickerDelegate = pickerDelegate;
}

@end
