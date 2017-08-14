//
//  UIFont+WFFonts.m
//  WFByr
//
//  Created by Andy on 2017/8/13.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "UIFont+WFFonts.h"

const CGFloat kSmallSize = 14.0;
const CGFloat kNormalSize = 17.0;
const CGFloat kBigSize = 20.0;
const CGFloat kHugeSize = 24.0;

static NSString * const kDefaultFontName = @"AvenirNext-Regular";
@implementation UIFont (WFFonts)

+ (instancetype)wf_smallFont {
    return [UIFont fontWithName:kDefaultFontName size:kSmallSize];
}

+ (instancetype)wf_normalFont {
    return [UIFont fontWithName:kDefaultFontName size:kNormalSize];
}

+ (instancetype)wf_bigFont {
    return [UIFont fontWithName:kDefaultFontName size:kBigSize];
}

+ (instancetype)wf_hugeFont {
    return [UIFont fontWithName:kDefaultFontName size:kHugeSize];
}

@end
