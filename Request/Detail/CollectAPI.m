//
//  CollectAPI.m
//  Noder
//
//  Created by 吴志刚 on 09/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "CollectAPI.h"

@implementation CollectAPI

- (NSString *)apiMethodName
{
    return @"api/v1/topic_collect/collect";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodPost;
}

@end
