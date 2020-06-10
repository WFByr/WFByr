//
//  WFAlertView.m
//  WFByr
//
//  Created by 李向前 on 2020/5/19.
//  Copyright © 2020 andy. All rights reserved.
//

#import "WFAlertView.h"
#import "WFAlertViewController.h"

static const CGFloat WFAlertViewMaxMessageHeight = 134;  //详情信息最大高度
static const CGFloat WFAlertViewMaxTitleHeight = 48;    //标题最大高度
static const NSInteger WFAlertViewButtonTag = 0x6667;
@interface WFAlertAction()

@property (nonatomic, copy, readwrite) NSString * title;
@property (nonatomic, assign, readwrite) WFAlertActionStyle style;
@property (nonatomic, copy) void(^handler)(WFAlertAction *);

@end

@implementation WFAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(WFAlertActionStyle)style handler:(void (^)(WFAlertAction *))handler{
    return [[self alloc]initWithTitle:title style:style handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title style:(WFAlertActionStyle)style handler:(void (^)(WFAlertAction *))handler{
    if (self = [super init]) {
        _title = title;
        _style = style;
        _handler = handler;
    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    WFAlertAction * action = [[WFAlertAction alloc]init];
    action.title = self.title;
    action.style = self.style;
    return action;
}

@end

@interface WFAlertView ()

@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) UIView * buttonContentView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UITextView * detailLabel;
@property (nonatomic, strong) UIScrollView * messageScrollView;
@property (nonatomic, strong) UITapGestureRecognizer * backgroundTapRecognizer;

@property (nonatomic, strong) NSMutableArray <WFAlertAction *> *actionArray;
@property (nonatomic, strong) NSMutableArray <UIButton *> *buttonArray;

//内容文本的对齐方式
@property (nonatomic, assign) NSTextAlignment contentTextAligment;

@property (nonatomic, assign) CGRect alertViewFrame;

@end

@implementation WFAlertView

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSAttributedString *)message{
    return [self alertViewWithTitle:title message:message backgoundTapDismissEnable:NO];
}

//添加可以自定义内容的对齐方式
+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSAttributedString *)message contentTextAligment:(NSTextAlignment)contentTextAligment{
    
    WFAlertView * view = [self alertViewWithTitle:title message:message backgoundTapDismissEnable:NO];
    view.contentTextAligment = contentTextAligment;
    return view;
}

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSAttributedString *)message backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable {
    WFAlertView * view = [[self alloc] alertViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 100, 216) title:title message:message];
    view.backgoundTapDismissEnable = backgoundTapDismissEnable;
    return view;
}

- (instancetype)alertViewWithFrame:(CGRect)frame title:(NSString *)title message:(NSAttributedString *)message {
    if (self == [self initWithFrame:frame]) {
        [self configurePropertiesWithTitle:title message:message];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _backgoundTapDismissEnable = NO;
        _alertViewFrame = frame;
        [self addContentViews];
    }
    return self;
}


- (void)addHorizontalAction:(WFAlertAction *)action{
    if ([_actionArray count] >= 2) {
        return;
    }
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:MAIN_BLUE forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsZero];
    button.tag = WFAlertViewButtonTag + _buttonArray.count + 1;
    switch (action.style) {
        case UIAlertActionStyleDefault:
            [button setTitleColor:MAIN_GRAY forState:UIControlStateNormal];
        case UIAlertActionStyleCancel:
            [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
            break;
        case UIAlertActionStyleDestructive:
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
            break;
        default:
            break;
    }
    [button setTitle:action.title forState:UIControlStateNormal];
    [button sizeToFit];
    
    [button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonContentView addSubview:button];
    [_buttonArray addObject:button];
    [_actionArray addObject:action];
    
    [self layoutButtons];
}


#pragma mark -- private method
- (void)addContentViews {
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [_backgroundView setBackgroundColor:[UIColor whiteColor]];
    [_backgroundView.layer setCornerRadius:10];
    [self addSubview:_backgroundView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 7.5, self.width, 28)];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [_titleLabel setNumberOfLines:1];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_titleLabel];
    
    _detailLabel = [[UITextView alloc] initWithFrame:CGRectZero];
    _detailLabel.editable = NO;
    [_detailLabel setFont:[UIFont systemFontOfSize:14]];
    [_detailLabel setTextAlignment:NSTextAlignmentCenter];
    [_detailLabel setTextColor:MAIN_BLUE];
    [self addSubview:_detailLabel];
    
    _buttonContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 18, self.width, 25)];
    _buttonContentView.userInteractionEnabled = YES;
    [self addSubview:_buttonContentView];
    
    _buttonArray = [NSMutableArray array];
    _actionArray = [NSMutableArray array];
}

