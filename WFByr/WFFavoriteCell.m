//
//  WFFavoriteCell.m
//  WFByr
//
//  Created by lixiangqian on 17/6/2.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFFavoriteCell.h"
#import "UIImageView+Corner.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
        
        UIImageView * imView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, PROFILE_IMAGE_WIDTH, PROFILE_IMAGE_WIDTH)];
        [imView xq_addCorner:PROFILE_IMAGE_WIDTH/2];
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
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.textColor = [UIColor blueColor];
        nameLabel.numberOfLines=1;
        [wapUpView addSubview:nameLabel];
        
//        UIImageView * firstImageView = [UIImageView new];
//        self.firstImageView = firstImageView;
//        [wapDownView addSubview:firstImageView];
        
        UILabel * titleLabel = [UILabel new];
        self.titleLabel = titleLabel;
        titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        titleLabel.numberOfLines = 2;
        [wapDownView addSubview:titleLabel];
        
        [wapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(PADDING_TO_CONTENTVIEW);
            make.top.equalTo(self.contentView.mas_top).offset(PADDING_TO_CONTENTVIEW);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-PADDING_TO_CONTENTVIEW);
            make.right.equalTo(self.contentView.mas_right).offset(-PADDING_TO_CONTENTVIEW);
        }];
        
        [wapUpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wapView.mas_left);
            make.top.equalTo(wapView.mas_top);
            make.height.mas_lessThanOrEqualTo(@50);
            make.right.equalTo(wapView.mas_right);
        }];
        
        [wapDownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wapUpView.mas_bottom).offset(PADDING_TO_CONTENTVIEW);
            make.left.equalTo(wapView.mas_left);
            make.right.equalTo(wapView.mas_right);
            make.bottom.equalTo(wapView.mas_bottom);
        }];
        
        [imView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wapUpView).offset(PADDING_WITHIN);
            make.left.equalTo(wapUpView).offset(PADDING_WITHIN);
            make.size.mas_equalTo(CGSizeMake(PROFILE_IMAGE_WIDTH, PROFILE_IMAGE_WIDTH));
            make.bottom.equalTo(wapUpView).offset(-PADDING_WITHIN);
        }];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imView.mas_right).offset(PADDING_WITHIN);
            make.centerY.equalTo(imView.mas_centerY);
            make.width.mas_lessThanOrEqualTo(@100);
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
            make.top.equalTo(wapDownView.mas_top).offset(PADDING_WITHIN);
            make.left.equalTo(wapDownView.mas_left).offset(PADDING_WITHIN);
            make.right.equalTo(wapDownView).offset(-PADDING_WITHIN);
            make.bottom.equalTo(wapDownView).offset(-PADDING_WITHIN);
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

- (void)setUpParameters:(id)parameters{
    NSString * profileImageUrl;
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        self.titleLabel.text = [[parameters objectForKey:@"title"]copy];
        self.userNameLabel.text = [[parameters objectForKey:@"user_name"] copy];
        //self.replyCount.text = [NSString stringWithFormat:@"%@条回复",[parameters objectForKey:@"replyCount"]];
        profileImageUrl = [parameters objectForKey:@"face_url"];
    }else{
        self.titleLabel.text = [[parameters valueForKey:@"title"]copy];
        self.userNameLabel.text = [[parameters valueForKeyPath:@"user.user_name"] copy];
        //self.replyCount.text = [NSString stringWithFormat:@"%@条回复",[parameters valueForKey:@"replyCount"]];
        profileImageUrl = [parameters valueForKeyPath:@"user.face_url"];
        
    }
    if(profileImageUrl && ![profileImageUrl isEqual:@""]){
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:profileImageUrl] placeholderImage:[UIImage imageNamed:@"blank"] options:SDWebImageRefreshCached];
    }
    
}
@end