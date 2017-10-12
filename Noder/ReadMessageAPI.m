//
//  ReadMessageAPI.m
//  Noder
//
//  Created by Mac on 2017/9/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ReadMessageAPI.h"

@implementation ReadMessageAPI

- (NSString *)apiMethodName
{
    return @"api/v1/message";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

@end
