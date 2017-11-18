//
//  Topic.h
//  Noder
//
//  Created by 吴志刚 on 2017/11/18.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import <Mantle/Mantle.h>

@class Author;

@interface Topic : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) Author *author;
@property (nonatomic, strong) NSString *


@end



@interface Author : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSURL *avatar_url;



@end

