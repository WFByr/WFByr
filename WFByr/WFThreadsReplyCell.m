//
//  ASThreadsReplyCell.m
//  ASByrApp
//
//  Created by andy on 16/4/15.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFThreadsReplyCell.h"
#import "UIImageView+AFNetworking.h"
#import "WFModels.h"
#import "WFBBCodeParser.h"
#import "YYText.h"

@interface WFThreadsReplyCell()

@property (weak, nonatomic) IBOutlet UIImageView *faceImage;
@property (weak, nonatomic) IBOutlet UILabel *uidLabel;
@property (weak, nonatomic) IBOutlet UILabel *postDateLabel;
@property (weak, nonatomic) IBOutlet YYLabel *contentLabel;

@end

@implementation WFThreadsReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.faceImage.layer.masksToBounds = YES;
    self.faceImage.layer.cornerRadius = 15;
    self.faceImage.layer.borderWidth = 1;
    self.faceImage.layer.borderColor = FACE_BORDER_COLOR.CGColor;
    
    
    
    YYTextLinePositionSimpleModifier *modifier = [YYTextLinePositionSimpleModifier new];
    modifier.fixedLineHeight = 24;
    //self.contentLabel.linePositionModifier = modifier;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithArticle:(WFArticle*) article {
    [self.faceImage setImageWithURL:[NSURL URLWithString:article.user.face_url]];
    //ASUbbParser *parser = [[ASUbbParser alloc] init];
    //self.contentLabel.textParser = parser;
    //parser.attachment = article.attachment;
    self.uidLabel.text = article.user.uid;
    self.postDateLabel.text = [WFHelpers formatDateWithNow:[NSDate date] past:[NSDate dateWithTimeIntervalSince1970:article.post_time]];
    self.contentLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0];
    self.contentLabel.attributedText = [[WFBBCodeParser new] parseBBCode:article.content];
    NSLog(@"%ld", article.aid);
    NSLog(@"%@", article.board_name);
}

@end
