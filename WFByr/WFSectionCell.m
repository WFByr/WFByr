//
//  WFSectionCell.m
//  WFByr
//
//  Created by Andy on 2017/6/8.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFSectionCell.h"
#import "WFModels.h"
@interface WFSectionCell ()

@property (weak, nonatomic) IBOutlet UILabel *sectionNameLabel;

@end
@implementation WFSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithSection:(WFSection *)section {
    self.sectionNameLabel.text = section.desc;
    
}

@end
