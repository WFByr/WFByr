//
//  ASAccessoryView.h
//  ASByrApp
//
//  Created by Andy on 2017/3/8.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFPostCommon.h"
#import <UIKit/UIKit.h>


@interface WFAccessoryView : UIToolbar

@property (nonatomic, copy) WFActionBlock addPhotoBlock;

@property (nonatomic, copy) WFActionBlock dismissBlock;

@property (nonatomic, copy) WFActionBlock addEmotionBlock;

@end
