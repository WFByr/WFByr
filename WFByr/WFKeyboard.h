//
//  ASKeyboard.h
//  ASByrApp
//
//  Created by andy on 16/4/22.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "Masonry.h"
#import "WFModels.h"

@protocol WFKeyBoardDelegate <NSObject>

@optional

- (void)moreAction:(id) context;

- (void)sendAcionWithInput:(NSString *) input context:(id)context;

@end


@interface WFKeyboard : UIView

@property(weak, nonatomic) id<WFKeyBoardDelegate> delegate;

@property(strong, nonatomic) UITextView * textView;

@property(strong, nonatomic) UIButton * sendBtn;

@property(strong, nonatomic) UIButton * moreBtn;

@property(strong, nonatomic) NSDictionary * context;

- (void)pop;

- (void)popWithContext:(NSDictionary*) context;

- (void)hide;

@end
