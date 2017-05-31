//
//  ASThreadsTitleCell.h
//  ASByrApp
//
//  Created by andy on 16/4/15.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WFThreadsTitleCellDelegate <NSObject>

@required

- (void)linkClicked:(NSURL*) url;

@end

@interface WFThreadsTitleCell : UITableViewCell

@property(nonatomic, weak) id <WFThreadsTitleCellDelegate> delegate;

- (void)setupWithTitle:(NSString*) title;

@end
