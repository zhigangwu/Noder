//
//  De_collectAPI.m
//  Noder
//
//  Created by 吴志刚 on 10/12/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "De_collectAPI.h"

@implementation De_collectAPI

- (NSString *)apiMethodName
{
    return @"api/v1/topic_collect/de_collect";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodPost;
}

@end
