//
//  XQByrArticle.h
//  Pods
//
//  Created by lxq on 1/4/17.
//
//

#import <Foundation/Foundation.h>

@class WFAttachment,WFFile,WFUser;

@interface WFArticle : NSObject


@property (nonatomic, copy) NSString *board_description;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *threads_previous_id;

@property (nonatomic, assign) NSInteger group_id;

@property (nonatomic, assign) NSInteger position;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger post_time;

@property (nonatomic, copy) NSString *like_sum;

@property (nonatomic, assign) NSInteger previous_id;

@property (nonatomic, assign) BOOL is_liked;

@property (nonatomic, copy) NSString *flag;

@property (nonatomic, assign) BOOL has_attachment;

@property (nonatomic, assign) BOOL is_top;

@property (nonatomic, assign) NSInteger aid;

@property (nonatomic, strong) WFUser *user;

@property (nonatomic, assign) NSInteger reply_id;

@property (nonatomic, assign) BOOL is_admin;

@property (nonatomic, assign) NSInteger threads_next_id;

@property (nonatomic, assign) NSInteger next_id;

@property (nonatomic, strong) WFAttachment *attachment;

@property (nonatomic, copy) NSString *board_name;

@property (nonatomic, assign) BOOL is_subject;

//存在于/threads/:name/:id
@property (nonatomic, strong) NSArray<WFArticle *> *article;

//下面几项只存在于/board/:name，/threads/:board/:id和/search/threads中
@property (nonatomic, assign) NSInteger reply_count;

@property (nonatomic, copy) NSString *last_reply_user_id;

@property (nonatomic, assign) NSInteger last_reply_time;

@property (nonatomic, assign) NSInteger id_count;

@end
