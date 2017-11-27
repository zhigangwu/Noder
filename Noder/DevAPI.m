//
//  DevAPI.m
//  Noder
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "DevAPI.h"
#import "DevDataModel.h"

@implementation DevAPI

- (NSString *)apiMethodName
{
   return @"api/v1/topics/?tab=dev";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

- (id)responseProcess:(id)responseObject
{
    NSArray *array = responseObject[@"data"];
    return [MTLJSONAdapter modelsOfClass:[DevDataModel class] fromJSONArray:array error:nil];
}

@end
