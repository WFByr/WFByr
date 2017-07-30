//
//  WFMp3PlayerView.h
//  WFByr
//
//  Created by Andy on 2017/7/31.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFMp3PlayerView : UIView

@property (nonatomic, strong) NSURL *url;

+ (instancetype)mp3PlayerViewWithUrl:(NSString*)urlString;

@end
