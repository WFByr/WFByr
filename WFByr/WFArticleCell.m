//
//  WFArticleCell.m
//  WFByr
//
//  Created by Andy on 2017/6/2.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFArticleCell.h"
#import "WFArticle.h"

@interface WFArticleCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation WFArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithArticle:(WFArticle*)article {
    self.label.text = article.title;
}

@end