- (void)configurePropertiesWithTitle:(NSString *)title message:(NSAttributedString *)message {
    if (title == nil || [title isEqualToString:@""]) {
        _titleLabel.height = 0;
        self.height -= 28;
    }else{
        CGFloat titleHeight = [title heightByWidth:self.width font:[UIFont boldSystemFontOfSize:20] lineSpacing:[NSParagraphStyle defaultParagraphStyle].lineSpacing alignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByCharWrapping];
        if (titleHeight < WFAlertViewMaxTitleHeight && titleHeight > 28) {
            _titleLabel.numberOfLines = 2;  //最多两行
            self.height += _titleLabel.height - 28;
            [_titleLabel setSize:CGSizeMake(self.width, titleHeight)];
        }else if(titleHeight >= WFAlertViewMaxTitleHeight){
            _titleLabel.numberOfLines = 2;  //最多两行
            self.height += WFAlertViewMaxTitleHeight - 28;
            [_titleLabel setSize:CGSizeMake(self.width, WFAlertViewMaxTitleHeight)];
        }
        [_titleLabel setText:title];
    }
    
    CGFloat messageHeight = [message.string heightByWidth:(self.width - 35.5) font:_detailLabel.font lineSpacing:[NSParagraphStyle defaultParagraphStyle].lineSpacing alignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByCharWrapping];
    [_detailLabel setSize:CGSizeMake(self.width - 35.5, messageHeight)];
    _detailLabel.contentSize = CGSizeMake(self.width - 35.5, messageHeight);
    _detailLabel.left = 20;
    [_detailLabel setAttributedText:message];
    
    if (messageHeight < WFAlertViewMaxMessageHeight && messageHeight > 20) {
        self.height += messageHeight - 20;
    }else if(messageHeight >= WFAlertViewMaxMessageHeight){  //嵌入scrollView
        [self.messageScrollView setContentSize:CGSizeMake(self.width, messageHeight)];
        [_detailLabel removeFromSuperview];
        [self.messageScrollView addSubview:_detailLabel];
        [self addSubview:self.messageScrollView];
        self.height += WFAlertViewMaxMessageHeight - 20;
    }
}

#pragma mark -- button
- (void)layoutButtons {
    if ([_buttonArray count] == 1) {
        UIButton * button = _buttonArray.firstObject;
        button.width = fmin(fmax(self.width*0.67,button.width),self.width-20); //控制button宽度
        [button setCenter:CGPointMake(_buttonContentView.centerX, _buttonContentView.height/2)];
    }else if([_buttonArray count] == 2){
        UIButton * firstButton = _buttonArray.firstObject;
        UIButton * lastButton = _buttonArray.lastObject;
        CGFloat buttonWidth = (_buttonContentView.width - 47.1)/2;
        [firstButton setFrame:CGRectMake(10, 0, buttonWidth, _buttonContentView.height)];
        [lastButton setFrame:CGRectMake(firstButton.right + 27.1, 0, buttonWidth, _buttonContentView.height)];
    }
}

- (void)actionButtonClicked:(UIButton *)button{
    WFAlertAction * action = _actionArray[button.tag - WFAlertViewButtonTag - 1];
    if (action.handler) {
        action.handler(action);
    }
}



#pragma mark -- lifecycle
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.frame = _alertViewFrame;
    _backgroundView.height = self.height;
    
    [_titleLabel setCenterX:self.width/2];
    
    if (_messageScrollView) {
        _messageScrollView.top = _titleLabel.bottom + 3.5;
        _detailLabel.top = 0;
    } else {
        _detailLabel.top = _titleLabel.bottom + 3.5;
    }
    
    _buttonContentView.bottom = self.height - 16;
}

#pragma mark -- getters and setters
- (UIScrollView *)messageScrollView{
    if (!_messageScrollView) {
        _messageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _titleLabel.bottom + 3.5, self.width, WFAlertViewMaxMessageHeight)];
        _messageScrollView.bounces = NO;
    }
    return _messageScrollView;
}

- (void)setBackgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable{
    _backgoundTapDismissEnable = backgoundTapDismissEnable;
    _backgroundTapRecognizer.enabled = _backgoundTapDismissEnable;
}

- (void)setContentTextAligment:(NSTextAlignment)contentTextAligment{
    _contentTextAligment = contentTextAligment;
    _detailLabel.textAlignment = contentTextAligment;
}

@end
