//
//  AskAPI.m
//  Noder
//
//  Created by alienware on 2017/8/25.
//  Copyright © 2017年 Apress. All rights reserved.
//

#import "AskAPI.h"
#import "AskDataModel.h"

@implementation AskAPI

- (NSString *)apiMethodName
{
   return @"api/v1/topics/?tab=ask";
}

- (LCRequestMethod)requestMethod
{
    return LCRequestMethodGet;
}

- (id)responseProcess:(id)responseObject
{
    NSArray *array = responseObject[@"data"];
    return [MTLJSONAdapter modelsOfClass:[AskDataModel class] fromJSONArray:array error:nil];
}

@end
