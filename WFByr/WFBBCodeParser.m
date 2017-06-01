//
//  WFBBCodeParser.m
//  WFByr
//
//  Created by Andy on 2017/5/31.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFBBCodeParser.h"
#import "ASTranslater.h"
#import "YYText.h"
#import "UIImage+GIF.h"
#import "UIColor+Hex.h"
#import "UIImageView+WebCache.h"




@interface WFBBCodeParser ()

@end

@interface WFBBCodeParser (ASTranslator) <ASTranslaterProtocol>

@end

@implementation WFBBCodeParser {
    ASTranslater *_translator;
    NSMutableAttributedString *_translatedString;
    UIFont *_font;
    CGFloat _fontSize;
    NSString *_fontName;
    UIFont *_boldFont;
    UIFont *_italicFont;
    UIColor *_codeTextColor;
    UIFont *_monospaceFont;
    YYTextBorder *_border;
}

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _translator = [ASTranslater new];
        _translator.isDebugging = true;
        _translatedString = [[NSMutableAttributedString alloc] init];
        _fontName = @"Avenir-Light";
        _fontSize = 14;
        _font = [UIFont fontWithName:_fontName size:_fontSize];
        _boldFont = YYTextFontWithBold(_font);
        _italicFont = YYTextFontWithItalic(_font);
        _codeTextColor = [UIColor colorWithWhite:0.906 alpha:1.000];
        _border = [[YYTextBorder alloc] init];
        _border.lineStyle = YYTextLineStyleSingle;
        _border.fillColor = [UIColor colorWithWhite:0.184 alpha:0.090];
        _border.strokeColor = [UIColor colorWithWhite:0.546 alpha:0.650];
        _border.insets = UIEdgeInsetsMake(-1, 0, -1, 0);
        _border.cornerRadius = 2;
        _border.strokeWidth = YYTextCGFloatFromPixel(1);
        _monospaceFont = [UIFont fontWithName:@"Menlo" size:_fontSize];
    }
    return self;
}

- (NSAttributedString*)parseBBCode:(NSString *)aBBCode {
    [_translatedString beginEditing];
    [_translator translate:aBBCode withTranslater:self];
    [_translatedString endEditing];
    return _translatedString;
}


@end


void wf_setSize(NSMutableAttributedString *targetStr, NSString *fontName, NSString *size) {
    targetStr.yy_font = [UIFont fontWithName:fontName size:[size floatValue] + 13];
}

void wf_setColor(NSMutableAttributedString *targetStr, NSString *color) {
    targetStr.yy_color = [UIColor colorWithHexString:color];
}

void wf_setUrl(NSMutableAttributedString *targetStr, NSString *url) {
    [targetStr yy_setTextHighlightRange:NSMakeRange(0, targetStr.length) color:[UIColor blueColor] backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    }];
}

void wf_setImage(NSMutableAttributedString *targetStr, NSString *imgUrl, NSString *fileName) {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    if (imgUrl)
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    else
    [imgView setImage:[UIImage imageNamed:fileName]];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSAttributedString *imgStr = [NSAttributedString yy_attachmentStringWithContent:imgView
                                                                        contentMode:UIViewContentModeCenter
                                                                     attachmentSize:imgView.frame.size
                                                                        alignToFont:[UIFont systemFontOfSize:16]
                                                                          alignment:YYTextVerticalAlignmentCenter];
    [targetStr yy_appendString:@"\n"];
    [targetStr appendAttributedString:imgStr];
    [targetStr yy_appendString:@"\n"];
}

void wf_setWebImage(NSMutableAttributedString *targetStr, NSString *imgUrl) {
    wf_setImage(targetStr, imgUrl, nil);
}

void wf_setLocalImage(NSMutableAttributedString *targetStr, NSString *fileName) {
    wf_setImage(targetStr, nil, fileName);
}

void wf_setEmotion(NSMutableAttributedString *target, NSString *emotion) {
    UIImage *emotionImg = [UIImage imageNamed:[emotion stringByAppendingString:@".gif"]];
    NSAttributedString *emotionStr = [NSAttributedString yy_attachmentStringWithEmojiImage:emotionImg fontSize:14];
    
    [target appendAttributedString:emotionStr];
}

