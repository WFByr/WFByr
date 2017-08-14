//
//  UIColor+WFColors.m
//  WFByr
//
//  Created by Andy on 2017/8/13.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "UIColor+WFColors.h"

@implementation UIColor (WFColors)

+ (instancetype)wf_mainBlue {
    return [UIColor colorWithRed:0.00 green:0.63 blue:0.95 alpha:1.00];
}

+ (instancetype)wf_darkerBlue {
    return [UIColor colorWithRed:0.00 green:0.48 blue:0.69 alpha:1.00];
}

+ (instancetype)wf_mainGray {
    return [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1.00];
}

+ (instancetype)wf_faceBorder {
    return [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1.00];
}

@end
