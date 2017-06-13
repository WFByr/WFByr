//
//  ASThreadsBodyCell.m
//  ASByrApp
//
//  Created by andy on 16/4/15.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFThreadsBodyCell.h"
#import "WFModels.h"
#import "WFBBCodeParser.h"
#import "UIImageView+WebCache.h"
#import "YYText.h"
#import "UIImageView+WebCache.h"
#import "IDMPhotoBrowser.h"


@interface WFThreadsBodyCell()

@property (weak, nonatomic) IBOutlet UIImageView *faceImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet YYLabel *contentLabel;

@property (nonatomic, strong) NSMutableArray<UIImageView*> *imgViews;

@end

@interface WFThreadsBodyCell (WFBBCodeParserDelegate) <WFBBCodeParserDelegate>

@end

@implementation WFThreadsBodyCell {
    WFBBCodeParser *_parser;
    WFArticle *_article;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _parser = [WFBBCodeParser new];
    _parser.delegate = self;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //self.contentLabel.textParser = [[YYTextSimpleMarkdownParser alloc] init];
    self.faceImg.layer.masksToBounds = YES;
    self.faceImg.layer.cornerRadius = 15;
    self.faceImg.layer.borderWidth = 1;
    self.faceImg.layer.borderColor = FACE_BORDER_COLOR.CGColor;
    
    self.faceImg.userInteractionEnabled = YES;
    [self.faceImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToUser)]];
    
    self.nameLabel.userInteractionEnabled = YES;
    [self.nameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToUser)]];
    
    YYTextLinePositionSimpleModifier *modifier = [YYTextLinePositionSimpleModifier new];
    modifier.fixedLineHeight = 24;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithContent:(NSString *)content {
    //NSAttributedString * str = [[NSAttributedString alloc] initWithUBB:content];
    self.contentLabel.attributedText = [[WFBBCodeParser new] parseBBCode:content];
}

- (void)setupWithArticle:(WFArticle*)article {
    self.imgViews = [NSMutableArray array];
    _article = article;
    [self.faceImg sd_setImageWithURL:[NSURL URLWithString:article.user.face_url]];
    self.nameLabel.text = article.user.uid;
    self.titleLabel.text = article.title;
    self.contentLabel.attributedText = [_parser parseBBCode:_article.content];
}

- (void)goToUser {
    if ([_delegate respondsToSelector:@selector(goToUser:)]) {
        [_delegate goToUser:_article.user.uid];
    }
}

@end


@implementation WFThreadsBodyCell (WFBBCodeParserDelegate)

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
        imgView.userInteractionEnabled = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClicked:)]];
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        [self.imgViews addObject:imgView];
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

- (void)imgClicked:(UITapGestureRecognizer*)recognizer {
    NSMutableArray<NSURL*> *urls = [NSMutableArray array];
    for (WFFile *file in _article.attachment.file) {
        [urls addObject:[NSURL URLWithString:file.url]];
    }
    [self.delegate presentImageWithUrls:urls];
}
@end
