//
//  WFTop10Const.h
//  WFByr
//
//  Created by Andy on 2017/5/26.
//  Copyright © 2017年 andy. All rights reserved.
//

#ifndef WFTop10Const_h
#define WFTop10Const_h

#import "WFConst.h"

typedef NS_OPTIONS(NSUInteger, WFTop10Type) {
    ASTop10      = 1 << 0,
    ASRecommend  = 1 << 1,
    ASSectionTop = 1 << 2
};

#endif /* WFTop10Const_h */
