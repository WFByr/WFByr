//
//  ASUserDefaultDetail.m
//  WFByr
//
//  Created by Andy on 2017/7/29.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "ASUserDefaultDetailVC.h"

@interface ASUserDefaultDetailVC ()

@property (nonatomic, strong) UITextField *textField;
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
    [self setupNavi];
    [self setupTextView];
}

- (void)setupNavi {
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    if (_key) {
        _textField.text = _key;
    }
    
    self.navigationItem.titleView = _textField;
    

    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)], [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(delete)]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
}

- (void)setupTextView {
    _textView = [UITextView new];
    [self.view addSubview:_textView];
    _textView.frame = self.view.bounds;
    if (_key && ![_key isEqualToString:@""]) {
        _textView.text = [[NSUserDefaults standardUserDefaults] objectForKey:_key];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save {
    [[NSUserDefaults standardUserDefaults] setObject:_textView.text forKey:_textField.text];
    wf_showHud(self.view, @"保存成功", 1);
}

- (void)delete {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:_key];
    wf_showHud(self.view, @"删除成功", 1);
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
