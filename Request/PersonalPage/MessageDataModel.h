//
//  MessageDataModel.h
//  Noder
//
//  Created by 吴志刚 on 22/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <Mantle/Mantle.h>

@class Has_read_messages;
@class Hasnot_read_messages;
@class MessAuthor;
@class MessTopic;
@class MessReply;

@interface MessageDataModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray *has_read_messages;
@property (nonatomic, strong) NSArray *hasnot_read_messages;

@end

@interface Has_read_messages : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) BOOL has_read;
@property (nonatomic, strong) NSString *create_at;
@property (nonatomic, strong) MessAuthor *author;
@property (nonatomic, strong) MessTopic *topic;
@property (nonatomic, strong) MessReply *reply;

@end

@interface Hasnot_read_messages : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) BOOL has_read;
@property (nonatomic, strong) NSString *create_at;
@property (nonatomic, strong) MessAuthor *author;
@property (nonatomic, strong) MessTopic *topic;
@property (nonatomic, strong) MessReply *reply;

@end


@interface MessAuthor : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *loginname;
@property (nonatomic, strong) NSURL *avatar_url;

@end

@interface MessTopic : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *last_reply_at;

@end

@interface MessReply : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *create_at;

@end













