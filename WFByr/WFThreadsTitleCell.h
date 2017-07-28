//
//  ASThreadsTitleCell.h
//  ASByrApp
//
//  Created by andy on 16/4/15.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFThreadsCellDelegate.h"

@interface WFThreadsTitleCell : UITableViewCell

@property(nonatomic, weak) id <WFThreadsCellDelegate> delegate;

- (void)setupWithTitle:(NSString*) title;

@end
