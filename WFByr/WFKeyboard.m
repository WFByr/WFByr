//
//  ASKeyboard.m
//  ASByrApp
//
//  Created by andy on 16/4/22.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFKeyboard.h"

static const NSInteger WFKeyboardHeight = 42;
@interface WFKeyboard()

@end


@implementation WFKeyboard

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, WFSCREEN_H - WFKeyboardHeight - WFByrIPhoneXBottomGap, WFSCREEN_W, WFKeyboardHeight + WFByrIPhoneXBottomGap)];
    if (self) {
        [self setupUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    // add subviews into inputview
    [self addSubview:self.textView];
    [self addSubview:self.sendBtn];
    [self addSubview:self.moreBtn];
    self.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    // add subviews into pluginview
    
    
    // add subviews into pluginview
}

- (void)updateConstraints {
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.bottom.equalTo(self).offset(- 8 - WFByrIPhoneXBottomGap);
        make.leading.equalTo(self).offset(8);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.bottom.equalTo(self.mas_bottom).offset(-8 - WFByrIPhoneXBottomGap);
        make.leading.equalTo(self.textView.mas_trailing).offset(8);
        make.width.equalTo(self.moreBtn.mas_height);
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.trailing.equalTo(self.mas_trailing).offset(-8);
        make.bottom.equalTo(self.mas_bottom).offset(-8 - WFByrIPhoneXBottomGap);
        make.leading.equalTo(self.moreBtn.mas_trailing).offset(8);
    }];
    
    [super updateConstraints];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat newY = keyboardRect.origin.y - self.bounds.size.height;
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

# pragma mark - public method

- (void)pop {
    [self.textView becomeFirstResponder];
}

- (void)popWithContext:(NSDictionary *)context {
    self.context = context;
    [self pop];
}

- (void)hide {
    [self.textView resignFirstResponder];
}

- (void)sendBtnClick {
    [self hide];
    [self.delegate sendAcionWithInput:self.textView.text context:self.context];
}

- (void)moreBtnClick {
    NSMutableDictionary *tmp = [self.context mutableCopy];
    tmp[@"currentInput"] = self.textView.text;
    
    [self hide];
    [self.delegate moreAction:[tmp copy]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - getters and setters

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        [_textView setFont:[UIFont systemFontOfSize:15.0]];
        [_textView.layer setBorderWidth:1.0];
        [_textView.layer setCornerRadius:4.0];
        [_textView.layer setBorderColor:MAIN_BLUE.CGColor];
    }
    return _textView;
}

- (UIButton *)sendBtn {
    if (_sendBtn == nil) {
        _sendBtn = [[UIButton alloc] init];
        [_sendBtn setTitle:@" 发送 " forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_sendBtn setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateHighlighted];
        [_sendBtn setTitleColor:MAIN_BLUE forState:UIControlStateNormal];
        [_sendBtn.layer setCornerRadius:2.0];
        
    }
    return _sendBtn;
}


- (UIButton *)moreBtn {
    if (_moreBtn == nil) {
        _moreBtn = [[UIButton alloc] init];
        [_moreBtn setBackgroundImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        _moreBtn.tintColor = MAIN_BLUE;
        [_moreBtn addTarget:self.delegate action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}



@end
