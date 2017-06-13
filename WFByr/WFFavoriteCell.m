//
//  WFFavoriteCell.m
//  WFByr
//
//  Created by lixiangqian on 17/6/2.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFFavoriteCell.h"
#import "WFModels.h"
#import "UIImageView+Corner.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

const CGFloat WFProfileImageWidth = 30;
const CGFloat WFPaddingToContentview = 5;
const CGFloat WFPaddingWithin = 6;
const CGFloat WFDistractorHeight = 0.3;

@implementation WFFavoriteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView * wapView = [UIView new];
        self.wapView = wapView;
        [self.contentView addSubview:wapView];
        
        UIView * wapUpView = [UIView new];
        self.wapUpView = wapUpView;
        [self.contentView addSubview:wapUpView];
        
        UIView * wapDownView = [UIView new];
        self.wapDownView = wapDownView;
        [self.contentView addSubview:wapDownView];
        
        UIImageView * imView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WFProfileImageWidth, WFProfileImageWidth)];
        [imView wf_addCorner:WFPaddingToContentview/2];
        self.userImageView=imView;
        [self.imageView removeFromSuperview];
        
        [wapUpView addSubview:self.userImageView];
        
//        UILabel *replyCount = [UILabel new];
//        self.replyCount = replyCount;
//        replyCount.font = [UIFont systemFontOfSize:12];
//        replyCount.numberOfLines=1;
//        [wapUpView addSubview:replyCount];
        
        UILabel * nameLabel = [UILabel new];
        self.userNameLabel = nameLabel;
        nameLabel.font = [UIFont fontWithName:WFFontName size:14];
        nameLabel.textColor = MAIN_GRAY;
        nameLabel.numberOfLines=1;
        [wapUpView addSubview:nameLabel];
        
        UILabel *createdTimeLabel = [UILabel new];
        self.createdTimeLabel = createdTimeLabel;
        createdTimeLabel.textAlignment = NSTextAlignmentRight;
        createdTimeLabel.font = [UIFont fontWithName:WFFontName size:13];
        createdTimeLabel.textColor = MAIN_GRAY;
        [wapUpView addSubview:createdTimeLabel];

        UILabel * titleLabel = [UILabel new];
        self.titleLabel = titleLabel;
        titleLabel.font = [UIFont fontWithName:WFFontName size:16];
        titleLabel.numberOfLines = 2;
        [wapDownView addSubview:titleLabel];
        
        [wapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(WFPaddingToContentview);
            make.top.equalTo(self.contentView.mas_top).offset(WFPaddingToContentview);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-WFPaddingToContentview);
            make.right.equalTo(self.contentView.mas_right).offset(-WFPaddingToContentview);
        }];
        
        [wapUpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wapView.mas_left);
            make.top.equalTo(wapView.mas_top);
            make.height.mas_lessThanOrEqualTo(@50);
            make.right.equalTo(wapView.mas_right);
        }];
        
        [wapDownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wapUpView.mas_bottom).offset(WFPaddingToContentview);
            make.left.equalTo(wapView.mas_left);
            make.right.equalTo(wapView.mas_right);
            make.bottom.equalTo(wapView.mas_bottom);
        }];
        
        [imView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wapUpView).offset(WFPaddingWithin);
            make.left.equalTo(wapUpView).offset(WFPaddingWithin);
            make.size.mas_equalTo(CGSizeMake(WFProfileImageWidth, WFProfileImageWidth));
            make.bottom.equalTo(wapUpView).offset(-WFPaddingWithin);
        }];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imView.mas_right).offset(WFPaddingWithin);
            make.centerY.equalTo(imView.mas_centerY);
        }];
        
        [createdTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameLabel);
            make.right.equalTo(wapUpView);
        }];
//        [replyCount mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(wapUpView.mas_right).offset(-PADDING_WITHIN);
//            make.centerY.equalTo(imView.mas_centerY);
//            make.width.lessThanOrEqualTo(@100);
//        }];
        
//        [firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(wapDownView.mas_left).offset(2*PADDING_WITHIN);
//            make.top.equalTo(wapDownView.mas_top);
//            make.size.mas_equalTo(CGSizeMake(60, 60));
//            
//        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wapDownView.mas_top).offset(WFPaddingWithin);
            make.left.equalTo(wapDownView.mas_left).offset(WFPaddingWithin);
            make.right.equalTo(wapDownView).offset(-WFPaddingWithin);
            make.bottom.equalTo(wapDownView).offset(-WFPaddingWithin);
        }];
        
        [super updateConstraints];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setUpParameters:(WFCollection*)collection{
    NSString * profileImageUrl;
    self.titleLabel.text = collection.title.copy;
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ · %@", collection.user.user_name, collection.bname];
    
    
    NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:collection.createdTime.integerValue];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = NSDateFormatterShortStyle;
    self.createdTimeLabel.text = [formatter stringFromDate:createdDate];
    profileImageUrl = collection.user.face_url.copy;

    if(profileImageUrl && ![profileImageUrl isEqual:@""]){
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:profileImageUrl] placeholderImage:[UIImage imageNamed:@"blank"] options:SDWebImageRefreshCached];
    }
    
}
@end
