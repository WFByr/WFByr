//
//  WFReachabilityVC.m
//  WFByr
//
//  Created by Andy on 2017/6/28.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFReachabilityVC.h"

@interface WFReachabilityVC ()

@end

@implementation WFReachabilityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)retryBtnClicked:(id)sender {
    if (wf_checkByrReachable()) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
