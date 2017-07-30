//
//  ASTop10RootVC.m
//  ASByrApp
//
//  Created by andy on 16/4/1.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WFTop10RootVC.h"
#import "WFTop10ListVC.h"
//#import "WFLoginController.h"
#import "WFTop10ManageVC.h"
#import "WFTop10Manager.h"
#import "WFToken.h"
#import "WMPageController.h"
#import "Masonry.h"

@interface WFTop10RootVC()<WMPageControllerDelegate, WMPageControllerDataSource>

@property(nonatomic, strong) UIBarButtonItem *manageTop10Btn;

@property(nonatomic, strong) NSArray * controllers;

@property(nonatomic, strong) NSArray * menuItems;

@property(nonatomic, strong) WFTop10Manager * top10Manager;
@end

@implementation WFTop10RootVC

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTitlesAndControllers];
        self.showOnNavigationBar = YES;
        //self.menuBGColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
        self.titleColorSelected = MAIN_BLUE;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.manageTop10Btn;
    self.dataSource = self;
    self.delegate = self;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"十大";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) setupTitlesAndControllers {
    NSMutableArray *controllers = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    self.top10Manager = [[WFTop10Manager alloc] init];
    for (int i = 0; i < [self.top10Manager shownItemsCount]; ++i) {
        WFTop10ManageItem * item = [self.top10Manager shownObjectAtIndex:i];
        [controllers addObject:[[WFTop10ListVC alloc] initWithTitle:item.name top10Type:item.type sectionNo:item.section]];
        [titles addObject:item.name];
    }
    self.controllers = controllers;
    self.menuItems   = titles;
}

- (void)reloadData {
    [self setupTitlesAndControllers];
    [super reloadData];
}


#pragma mark - WMPageControllerDataSource

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return [self.menuItems count];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return self.controllers[index];
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return [self.menuItems objectAtIndex:index];
}

#pragma mark - WMPageControllerDelegate
- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    //ASBasicArticleListController* tmp = viewController;
    //[tmp loadIfNotLoaded];
}

#pragma mark - event reponser

- (void)manageTop10 {
    WFTop10ManageVC *tmp = [[WFTop10ManageVC alloc] init];
    tmp.rootVC = self;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:tmp]
                       animated:YES
                     completion:nil];
}

#pragma mark - getter and setter

- (UIBarButtonItem *)manageTop10Btn {
    if (_manageTop10Btn == nil) {
        _manageTop10Btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                        target:self
                                                                        action:@selector(manageTop10)];
    }
    return _manageTop10Btn;
}

@end
