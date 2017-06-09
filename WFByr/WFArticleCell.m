//
//  WFArticleCell.m
//  WFByr
//
//  Created by Andy on 2017/6/2.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFArticleCell.h"
#import "WFModels.h"
#import "UIImageView+WebCache.h"

@interface WFArticleCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *faceImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastReplyLabel;

@end

@implementation WFArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithArticle:(WFArticle*)article {
    [self.faceImg sd_setImageWithURL:[NSURL URLWithString:article.user.face_url]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ · %@", article.user.uid, wf_formatDateWithNowAndPast([NSDate date], [NSDate dateWithTimeIntervalSince1970:article.post_time])];
    self.titleLabel.text = article.title;
    self.lastReplyLabel.text = [NSString stringWithFormat:@"最后回复 %@", wf_formatDateWithNowAndPast([NSDate date], [NSDate dateWithTimeIntervalSince1970:article.last_reply_time])];
}

@end
