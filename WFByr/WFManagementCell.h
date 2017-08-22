//
//  WFManagementCell.h
//  WFByr
//
//  Created by 李向前 on 2017/8/19.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFManagementUtils.h"
#import "WFTableViewCell.h"

@interface WFManagementCell : WFTableViewCell

@property (nonatomic, assign) WFRowAppearanceType appearanceType;

// 指向基类的指针无法调用子类的方法，解决方式：暂时把WFManagementSingleTextImageCell里的方法写在父类里，但父类不做实际处理
- (void)setUpCellWithImage:(NSString *)localImageName color:(UIColor *)imageColor textStr:(NSString *)textStr;

@end

@interface WFManagementSingleTextCell : WFManagementCell

@end

@interface WFManagementSingleTextImageCell : WFManagementSingleTextCell

@property (nonatomic, strong) UIImageView * tipImageView;
@property (nonatomic, strong) UILabel * newtextLabel;

@end
