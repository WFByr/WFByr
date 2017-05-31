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

@required

- (void)linkClicked:(NSURL*) url;

@end

@interface WFThreadsReplyCell : UITableViewCell

@property(nonatomic, weak) id <WFThreadsReplyCellDelegate> delegate;

- (void)setupWithArticle:(WFArticle*) article;

@end
