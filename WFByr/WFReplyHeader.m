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

- (void)setupWithThread:(WFThread *)thread {
    self.postTimeLabel.text = [NSString stringWithFormat:@"发布于:%@", wf_formatDateWithNowAndPast([NSDate date], [NSDate dateWithTimeIntervalSince1970:thread.post_time])];
    self.replyCountLabel.text = [NSString stringWithFormat:@"回复数:%ld", thread.reply_count];
}

@end
