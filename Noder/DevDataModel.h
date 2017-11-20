//
//  DevDataModel.h
//  Noder
//
//  Created by 吴志刚 on 2017/11/20.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <Mantle/Mantle.h>

@class DevAuthor;

@interface DevDataModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *last_reply_at;
@property (nonatomic, strong) NSNumber *visit_count;
@property (nonatomic, strong) NSNumber *reply_count;
@property (nonatomic, strong) DevAuthor *author;
@property (nonatomic, strong) NSString *id;

@end

@interface DevAuthor : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSURL *avatar_url;

@end


