//
//  WFMp3PlayerView.m
//  WFByr
//
//  Created by Andy on 2017/7/31.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFMp3PlayerView.h"
#import "XXNibBridge.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface WFMp3PlayerView ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation WFMp3PlayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)mp3PlayerViewWithUrl:(NSString *)urlString {
    WFMp3PlayerView *playerView = [WFMp3PlayerView xx_instantiateFromNib];
    playerView.url = [NSURL URLWithString:urlString];
    playerView.player = [AVPlayer playerWithURL:playerView.url];
    return playerView;
}

- (IBAction)playBtnClicked:(id)sender {
    [_player play];
}



@end
