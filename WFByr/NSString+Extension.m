//
//  NSString+Extension.m
//  WFByr
//
//  Created by 李向前 on 2020/5/27.
//  Copyright © 2020 andy. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (float)heightByWidth:(float)width font:(UIFont *)font lineSpacing:(float)lineHeight alignment:(NSTextAlignment)alignment lineBreakMode:(NSLineBreakMode)breakMode {
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[NSFontAttributeName] = font;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = breakMode;
    [paragraphStyle setLineSpacing:lineHeight];
    [paragraphStyle setAlignment:alignment];
    attr[NSParagraphStyleAttributeName] = paragraphStyle;
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attr context:nil];
    return rect.size.height;
}

@end
