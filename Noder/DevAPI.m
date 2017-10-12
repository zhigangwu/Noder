//
//  DevAPI.m
//  Noder
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "DevAPI.h"

@implementation DevAPI

- (NSString *)apiMethodName
{
   return @"api/v1/topics/?tab=dev";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

@end
