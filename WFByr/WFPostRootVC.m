//
//  WFPostRootVC.m
//  WFByr
//
//  Created by Andy on 2017/6/7.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFPostRootVC.h"





@interface WFPostRootVC () <UIViewControllerTransitioningDelegate>


@end


@implementation WFPostRootVC

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, 0, 100, 100);
    label.text = @"hello world";
    [self.view addSubview:label];
    self.transitioningDelegate = self;
    // Do any additional setup after loading the view.
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
