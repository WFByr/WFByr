//
//  WFByrConst.h
//  WFByr
//
//  Created by Andy on 2017/5/25.
//  Copyright © 2017年 andy. All rights reserved.
//

#ifndef WFByrConst_h
#define WFByrConst_h

#import <Foundation/Foundation.h>

static NSString * const WFByrBaseUrl = @"http://bbs.byr.cn/open/";

static NSString * const WFReturnFormat = @".json";

static NSString * const WFHTTPGet    = @"GET";
static NSString * const WFHTTPPost   = @"POST";

static NSString * const WFByrArticleUrl    = @"article";
static NSString * const WFByrThreadsUrl    = @"threads";
static NSString * const WFByrAttachmentUrl = @"attachment";
static NSString * const WFByrBlacklist     = @"blacklist";
static NSString * const WFByrBoardUrl      = @"board";
static NSString * const WFByrSectionUrl    = @"section";
static NSString * const WFByrCollectionUrl = @"collection";
static NSString * const WFByrFavoriteUrl   = @"favorite";
static NSString * const WFByrMailUrl       = @"mail";
static NSString * const WFByrReferUrl      = @"refer";
static NSString * const WFByrSearchUrl     = @"search";
static NSString * const WFByrUserUrl       = @"user";
static NSString * const WFByrVoteUrl       = @"vote";
static NSString * const WFByrWidgetUrl     = @"widget";

static NSString *const WFByrNetworkFailureNotification = @"WFByrNetworkFailureNotification";
static NSString *const WFByrNetworkAccessTokenFailureCode = @"1703";
static NSString *const WFByrNetworkFailureCodeKey = @"code";


#endif /* WFByrConst_h */