void wf_setB(NSMutableAttributedString *targetStr) {
    [targetStr yy_setExpansion:@1 range:NSMakeRange(0, targetStr.length)];
}

void wf_setU(NSMutableAttributedString *targetStr) {
    [targetStr yy_setTextUnderline:[YYTextDecoration decorationWithStyle:YYTextLineStyleSingle width:@1 color:[UIColor blackColor]] range:NSMakeRange(0, targetStr.length)];
}

void wf_setCode(NSMutableAttributedString *targetStr) {

    UIColor *codeTextColor = [UIColor colorWithWhite:0.906 alpha:1.000];
    UIFont *monospaceFont = [UIFont fontWithName:@"Menlo" size:14];
    
    [targetStr yy_setColor:codeTextColor range:NSMakeRange(0, targetStr.length)];
    [targetStr yy_setFont:monospaceFont range:NSMakeRange(0, targetStr.length)];
    YYTextBorder *border = [[YYTextBorder alloc] init];
    border.lineStyle = YYTextLineStyleSingle;
    border.fillColor = [UIColor colorWithWhite:0.184 alpha:0.090];
    border.strokeColor = [UIColor colorWithWhite:0.200 alpha:0.300];
    border.insets = UIEdgeInsetsMake(-1, 0, -1, 0);
    border.cornerRadius = 3;
    border.strokeWidth = YYTextCGFloatFromPixel(2);
    [targetStr yy_setTextBlockBorder:border range:NSMakeRange(0, targetStr.length)];
}

void wf_setI(NSMutableAttributedString *targetStr) {
    [targetStr yy_setFont:YYTextFontWithItalic(targetStr.yy_font) range:NSMakeRange(0, targetStr.length)];
}

void wf_setLink(NSMutableAttributedString *targetStr) {
    
}

@implementation WFBBCodeParser (ASTranslator)



- (void)translateString:(NSString *)string withAttrs:(NSArray<ASAttribute *> *)attrs {
    NSMutableAttributedString *tmp = [[NSMutableAttributedString alloc] initWithString:string];
    [tmp beginEditing];
    tmp.yy_font = _font;
    for (ASAttribute *attr in attrs) {
        if ([attr.name isEqualToString:@"size"]) {
            wf_setSize(tmp, @"AvenirNext-Regular", attr.value);
        } else if ([attr.name isEqualToString:@"color"]) {
            wf_setColor(tmp, attr.value);
        } else if ([attr.name isEqualToString:@"url"]) {
            wf_setUrl(tmp, attr.value);
        } else if ([attr.name isEqualToString:@"img"]) {
            wf_setWebImage(tmp, attr.value);
        } else if ([attr.name isEqualToString:@"code"]) {
            wf_setCode(tmp);
        } else if ([attr.name isEqualToString:@"b"]) {
            wf_setB(tmp);
        } else if ([attr.name isEqualToString:@"u"]) {
            wf_setU(tmp);
        } else if ([attr.name isEqualToString:@"i"]) {
            wf_setI(tmp);
        } else if ([attr.name isEqualToString:@"link"]) {
            
        } else if ([attr.name isEqualToString:@"face"]) {
            
        }
    }
    [tmp endEditing];
    [_translatedString appendAttributedString:tmp];
}

- (void)translateTagWithName:(NSString *)name value:(NSString *)val attrs:(NSArray<ASAttribute *> *)attrs {
    NSMutableAttributedString *tmp = [NSMutableAttributedString new];
    if ([name isEqualToString:@"img"]) {
        wf_setWebImage(tmp, val);
    } else if([name hasPrefix:@"em"]) {
        wf_setEmotion(tmp, name);
    } else if ([name isEqualToString:@"upload"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(customizeTag:)] && [self.delegate customizeTag:@"upload"]) {
            tmp = [[self.delegate renderTag:@"upload" withValue:val] mutableCopy];
        } else {
            wf_setLocalImage(tmp, @"placeholder");
        }
    }
    [_translatedString appendAttributedString:tmp];
}

@end
