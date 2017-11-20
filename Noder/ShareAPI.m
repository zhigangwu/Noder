//
//  ShareAPI.m
//  Noder
//
//  Created by alienware on 2017/8/25.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "ShareAPI.h"
#import "ShareDataModel.h"

@implementation ShareAPI

- (NSString *)apiMethodName
{
   return @"api/v1/topics/?tab=share";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

- (id)responseProcess:(id)responseObject
{
    NSArray *array = responseObject[@"data"];
    return [MTLJSONAdapter modelsOfClass:[ShareDataModel class] fromJSONArray:array error:nil];
}

@end
