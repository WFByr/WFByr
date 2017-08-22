//
//  WFProfileHeaderView.m
//  WFByr
//
//  Created by 李向前 on 2017/8/16.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFProfileHeaderView.h"
#import "WFUserDetailLabel.h"
#import "WFUser.h"
#import "WFManagementTableViewCellProtocal.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define WFTOPVIEW_PADDING_HEIGHT 8

@interface WFProfileHeaderView()<WFManagementTableViewCellProtocal>

@property (nonatomic, strong) UIImageView* profileBackgroundView;
@property (nonatomic, strong) UIImageView * avatarView;
@property (nonatomic, strong) UIImageView * arrowView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * userIdLabel;
@property (nonatomic, strong) WFUserDetailLabel * lifeCountLabel;//生命力
@property (nonatomic, strong) WFUserDetailLabel * articleCountLabel;//文章
@property (nonatomic, strong) WFUserDetailLabel * virtualCountLabel;//积分

@end

@implementation WFProfileHeaderView{
    CALayer * _horizontalSeperatorLayer;

}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = WFMAIN_BACKGROUND_COLOR;
        UIImageView * backgroundView = [[UIImageView alloc]initWithFrame:UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(8, 0, 3*WFHeightScale , 0))];
        backgroundView.userInteractionEnabled = NO;
        _profileBackgroundView = backgroundView;
        [self addSubview:_profileBackgroundView];
        
        UIButton * profileBackgroundButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _profileBackgroundView.wf_Width, 83*WFHeightScale)];
        profileBackgroundButton.backgroundColor = [UIColor whiteColor];
        [_profileBackgroundView addSubview:profileBackgroundButton];
        
        _horizontalSeperatorLayer = [CALayer layer];
        _horizontalSeperatorLayer.frame = CGRectMake(0, profileBackgroundButton.wf_bottomY, WFSCREEN_W, WFOnePixelHeight);
        [_horizontalSeperatorLayer setBackgroundColor:FACE_BORDER_COLOR.CGColor];
        [self.layer addSublayer:_horizontalSeperatorLayer];
        
        UIImageView * avatarView = [[UIImageView alloc]initWithFrame:CGRectMake(12*WFHeightScale, 12*WFHeightScale, WFAvatarMeFirstLevelSize*2, WFAvatarMeFirstLevelSize*2)];
        _avatarView = avatarView;
        [_profileBackgroundView addSubview:_avatarView];
        
        UILabel * userIdLabel = [[UILabel alloc]initWithFrame:CGRectMake(_avatarView.wf_rightX + 10 * WFHeightScale, _avatarView.wf_topY + 8 * WFHeightScale, 190, 20)];
        userIdLabel.font = [UIFont fontWithName:WFMeFontBoldName size:16];
        _userIdLabel = userIdLabel;
        [_profileBackgroundView addSubview:_userIdLabel];
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_userIdLabel.wf_leftX, _avatarView.wf_centerY + 3*WFHeightScale, 190, 20)];
        nameLabel.font = [UIFont fontWithName:WFMeFontRegularName size:12];
        _nameLabel = nameLabel;
        [_profileBackgroundView addSubview:_nameLabel];
        
        WFUserDetailLabel * lifeCountLabel = [[WFUserDetailLabel alloc]initWithFrame:CGRectMake(0, 83 * WFHeightScale, self.wf_Width/3, 52*WFHeightScale)];
        _lifeCountLabel = lifeCountLabel;
        [_profileBackgroundView addSubview:_lifeCountLabel];
        
        
        WFUserDetailLabel * articleCountLabel = [[WFUserDetailLabel alloc]initWithFrame:CGRectMake(_lifeCountLabel.wf_rightX, 83*WFHeightScale, self.wf_Width/3, 52*WFHeightScale)];
        _articleCountLabel = articleCountLabel;
        [_profileBackgroundView addSubview:_articleCountLabel];
        
        WFUserDetailLabel * virtualCountLabel = [[WFUserDetailLabel alloc]initWithFrame:CGRectMake(_articleCountLabel.wf_rightX, 83*WFHeightScale, self.wf_Width/3, 52*WFHeightScale)];
        _virtualCountLabel = virtualCountLabel;
        [_profileBackgroundView addSubview:_virtualCountLabel];
        
        UIImageView * arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me_arrow"]];
        arrowView.frame = CGRectMake(profileBackgroundButton.wf_Width - 14 - [self wf_padding_rightToContent], (profileBackgroundButton.wf_Height-14)/2,14, 14);
        [_profileBackgroundView addSubview:arrowView];
    }
    return self;
}

- (void)setUser:(WFUser *)user{
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:user.face_url]];
    [self.userIdLabel setText:user.uid];
    [self.nameLabel setText:[NSString stringWithFormat:@"昵称:%@",user.user_name]];
    [self.lifeCountLabel setTitle:@"生命力" number:[NSNumber numberWithInteger:user.life]];
    [self.articleCountLabel setTitle:@"文章" number:[NSNumber numberWithInteger:user.post_count]];
    [self.virtualCountLabel setTitle:@"积分" number:[NSNumber numberWithInteger:user.score]];
}

- (CGFloat)wf_padding_rightToContent{
    return 10*WFHeightScale;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
