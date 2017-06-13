//
//  ASThreadsReplyCell.m
//  ASByrApp
//
//  Created by andy on 16/4/15.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFThreadsReplyCell.h"
#import "WFModels.h"
#import "WFBBCodeParser.h"
#import "YYText.h"
#import "WFRouter.h"
#import "UIImageView+WebCache.h"

@interface WFThreadsReplyCell()

@property (weak, nonatomic) IBOutlet UIImageView *faceImage;
@property (weak, nonatomic) IBOutlet UILabel *uidLabel;
@property (weak, nonatomic) IBOutlet UILabel *postDateLabel;
@property (weak, nonatomic) IBOutlet YYLabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyNoLabel;

@end

@interface WFThreadsReplyCell (WFBBCodeDelegate) <WFBBCodeParserDelegate>

@end

@implementation WFThreadsReplyCell {
    WFBBCodeParser *_parser;
    WFArticle *_article;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _parser = [WFBBCodeParser new];
    _parser.delegate = self;
    
    self.faceImage.layer.masksToBounds = YES;
    self.faceImage.layer.cornerRadius = 15;
    self.faceImage.layer.borderWidth = 1;
    self.faceImage.layer.borderColor = FACE_BORDER_COLOR.CGColor;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToUser)];
    self.faceImage.userInteractionEnabled = YES;
    [self.faceImage addGestureRecognizer:tapGestureRecognizer];
    self.uidLabel.userInteractionEnabled = YES;
    [self.uidLabel addGestureRecognizer:tapGestureRecognizer];
    
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

- (void)setupWithArticle:(WFArticle*)article replyNo:(NSInteger)replyNo{
    _article = article;
    [self.faceImage sd_setImageWithURL:[NSURL URLWithString:article.user.face_url]];
    self.uidLabel.text = [NSString stringWithFormat:@"%@ · %@", article.user.uid, wf_formatDateWithNowAndPast([NSDate date], [NSDate dateWithTimeIntervalSince1970:article.post_time])];
    self.contentLabel.font = [UIFont fontWithName:WFFontName size:16.0];
    self.contentLabel.attributedText = [_parser parseBBCode:article.content];
    self.replyNoLabel.text = [NSString stringWithFormat:@"#%ld", replyNo];
}

- (void)goToUser {
    if ([_delegate respondsToSelector:@selector(goToUser:)]) {
        [_delegate goToUser:_article.user.uid];
    }
}

@end

@implementation WFThreadsReplyCell (WFBBCodeDelegate)

- (BOOL)customizeTag:(NSString *)tagName {
    return [tagName isEqualToString:@"upload"];
}

- (NSAttributedString*)renderTag:(NSString *)tagName withValue:(NSString *)val {
    NSMutableAttributedString *renderedStr = [NSMutableAttributedString new];
    if ([tagName isEqualToString:@"upload"] && _article.has_attachment) {
        NSUInteger attachmentNo = [val integerValue] - 1;
        
        
        if (attachmentNo >= _article.attachment.file.count) {
            return renderedStr;
        }
        NSString *imgUrl = _article.attachment.file[attachmentNo].thumbnail_middle;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        if (imgUrl)
            [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        NSAttributedString *imgStr = [NSAttributedString yy_attachmentStringWithContent:imgView
                                                                            contentMode:UIViewContentModeCenter
                                                                         attachmentSize:imgView.frame.size
                                                                            alignToFont:[UIFont systemFontOfSize:16]
                                                                              alignment:YYTextVerticalAlignmentCenter];
        [renderedStr yy_appendString:@"\n"];
        [renderedStr appendAttributedString:imgStr];
        [renderedStr yy_appendString:@"\n"];
        return renderedStr;
    }
    [renderedStr yy_appendString:[NSString stringWithFormat:@"[%@=%@][/%@]", tagName, val, tagName]];
    return renderedStr;
    
}
@end
