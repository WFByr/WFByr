//
//  NSString+Extension.h
//  WFByr
//
//  Created by 李向前 on 2020/5/27.
//  Copyright © 2020 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

- (float)heightByWidth:(float)width font:(UIFont *)font lineSpacing:(float)lineHeight alignment:(NSTextAlignment)alignment lineBreakMode:(NSLineBreakMode)breakMode;

@end

NS_ASSUME_NONNULL_END
