//
//  WFTableViewCell.h
//  WFByr
//
//  Created by 李向前 on 2017/8/20.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFTableViewCell : UITableViewCell

+ (id)reusableCellOfTableView:(UITableView *)tableView identifier:(NSString *)reuseIdentifier;

@end
