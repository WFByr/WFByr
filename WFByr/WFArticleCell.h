//
//  WFArticleCell.h
//  WFByr
//
//  Created by Andy on 2017/6/2.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFArticle;

@interface WFArticleCell : UITableViewCell
- (void)setupWithArticle:(WFArticle*)article;
@end
