//
//  AllViewDataModel.h
//  Noder
//
//  Created by 吴志刚 on 2017/11/19.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <Mantle/Mantle.h>

@class ALLAuthor;

@interface AllViewDataModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *visit_count;
@property (nonatomic, strong) NSNumber *reply_count;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) BOOL good;
@property (nonatomic, assign) BOOL top;
@property (nonatomic, strong) NSString *last_reply_at;
@property (nonatomic, strong) ALLAuthor *author;

@end

@interface ALLAuthor : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSURL *avatar_url;
@property (nonatomic, strong) NSString *loginname;

@end

