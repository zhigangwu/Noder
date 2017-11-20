//
//  JobAPI.m
//  Noder
//
//  Created by alienware on 2017/8/25.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "JobAPI.h"
#import "JobDataModel.h"

@implementation JobAPI

- (NSString *)apiMethodName
{
  return @"api/v1/topics/?tab=job";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

- (id)responseProcess:(id)responseObject
{
    NSArray *array = responseObject[@"data"];
    return [MTLJSONAdapter modelOfClass:[JobDataModel class] fromJSONDictionary:array error:nil];
}

@end
