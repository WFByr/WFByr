//
//  WFReplyHeader.m
//  WFByr
//
//  Created by Andy on 2017/6/1.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFReplyHeader.h"
#import "WFModels.h"

@interface WFReplyHeader ()

@property (weak, nonatomic) IBOutlet UILabel *postTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *idCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;

@end


@implementation WFReplyHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setupWithArticle:(WFArticle *)article {
    self.postTimeLabel.text = [NSString stringWithFormat:@"发布于:%@", wf_formatDateWithNowAndPast([NSDate date], [NSDate dateWithTimeIntervalSince1970:article.post_time])];
    self.idCountLabel.text = [NSString stringWithFormat:@"参与人数:%ld", article.id_count];
    self.replyCountLabel.text = [NSString stringWithFormat:@"回复数:%ld", article.reply_count];
}

@end
