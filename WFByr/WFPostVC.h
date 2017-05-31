//
//  NewInputVC.h
//  ASByrApp
//
//  Created by Andy on 2017/3/10.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFArticle;
@interface WFPostVC : UIViewController

- (instancetype)initWithReplyArticle:(WFArticle*) article;

- (instancetype)initWithReplyArticle:(WFArticle *)article input:(NSString*)input;

@end
