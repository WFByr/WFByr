//
//  WFTableViewCell.m
//  WFByr
//
//  Created by 李向前 on 2017/8/20.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFTableViewCell.h"

@implementation WFTableViewCell

+ (id)reusableCellOfTableView:(UITableView *)tableView identifier:(NSString *)reuseIdentifier{
    if (!reuseIdentifier) {
        reuseIdentifier = NSStringFromClass([self class]);
    }
    WFTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
