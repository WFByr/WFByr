//
//  ASTop10Cell.h
//  ASByrApp
//
//  Created by andy on 16/4/6.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFArticle;

@interface WFTop10Cell : UITableViewCell

@property (nonatomic, readonly) NSString * reuseId;

- (void)setupWithArticle:(WFArticle*)article
                     num:(NSUInteger)num;
    
@end
