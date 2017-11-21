//
//  LoginDataModel.h
//  Noder
//
//  Created by 吴志刚 on 2017/11/20.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <Mantle/Mantle.h>

@class LoginRecent_replies;
@class LoginRecent_topics;
@class Author;

@interface LoginDataModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray *recent_replies;
@property (nonatomic, strong) NSArray *recent_topics;

@end

@interface LoginRecent_replies : MTLModel <MTLJSONSerializing>

@property (nonatomic ,strong) NSString *id;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *last_reply_at;
@property (nonatomic ,strong) Author *author;

@end

@interface LoginRecent_topics : MTLModel <MTLJSONSerializing>

@property (nonatomic ,strong) NSString *id;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *last_reply_at;
@property (nonatomic ,strong) Author *author;

@end


@interface Author : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSURL *avatar_url;

@end

