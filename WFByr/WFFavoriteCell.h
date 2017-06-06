//
//  WFFavoriteCell.h
//  WFByr
//
//  Created by lixiangqian on 17/6/2.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFCollection;

extern const CGFloat WFProfileImageWidth;
extern const CGFloat WFPaddingToContentview;
extern const CGFloat WFPaddingWithin;
extern const CGFloat WFDistractorHeight;

@interface WFFavoriteCell : UITableViewCell

@property (strong, nonatomic) UIView *wapUpView;
@property (strong, nonatomic) UIView *wapDownView;
@property (strong, nonatomic) UIView *wapView;

@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UILabel * boardNameLabel;
//@property (strong, nonatomic) UIImageView * firstImageView;
@property (strong, nonatomic) UIImageView * userImageView;
@property (strong, nonatomic) UILabel * userNameLabel;
//@property (strong, nonatomic) UILabel * replyCount;

- (void)setUpParameters:(WFCollection *)collection;

@end
