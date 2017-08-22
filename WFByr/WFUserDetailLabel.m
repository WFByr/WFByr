//
//  WFUserDetailLabel.m
//  WFByr
//
//  Created by 李向前 on 2017/8/16.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFUserDetailLabel.h"

@interface WFUserDetailLabel()

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * numberLabel;

@end

@implementation WFUserDetailLabel{
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.numberLabel];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.wf_Width-10*2, self.wf_Height/2-6)];
        _titleLabel.font = [UIFont fontWithName:WFMeFontBoldName size:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.wf_Height/2-6, self.wf_Width-10*2, self.wf_Height/2-2)];
        _numberLabel.font = [UIFont fontWithName:WFMeFontRegularName size:12];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.numberOfLines = 1;
        _numberLabel.adjustsFontSizeToFitWidth = YES;
        _numberLabel.minimumScaleFactor = .9f;
    }
    return _numberLabel;
}

- (void)setTitle:(NSString *)title number:(NSNumber *)number{
    [_numberLabel setText:title];
    [_titleLabel setText:[NSString stringWithFormat:@"%@",number]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
