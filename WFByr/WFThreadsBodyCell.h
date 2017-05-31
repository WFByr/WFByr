//
//  ASThreadsBodyCell.h
//  ASByrApp
//
//  Created by andy on 16/4/15.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WFThreadsBodyCellDelegate <NSObject>

@required

- (void)linkClicked:(NSURL*) url;

@end

@interface WFThreadsBodyCell : UITableViewCell

@property(nonatomic, weak) id <WFThreadsBodyCellDelegate> delegate;

- (void)setupWithContent:(NSString*)content;

@end
