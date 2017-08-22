//
//  WFManagementCell.m
//  WFByr
//
//  Created by 李向前 on 2017/8/19.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFManagementCell.h"
#import "WFManagementTableViewCellProtocal.h"
#import "UIImageView+Corner.h"

@interface WFManagementCell()<WFManagementTableViewCellProtocal>

@end
@implementation WFManagementCell{
    CALayer * _seperatorLineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.appearanceType = WFRowAppearanceTypeDefault;
        _seperatorLineView = [CALayer layer];
        _seperatorLineView.backgroundColor = WFMAIN_CELL_BORDER_GRAY.CGColor;
        [self.layer addSublayer:_seperatorLineView];
    }
    return self;
}

- (void)updateAppearance{
    [self.detailTextLabel setTextColor:MAIN_GRAY];
    [self.textLabel setTextColor:[UIColor blackColor]];
}

- (void)setUpCellWithImage:(NSString *)localImageName textStr:(NSString *)textStr{
    
}

#pragma mark -- WFManagementTableViewCellProtocal

- (CGFloat)wf_padding_leftToContent{
    return WFHeightScale*12.0;
}

- (CGFloat)wf_padding_rightToContent{
    return WFHeightScale*10.0;
}

- (CGFloat)wf_padding_topToContent{
    return WFHeightScale*6;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _seperatorLineView.frame = CGRectMake([self wf_padding_leftToContent], self.wf_Height, self.wf_Width - [self wf_padding_leftToContent], WFOnePixelHeight);
}

- (void)setAppearanceType:(WFRowAppearanceType)appearanceType{
    _appearanceType = appearanceType;
    [self updateAppearance];
}

@end

@implementation WFManagementSingleTextCell

- (void)updateAppearance{
    
}

@end

@implementation WFManagementSingleTextImageCell{
    UIView * _backgroundView;
}

- (void)setUpCellWithImage:(NSString *)localImageName color:(UIColor *)imageColor textStr:(NSString *)textStr{
    [self.tipImageView setImage:[UIImage imageNamed:localImageName]];
    [self.tipImageView wf_addColorCover:imageColor];
    [self.newtextLabel setText:textStr];
}

- (void)updateAppearance{
    CGFloat paddingLeftToContent = [self wf_padding_leftToContent];
    CGFloat paddingTopToContent = [self wf_padding_topToContent];
    CGFloat imageViewWidth = [self wf_imageview_width];
    
    [self.imageView removeFromSuperview];
    UIView * backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    _backgroundView = backgroundView;
    [self addSubview:_backgroundView];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(paddingLeftToContent, (self.wf_Height - imageViewWidth)/2, imageViewWidth, imageViewWidth)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tipImageView = imageView;
    [_backgroundView addSubview:_tipImageView];
    
    UILabel * newtextLabel = [[UILabel alloc]initWithFrame:CGRectMake(_tipImageView.wf_rightX + paddingTopToContent, 0, 190, self.wf_Height)];
    [newtextLabel setFont:[UIFont fontWithName:WFFontName size:15]];
    newtextLabel.textAlignment = NSTextAlignmentLeft;
    _newtextLabel = newtextLabel;
    [_backgroundView addSubview:_newtextLabel];
    
}

- (CGFloat)wf_imageview_width{
    return 24*WFHeightScale;
}

@end
