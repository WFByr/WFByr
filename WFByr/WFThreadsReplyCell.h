//
//  ASThreadsReplyCell.h
//  ASByrApp
//
//  Created by andy on 16/4/15.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFArticle;

@protocol WFThreadsReplyCellDelegate <NSObject>

@optional

- (void)linkClicked:(NSURL*) url;

- (void)goToUser:(NSString*)uid;

@end

@interface WFThreadsReplyCell : UITableViewCell

@property(nonatomic, weak) id <WFThreadsReplyCellDelegate> delegate;

- (void)setupWithArticle:(WFArticle*) article replyNo:(NSInteger)replyNo;

@end
