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
#import "UIImageView+WebCache.h"

@interface WFThreadsReplyCell()

@property (weak, nonatomic) IBOutlet UIImageView *faceImage;
@property (weak, nonatomic) IBOutlet UILabel *uidLabel;
@property (weak, nonatomic) IBOutlet UILabel *postDateLabel;
@property (weak, nonatomic) IBOutlet YYLabel *contentLabel;

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
    _article = article;
    [self.faceImage sd_setImageWithURL:[NSURL URLWithString:article.user.face_url]];
    //ASUbbParser *parser = [[ASUbbParser alloc] init];
    //self.contentLabel.textParser = parser;
    //parser.attachment = article.attachment;
    self.uidLabel.text = article.user.uid;
    self.postDateLabel.text = [WFHelpers formatDateWithNow:[NSDate date] past:[NSDate dateWithTimeIntervalSince1970:article.post_time]];
    self.contentLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];
    self.contentLabel.attributedText = [[WFBBCodeParser new] parseBBCode:article.content];
    NSLog(@"%ld", article.aid);
    NSLog(@"%@", article.board_name);
}

@end

@implementation WFThreadsReplyCell (WFBBCodeDelegate)

- (BOOL)customizeTag:(NSString *)tagName {
    return [tagName isEqualToString:@"upload"];
}

- (NSAttributedString*)renderTag:(NSString *)tagName withValue:(NSString *)val {
    if ([tagName isEqualToString:@"upload"] && _article.has_attachment) {
        NSUInteger attachmentNo = [val integerValue] - 1;
        NSMutableAttributedString *renderedStr = [NSMutableAttributedString new];
        
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
    return nil;
    
}
@end
