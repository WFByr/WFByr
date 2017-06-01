//
//  ASThreadsBodyCell.h
//  ASByrApp
//
//  Created by andy on 16/4/15.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFArticle;

@protocol WFThreadsBodyCellDelegate <NSObject>

@required

- (void)linkClicked:(NSURL*) url;

- (void)presentImageWithUrls:(NSArray*)urls;

@end

@interface WFThreadsBodyCell : UITableViewCell

@property(nonatomic, weak) id <WFThreadsBodyCellDelegate> delegate;

- (void)setupWithContent:(NSString*)content;

- (void)setupWithArticle:(WFArticle*)article;

@end
