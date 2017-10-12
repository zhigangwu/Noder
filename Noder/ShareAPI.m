//
//  ShareAPI.m
//  Noder
//
//  Created by alienware on 2017/8/25.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ShareAPI.h"

@implementation ShareAPI

- (NSString *)apiMethodName
{
   return @"api/v1/topics/?tab=share";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

@end
