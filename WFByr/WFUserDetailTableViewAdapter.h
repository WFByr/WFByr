//
//  WFUserDetailTableViewAdapter.h
//  WFByr
//
//  Created by 李向前 on 2017/8/22.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFManagementTableViewHelperProtocal.h"

@interface WFUserDetailTableViewAdapter : NSObject

@property (nonatomic, weak) UIViewController<WFManagementTableViewHelperProtocal> * ownerController;

@end
