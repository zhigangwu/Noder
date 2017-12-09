//
//  DetailDataModel.h
//  Noder
//
//  Created by 吴志刚 on 22/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <Mantle/Mantle.h>

@class DetailAuthor;
@class DetailReplies;
@class RepliesAuthor;

@interface DetailDataModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *reply_count;
@property (nonatomic, strong) NSNumber *visit_count;
@property (nonatomic, strong) NSString *create_at;
@property (nonatomic, strong) DetailAuthor *author;
@property (nonatomic, strong) NSArray *replies;

@end

@interface DetailAuthor : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *loginname;
@property (nonatomic, strong) NSURL *avatar_url;

@end

@interface DetailReplies : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *reply_id;
@property (nonatomic, strong) NSString *create_at;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *ups;
@property (nonatomic, assign) BOOL is_uped;
@property (nonatomic, strong) RepliesAuthor *author;

@end

@interface RepliesAuthor : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *loginname;
@property (nonatomic, strong) NSURL *avatar_url;

@end





