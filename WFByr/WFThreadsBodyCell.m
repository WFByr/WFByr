//
//  ASThreadsBodyCell.m
//  ASByrApp
//
//  Created by andy on 16/4/15.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFThreadsBodyCell.h"
#import "WFBBCodeParser.h"
#import "YYText.h"


@interface WFThreadsBodyCell()

@property (weak, nonatomic) IBOutlet YYLabel *contentLabel;

@end

@implementation WFThreadsBodyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //self.contentLabel.textParser = [[YYTextSimpleMarkdownParser alloc] init];
    
    YYTextLinePositionSimpleModifier *modifier = [YYTextLinePositionSimpleModifier new];
    modifier.fixedLineHeight = 24;
    //self.contentLabel.linePositionModifier = modifier;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width;
//    self.contentLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    //self.contentLabel.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithContent:(NSString *)content {
    //NSAttributedString * str = [[NSAttributedString alloc] initWithUBB:content];
    self.contentLabel.attributedText = [[WFBBCodeParser new] parseBBCode:content];
}

@end
