//
//  ASThreadsTitleCell.m
//  ASByrApp
//
//  Created by andy on 16/4/15.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFThreadsTitleCell.h"

@interface WFThreadsTitleCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WFThreadsTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithTitle:(NSString *)title {
    self.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:title];
}

@end
