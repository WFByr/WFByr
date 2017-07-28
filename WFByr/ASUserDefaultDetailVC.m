//
//  ASUserDefaultDetail.m
//  WFByr
//
//  Created by Andy on 2017/7/29.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "ASUserDefaultDetailVC.h"

@interface ASUserDefaultDetailVC ()

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic) NSString *key;
@end

@implementation ASUserDefaultDetailVC

- (instancetype)initWithKey:(NSString *)key {
    self = [super init];
    if (self) {
        _key = key;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    _textView = [UITextView new];
    [self.view addSubview:_textView];
    _textView.frame = self.view.bounds;
    _textView.text = [[NSUserDefaults standardUserDefaults] objectForKey:_key];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
