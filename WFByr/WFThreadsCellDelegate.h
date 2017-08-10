//
//  WFThreadsCellProtocol.h
//  WFByr
//
//  Created by Andy on 2017/7/27.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WFThreadsCellDelegate <NSObject>

@optional

- (void)linkClicked:(NSURL*) url;

- (void)presentImageWithUrls:(NSArray*)urls selected:(NSInteger)index fromView:(UIView*)view;

- (void)goToUser:(NSString*)uid;

- (void)playAudioWithUrl:(NSURL*)url;

@end
