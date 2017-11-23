//
//  MessageCountAPI.m
//  Noder
//
//  Created by 吴志刚 on 23/11/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "MessageCountAPI.h"

@implementation MessageCountAPI

- (NSString *)apiMethodName
{
    return @"api/v1/message/count";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

@end
