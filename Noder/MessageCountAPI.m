
//
//  MessageCountAPI.m
//  Noder
//
//  Created by Mac on 2017/10/14.
//  Copyright © 2017年 Apress. All rights reserved.
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
