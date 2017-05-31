//
//  ASEmotionInput.h
//  ASByrApp
//
//  Created by Andy on 2017/3/15.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFPostCommon.h"
#import <UIKit/UIKit.h>

@interface WFEmotionCell : UICollectionViewCell

- (void)setEmotion:(NSString*) imgName;

@end

@interface WFEmotionInput : UIView

@property (nonatomic, copy) WFActionBlock addEmotionBlock;

@end
