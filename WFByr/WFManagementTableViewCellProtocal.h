//
//  WFManagementTableViewCellProtocal.h
//  WFByr
//
//  Created by 李向前 on 2017/8/21.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

//为了样式统一 这几个参数在多处Cell用到 最好有一个公用TableViewController基类 实现好这几个参数

@protocol WFManagementTableViewCellProtocal

@optional
- (CGFloat)wf_padding_leftToContent;

- (CGFloat)wf_padding_topToContent;

@required
- (CGFloat)wf_padding_rightToContent;

@end
