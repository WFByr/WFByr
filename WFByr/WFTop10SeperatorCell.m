//
//  ASTop10SeperatorCell.m
//  ASByrApp
//
//  Created by andy on 16/5/11.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFTop10SeperatorCell.h"

@implementation WFTop10SeperatorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:WFMAIN_BACKGROUND_COLOR];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
